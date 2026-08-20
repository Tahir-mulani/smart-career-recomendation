package com.techhub.repository;

import com.techhub.entity.Result;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class ResultRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Result> resultRowMapper;

    public ResultRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.resultRowMapper = (rs, rowNum) -> {
            Result result = new Result();
            result.setId(rs.getLong("id"));
            result.setUserId(rs.getLong("user_id"));
            result.setAssessmentId(rs.getLong("assessment_id"));
            result.setScore(rs.getInt("score"));
            result.setPercentage(rs.getDouble("percentage"));
            return result;
        };
    }

    public Result save(Result result) {
        if (result.getId() == null) {
            String sql = "INSERT INTO results (user_id, assessment_id, score, percentage) VALUES (?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setLong(1, result.getUserId());
                ps.setLong(2, result.getAssessmentId());
                ps.setInt(3, result.getScore());
                ps.setDouble(4, result.getPercentage());
                return ps;
            }, keyHolder);
            result.setId(keyHolder.getKey().longValue());
            return result;
        } else {
            String sql = "UPDATE results SET user_id = ?, assessment_id = ?, score = ?, percentage = ? WHERE id = ?";
            jdbcTemplate.update(sql, result.getUserId(), result.getAssessmentId(), result.getScore(), result.getPercentage(), result.getId());
            return findById(result.getId()).orElseThrow();
        }
    }

    public Optional<Result> findById(Long id) {
        String sql = "SELECT * FROM results WHERE id = ?";
        return jdbcTemplate.query(sql, resultRowMapper, id).stream().findFirst();
    }

    public List<Result> findByUserId(Long userId) {
        String sql = "SELECT * FROM results WHERE user_id = ?";
        return jdbcTemplate.query(sql, resultRowMapper, userId);
    }

    public List<Result> findAll() {
        String sql = "SELECT * FROM results";
        return jdbcTemplate.query(sql, resultRowMapper);
    }

    public boolean existsByUserId(Long userId) {
        String sql = "SELECT COUNT(*) FROM results WHERE user_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId);
        return count != null && count > 0;
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM results WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
