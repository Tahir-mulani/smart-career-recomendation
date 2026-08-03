package com.techhub.repository;

import com.techhub.entity.Recommendation;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class RecommendationRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Recommendation> recommendationRowMapper;

    public RecommendationRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.recommendationRowMapper = (rs, rowNum) -> {
            Recommendation recommendation = new Recommendation();
            recommendation.setId(rs.getLong("id"));
            recommendation.setUserId(rs.getLong("user_id"));
            recommendation.setCareerId(rs.getLong("career_id"));
            recommendation.setMatchScore(rs.getDouble("match_score"));
            return recommendation;
        };
    }

    public Recommendation save(Recommendation recommendation) {
        if (recommendation.getId() == null) {
            String sql = "INSERT INTO recommendations (user_id, career_id, match_score) VALUES (?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setLong(1, recommendation.getUserId());
                ps.setLong(2, recommendation.getCareerId());
                ps.setDouble(3, recommendation.getMatchScore());
                return ps;
            }, keyHolder);
            recommendation.setId(keyHolder.getKey().longValue());
            return recommendation;
        } else {
            String sql = "UPDATE recommendations SET user_id = ?, career_id = ?, match_score = ? WHERE id = ?";
            jdbcTemplate.update(sql, recommendation.getUserId(), recommendation.getCareerId(), recommendation.getMatchScore(), recommendation.getId());
            return findById(recommendation.getId()).orElseThrow();
        }
    }

    public Optional<Recommendation> findById(Long id) {
        String sql = "SELECT * FROM recommendations WHERE id = ?";
        return jdbcTemplate.query(sql, recommendationRowMapper, id).stream().findFirst();
    }

    public List<Recommendation> findByUserId(Long userId) {
        String sql = "SELECT * FROM recommendations WHERE user_id = ?";
        return jdbcTemplate.query(sql, recommendationRowMapper, userId);
    }

    public List<Recommendation> findAll() {
        String sql = "SELECT * FROM recommendations";
        return jdbcTemplate.query(sql, recommendationRowMapper);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM recommendations WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
