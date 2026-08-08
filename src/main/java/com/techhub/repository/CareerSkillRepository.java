package com.techhub.repository;

import com.techhub.entity.CareerSkill;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CareerSkillRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<CareerSkill> careerSkillRowMapper;

    public CareerSkillRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.careerSkillRowMapper = (rs, rowNum) -> new CareerSkill(
                rs.getLong("career_id"),
                rs.getLong("skill_id")
        );
    }

    public void save(CareerSkill careerSkill) {
        String sql = "INSERT IGNORE INTO career_skills (career_id, skill_id) VALUES (?, ?)";
        jdbcTemplate.update(sql, careerSkill.getCareerId(), careerSkill.getSkillId());
    }

    public List<CareerSkill> findByCareerId(Long careerId) {
        String sql = "SELECT * FROM career_skills WHERE career_id = ?";
        return jdbcTemplate.query(sql, careerSkillRowMapper, careerId);
    }

    public List<CareerSkill> findBySkillId(Long skillId) {
        String sql = "SELECT * FROM career_skills WHERE skill_id = ?";
        return jdbcTemplate.query(sql, careerSkillRowMapper, skillId);
    }

    public void deleteByCareerId(Long careerId) {
        String sql = "DELETE FROM career_skills WHERE career_id = ?";
        jdbcTemplate.update(sql, careerId);
    }
}
