package com.techhub.repository;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.techhub.entity.Question;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class QuestionRepository {

    private final JdbcTemplate jdbcTemplate;

    public QuestionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Question> questionRowMapper = (rs, rowNum) -> {
        Question question = new Question();
        question.setId(rs.getLong("id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setOptionA(rs.getString("option_a"));
        question.setOptionB(rs.getString("option_b"));
        question.setOptionC(rs.getString("option_c"));
        question.setOptionD(rs.getString("option_d"));
        question.setCorrectAnswer(rs.getString("correct_answer"));
        question.setDifficultyLevel(rs.getString("difficulty_level"));
        question.setSkillTag(rs.getString("skill_tag"));
        question.setAssessmentId(rs.getLong("assessment_id"));
        return question;
    };

    public Question save(Question question) {
        if (question.getId() == null) {
            String sql = "INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty_level, skill_tag, assessment_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, question.getQuestionText());
                ps.setString(2, question.getOptionA());
                ps.setString(3, question.getOptionB());
                ps.setString(4, question.getOptionC());
                ps.setString(5, question.getOptionD());
                ps.setString(6, question.getCorrectAnswer());
                ps.setString(7, question.getDifficultyLevel());
                ps.setString(8, question.getSkillTag());
                ps.setLong(9, question.getAssessmentId());
                return ps;
            }, keyHolder);
            question.setId(keyHolder.getKey().longValue());
            return question;
        } else {
            String sql = "UPDATE questions SET question_text = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_answer = ?, difficulty_level = ?, skill_tag = ?, assessment_id = ? WHERE id = ?";
            jdbcTemplate.update(sql, question.getQuestionText(), question.getOptionA(), question.getOptionB(), 
                              question.getOptionC(), question.getOptionD(), question.getCorrectAnswer(), 
                              question.getDifficultyLevel(), question.getSkillTag(), question.getAssessmentId(), question.getId());
            return findById(question.getId()).orElseThrow();
        }
    }

    public Optional<Question> findById(Long id) {
        String sql = "SELECT * FROM questions WHERE id = ?";
        return jdbcTemplate.query(sql, questionRowMapper, id).stream().findFirst();
    }

    public List<Question> findByAssessmentId(Long assessmentId) {
        String sql = "SELECT * FROM questions WHERE assessment_id = ?";
        return jdbcTemplate.query(sql, questionRowMapper, assessmentId);
    }

    public List<Question> findAll() {
        String sql = "SELECT * FROM questions";
        return jdbcTemplate.query(sql, questionRowMapper);
    }

    public long countByAssessmentId(Long assessmentId) {
        String sql = "SELECT COUNT(*) FROM questions WHERE assessment_id = ?";
        Long count = jdbcTemplate.queryForObject(sql, Long.class, assessmentId);
        return count != null ? count : 0;
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM questions WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
