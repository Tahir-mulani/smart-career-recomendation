package com.techhub.repository;

import com.techhub.entity.Interest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class InterestRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Interest> interestRowMapper;

    public InterestRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.interestRowMapper = (rs, rowNum) -> new Interest(
                rs.getLong("id"),
                rs.getString("interest_name")
        );
    }

    public Interest save(Interest interest) {
        if (interest.getId() == null) {
            String sql = "INSERT INTO interests (interest_name) VALUES (?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, interest.getInterestName());
                return ps;
            }, keyHolder);
            interest.setId(keyHolder.getKey().longValue());
            return interest;
        } else {
            String sql = "UPDATE interests SET interest_name = ? WHERE id = ?";
            jdbcTemplate.update(sql, interest.getInterestName(), interest.getId());
            return interest;
        }
    }

    public Optional<Interest> findById(Long id) {
        String sql = "SELECT * FROM interests WHERE id = ?";
        return jdbcTemplate.query(sql, interestRowMapper, id).stream().findFirst();
    }

    public Optional<Interest> findByName(String interestName) {
        String sql = "SELECT * FROM interests WHERE LOWER(interest_name) = LOWER(?)";
        return jdbcTemplate.query(sql, interestRowMapper, interestName).stream().findFirst();
    }

    public List<Interest> findAll() {
        String sql = "SELECT * FROM interests ORDER BY id ASC";
        return jdbcTemplate.query(sql, interestRowMapper);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM interests WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
