package com.techhub.repository;

import com.techhub.entity.UserInterest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserInterestRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<UserInterest> userInterestRowMapper;

    public UserInterestRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.userInterestRowMapper = (rs, rowNum) -> new UserInterest(
                rs.getLong("user_id"),
                rs.getLong("interest_id")
        );
    }

    public void save(UserInterest userInterest) {
        String sql = "INSERT IGNORE INTO user_interests (user_id, interest_id) VALUES (?, ?)";
        jdbcTemplate.update(sql, userInterest.getUserId(), userInterest.getInterestId());
    }

    public List<UserInterest> findByUserId(Long userId) {
        String sql = "SELECT * FROM user_interests WHERE user_id = ?";
        return jdbcTemplate.query(sql, userInterestRowMapper, userId);
    }

    public void deleteByUserId(Long userId) {
        String sql = "DELETE FROM user_interests WHERE user_id = ?";
        jdbcTemplate.update(sql, userId);
    }
}
