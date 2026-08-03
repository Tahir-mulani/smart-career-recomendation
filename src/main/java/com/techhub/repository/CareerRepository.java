package com.techhub.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.techhub.entity.Career;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class CareerRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Career> careerRowMapper;

    public CareerRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.careerRowMapper = (rs, rowNum) -> {
            Career career = new Career();
            career.setId(rs.getLong("id"));
            career.setCareerName(rs.getString("career_name"));
            career.setDescription(rs.getString("description"));
            career.setRequiredSkills(rs.getString("required_skills"));
            career.setQualification(rs.getString("qualification"));
            return career;
        };
    }

    public Career save(Career career) {
        if (career.getId() == null) {
            String sql = "INSERT INTO careers (career_name, description, required_skills, qualification) VALUES (?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, career.getCareerName());
                ps.setString(2, career.getDescription());
                ps.setString(3, career.getRequiredSkills());
                ps.setString(4, career.getQualification());
                return ps;
            }, keyHolder);
            career.setId(keyHolder.getKey().longValue());
            return career;
        } else {
            String sql = "UPDATE careers SET career_name = ?, description = ?, required_skills = ?, qualification = ? WHERE id = ?";
            jdbcTemplate.update(sql, career.getCareerName(), career.getDescription(), 
                              career.getRequiredSkills(), career.getQualification(), career.getId());
            return findById(career.getId()).orElseThrow();
        }
    }

    public Optional<Career> findById(Long id) {
        String sql = "SELECT * FROM careers WHERE id = ?";
        return jdbcTemplate.query(sql, careerRowMapper, id).stream().findFirst();
    }

    public List<Career> findAll() {
        String sql = "SELECT * FROM careers";
        return jdbcTemplate.query(sql, careerRowMapper);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM careers WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
