package com.techhub.repository;

import com.techhub.entity.InstanceQuestion;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class InstanceQuestionRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<InstanceQuestion> instanceQuestionRowMapper;

    public InstanceQuestionRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.instanceQuestionRowMapper = (rs, rowNum) -> {
            InstanceQuestion iq = new InstanceQuestion();
            iq.setInstanceId(rs.getLong("instance_id"));
            iq.setQuestionId(rs.getLong("question_id"));
            iq.setQuestionOrder(rs.getInt("question_order"));
            iq.setUserAnswer(rs.getString("user_answer"));
            iq.setIsCorrect(rs.getBoolean("is_correct"));
            iq.setTimeTakenSeconds(rs.getInt("time_taken_seconds"));
            return iq;
        };
    }

    public void save(InstanceQuestion instanceQuestion) {
        String sql = "INSERT INTO instance_questions (instance_id, question_id, question_order, user_answer, is_correct, time_taken_seconds) " +
                     "VALUES (?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE user_answer = VALUES(user_answer), is_correct = VALUES(is_correct), time_taken_seconds = VALUES(time_taken_seconds)";
        jdbcTemplate.update(sql,
                instanceQuestion.getInstanceId(),
                instanceQuestion.getQuestionId(),
                instanceQuestion.getQuestionOrder(),
                instanceQuestion.getUserAnswer(),
                instanceQuestion.getIsCorrect(),
                instanceQuestion.getTimeTakenSeconds());
    }

    public List<InstanceQuestion> findByInstanceId(Long instanceId) {
        String sql = "SELECT * FROM instance_questions WHERE instance_id = ? ORDER BY question_order ASC";
        return jdbcTemplate.query(sql, instanceQuestionRowMapper, instanceId);
    }

    public void deleteByInstanceId(Long instanceId) {
        String sql = "DELETE FROM instance_questions WHERE instance_id = ?";
        jdbcTemplate.update(sql, instanceId);
    }
}
