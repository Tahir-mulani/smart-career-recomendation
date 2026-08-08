package com.techhub.repository;

import com.techhub.entity.Skill;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class SkillRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Skill> skillRowMapper;

    public SkillRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.skillRowMapper = (rs, rowNum) -> new Skill(
                rs.getLong("id"),
                rs.getString("skill_name")
        );
    }

    public Skill save(Skill skill) {
        if (skill.getId() == null) {
            String sql = "INSERT INTO skills (skill_name) VALUES (?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, skill.getSkillName());
                return ps;
            }, keyHolder);
            skill.setId(keyHolder.getKey().longValue());
            return skill;
        } else {
            String sql = "UPDATE skills SET skill_name = ? WHERE id = ?";
            jdbcTemplate.update(sql, skill.getSkillName(), skill.getId());
            return skill;
        }
    }

    public Optional<Skill> findById(Long id) {
        String sql = "SELECT * FROM skills WHERE id = ?";
        return jdbcTemplate.query(sql, skillRowMapper, id).stream().findFirst();
    }

    public Optional<Skill> findByName(String skillName) {
        String sql = "SELECT * FROM skills WHERE LOWER(skill_name) = LOWER(?)";
        return jdbcTemplate.query(sql, skillRowMapper, skillName).stream().findFirst();
    }

    public List<Skill> findAll() {
        String sql = "SELECT * FROM skills ORDER BY id ASC";
        return jdbcTemplate.query(sql, skillRowMapper);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM skills WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
