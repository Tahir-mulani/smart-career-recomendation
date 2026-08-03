package com.techhub.repository;

import com.techhub.entity.AssessmentSubmission;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public class AssessmentSubmissionRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<AssessmentSubmission> submissionRowMapper;

    public AssessmentSubmissionRepository(JdbcTemplate jdbcTemplate) {

        this.jdbcTemplate = jdbcTemplate;

        this.submissionRowMapper = (rs, rowNum) -> {

            AssessmentSubmission submission = new AssessmentSubmission();

            submission.setId(rs.getLong("id"));
            submission.setUserId(rs.getLong("user_id"));
            submission.setAssessmentId(rs.getLong("assessment_id"));
            submission.setSubmittedAt(rs.getTimestamp("submitted_at").toLocalDateTime());

            String sql = "SELECT question_id, selected_answer FROM submission_answers WHERE submission_id = ?";

            List<Map<String, Object>> answersList = jdbcTemplate.queryForList(sql, submission.getId());

            for (Map<String, Object> answer : answersList) {

                Long questionId = ((Number) answer.get("question_id")).longValue();

                String selectedAnswer = (String) answer.get("selected_answer");

                submission.getAnswers().put(questionId, selectedAnswer);
            }

            return submission;
        };
    }

    public AssessmentSubmission save(AssessmentSubmission submission) {

        if (submission.getId() == null) {

            String sql = "INSERT INTO assessment_submissions (user_id, assessment_id, submitted_at) VALUES (?, ?, ?)";

            KeyHolder keyHolder = new GeneratedKeyHolder();

            jdbcTemplate.update(connection -> {

                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});

                ps.setLong(1, submission.getUserId());
                ps.setLong(2, submission.getAssessmentId());
                ps.setTimestamp(3, Timestamp.valueOf(submission.getSubmittedAt()));

                return ps;

            }, keyHolder);

            Long generatedId = keyHolder.getKey().longValue();

            submission.setId(generatedId);

        } else {

            String sql = "UPDATE assessment_submissions SET user_id = ?, assessment_id = ?, submitted_at = ? WHERE id = ?";

            jdbcTemplate.update(
                    sql,
                    submission.getUserId(),
                    submission.getAssessmentId(),
                    submission.getSubmittedAt(),
                    submission.getId()
            );

            String deleteSql = "DELETE FROM submission_answers WHERE submission_id = ?";

            jdbcTemplate.update(deleteSql, submission.getId());
        }

        saveAnswers(submission.getId(), submission.getAnswers());

        Optional<AssessmentSubmission> optionalSubmission = findById(submission.getId());

        if (optionalSubmission.isPresent()) {
            return optionalSubmission.get();
        }

        throw new RuntimeException("Assessment Submission not found.");
    }

    private void saveAnswers(Long submissionId, Map<Long, String> answers) {

        String sql = "INSERT INTO submission_answers (submission_id, question_id, selected_answer) VALUES (?, ?, ?)";

        for (Map.Entry<Long, String> entry : answers.entrySet()) {

            Long questionId = entry.getKey();

            String selectedAnswer = entry.getValue();

            jdbcTemplate.update(
                    sql,
                    submissionId,
                    questionId,
                    selectedAnswer
            );
        }
    }

    public Optional<AssessmentSubmission> findById(Long id) {

        String sql = "SELECT * FROM assessment_submissions WHERE id = ?";

        List<AssessmentSubmission> submissions = jdbcTemplate.query(sql, submissionRowMapper, id);

        if (submissions.isEmpty()) {
            return Optional.empty();
        }

        AssessmentSubmission submission = submissions.get(0);

        return Optional.of(submission);
    }

    public List<AssessmentSubmission> findAll() {

        String sql = "SELECT * FROM assessment_submissions";

        List<AssessmentSubmission> submissions = jdbcTemplate.query(sql, submissionRowMapper);

        return submissions;
    }

    public void deleteById(Long id) {

        String deleteAnswersSql = "DELETE FROM submission_answers WHERE submission_id = ?";

        jdbcTemplate.update(deleteAnswersSql, id);

        String deleteSubmissionSql = "DELETE FROM assessment_submissions WHERE id = ?";

        jdbcTemplate.update(deleteSubmissionSql, id);
    }
}