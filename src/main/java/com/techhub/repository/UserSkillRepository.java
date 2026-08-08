package com.techhub.repository;

import com.techhub.entity.UserSkill;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserSkillRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<UserSkill> userSkillRowMapper;

    public UserSkillRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.userSkillRowMapper = (rs, rowNum) -> new UserSkill(
                rs.getLong("user_id"),
                rs.getLong("skill_id"),
                rs.getBoolean("is_primary"),
                rs.getString("proficiency_level")
        );
    }

    public void save(UserSkill userSkill) {
        String sql = "INSERT INTO user_skills (user_id, skill_id, is_primary, proficiency_level) VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE is_primary = VALUES(is_primary), proficiency_level = VALUES(proficiency_level)";
        jdbcTemplate.update(sql, userSkill.getUserId(), userSkill.getSkillId(), userSkill.getIsPrimary(), userSkill.getProficiencyLevel());
    }

    public List<UserSkill> findByUserId(Long userId) {
        String sql = "SELECT * FROM user_skills WHERE user_id = ?";
        return jdbcTemplate.query(sql, userSkillRowMapper, userId);
    }

    public List<UserSkill> findPrimarySkillsByUserId(Long userId) {
        String sql = "SELECT * FROM user_skills WHERE user_id = ? AND is_primary = true";
        return jdbcTemplate.query(sql, userSkillRowMapper, userId);
    }

    public void deleteByUserId(Long userId) {
        String sql = "DELETE FROM user_skills WHERE user_id = ?";
        jdbcTemplate.update(sql, userId);
    }

    public void deleteUserSkill(Long userId, Long skillId) {
        String sql = "DELETE FROM user_skills WHERE user_id = ? AND skill_id = ?";
        jdbcTemplate.update(sql, userId, skillId);
    }
}
