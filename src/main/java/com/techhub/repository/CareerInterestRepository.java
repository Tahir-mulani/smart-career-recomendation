package com.techhub.repository;

import com.techhub.entity.CareerInterest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CareerInterestRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<CareerInterest> careerInterestRowMapper;

    public CareerInterestRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.careerInterestRowMapper = (rs, rowNum) -> new CareerInterest(
                rs.getLong("career_id"),
                rs.getLong("interest_id")
        );
    }

    public void save(CareerInterest careerInterest) {
        String sql = "INSERT IGNORE INTO career_interests (career_id, interest_id) VALUES (?, ?)";
        jdbcTemplate.update(sql, careerInterest.getCareerId(), careerInterest.getInterestId());
    }

    public List<CareerInterest> findByCareerId(Long careerId) {
        String sql = "SELECT * FROM career_interests WHERE career_id = ?";
        return jdbcTemplate.query(sql, careerInterestRowMapper, careerId);
    }

    public void deleteByCareerId(Long careerId) {
        String sql = "DELETE FROM career_interests WHERE career_id = ?";
        jdbcTemplate.update(sql, careerId);
    }
}
