package com.techhub.repository;

import com.techhub.entity.AssessmentInstance;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class AssessmentInstanceRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<AssessmentInstance> instanceRowMapper;

    public AssessmentInstanceRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.instanceRowMapper = (rs, rowNum) -> {
            AssessmentInstance instance = new AssessmentInstance();
            instance.setId(rs.getLong("id"));
            instance.setUserId(rs.getLong("user_id"));
            long asmId = rs.getLong("assessment_id");
            instance.setAssessmentId(rs.wasNull() ? null : asmId);
            instance.setGeneratedAt(rs.getTimestamp("generated_at"));
            instance.setStartedAt(rs.getTimestamp("started_at"));
            instance.setCompletedAt(rs.getTimestamp("completed_at"));
            instance.setDurationActual(rs.getInt("duration_actual"));
            instance.setTotalQuestions(rs.getInt("total_questions"));
            instance.setScore(rs.getInt("score"));
            instance.setPercentage(rs.getDouble("percentage"));
            instance.setStatus(rs.getString("status"));
            return instance;
        };
    }

    public AssessmentInstance save(AssessmentInstance instance) {
        if (instance.getId() == null) {
            String sql = "INSERT INTO assessment_instances (user_id, assessment_id, generated_at, started_at, completed_at, duration_actual, total_questions, score, percentage, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setLong(1, instance.getUserId());
                if (instance.getAssessmentId() != null) {
                    ps.setLong(2, instance.getAssessmentId());
                } else {
                    ps.setNull(2, java.sql.Types.BIGINT);
                }
                ps.setTimestamp(3, instance.getGeneratedAt());
                ps.setTimestamp(4, instance.getStartedAt());
                ps.setTimestamp(5, instance.getCompletedAt());
                ps.setInt(6, instance.getDurationActual());
                ps.setInt(7, instance.getTotalQuestions());
                ps.setInt(8, instance.getScore());
                ps.setDouble(9, instance.getPercentage());
                ps.setString(10, instance.getStatus());
                return ps;
            }, keyHolder);
            instance.setId(keyHolder.getKey().longValue());
            return instance;
        } else {
            String sql = "UPDATE assessment_instances SET user_id = ?, assessment_id = ?, generated_at = ?, started_at = ?, completed_at = ?, duration_actual = ?, total_questions = ?, score = ?, percentage = ?, status = ? WHERE id = ?";
            jdbcTemplate.update(sql,
                    instance.getUserId(),
                    instance.getAssessmentId(),
                    instance.getGeneratedAt(),
                    instance.getStartedAt(),
                    instance.getCompletedAt(),
                    instance.getDurationActual(),
                    instance.getTotalQuestions(),
                    instance.getScore(),
                    instance.getPercentage(),
                    instance.getStatus(),
                    instance.getId());
            return instance;
        }
    }

    public Optional<AssessmentInstance> findById(Long id) {
        String sql = "SELECT * FROM assessment_instances WHERE id = ?";
        return jdbcTemplate.query(sql, instanceRowMapper, id).stream().findFirst();
    }

    public List<AssessmentInstance> findByUserId(Long userId) {
        String sql = "SELECT * FROM assessment_instances WHERE user_id = ? ORDER BY generated_at DESC";
        return jdbcTemplate.query(sql, instanceRowMapper, userId);
    }

    public Optional<AssessmentInstance> findLatestActiveInstance(Long userId) {
        String sql = "SELECT * FROM assessment_instances WHERE user_id = ? AND status IN ('GENERATED', 'IN_PROGRESS') ORDER BY generated_at DESC";
        return jdbcTemplate.query(sql, instanceRowMapper, userId).stream().findFirst();
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM assessment_instances WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
