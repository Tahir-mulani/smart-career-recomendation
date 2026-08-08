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
            Recommendation rec = new Recommendation();
            rec.setId(rs.getLong("id"));
            rec.setUserId(rs.getLong("user_id"));
            rec.setCareerId(rs.getLong("career_id"));
            rec.setMatchScore(rs.getDouble("match_score"));
            return rec;
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
            jdbcTemplate.update(sql,
                    recommendation.getUserId(),
                    recommendation.getCareerId(),
                    recommendation.getMatchScore(),
                    recommendation.getId());
            return recommendation;
        }
    }

    public Optional<Recommendation> findById(Long id) {
        String sql = "SELECT * FROM recommendations WHERE id = ?";
        return jdbcTemplate.query(sql, recommendationRowMapper, id).stream().findFirst();
    }

    public List<Recommendation> findByUserId(Long userId) {
        String sql = "SELECT * FROM recommendations WHERE user_id = ? ORDER BY match_score DESC";
        return jdbcTemplate.query(sql, recommendationRowMapper, userId);
    }

    public List<Recommendation> findAll() {
        String sql = "SELECT * FROM recommendations ORDER BY match_score DESC";
        return jdbcTemplate.query(sql, recommendationRowMapper);
    }

    public void deleteByUserId(Long userId) {
        String sql = "DELETE FROM recommendations WHERE user_id = ?";
        jdbcTemplate.update(sql, userId);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM recommendations WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
