package com.techhub.repository;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.techhub.entity.User;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class UserRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<User> userRowMapper;

    public UserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.userRowMapper = (rs, rowNum) -> {
            User user = new User();
            user.setId(rs.getLong("id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setPhoneNumber(rs.getString("phone_number"));
            user.setRole(rs.getString("role"));
            user.setSkills(rs.getString("skills"));
            user.setInterests(rs.getString("interests"));
            if (rs.getDate("registration_date") != null) {
                user.setRegistrationDate(rs.getDate("registration_date").toLocalDate());
            }
            return user;
        };
    }

    public User save(User user) {
        if (user.getId() == null) {
            String sql = "INSERT INTO users (name, email, password, phone_number, role, skills, interests, registration_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getPhoneNumber());
                ps.setString(5, user.getRole() != null ? user.getRole() : "USER");
                ps.setString(6, user.getSkills());
                ps.setString(7, user.getInterests());
                ps.setDate(8, user.getRegistrationDate() != null ? java.sql.Date.valueOf(user.getRegistrationDate()) : java.sql.Date.valueOf(java.time.LocalDate.now()));
                return ps;
            }, keyHolder);
            user.setId(keyHolder.getKey().longValue());
            return user;
        } else {
            String sql = "UPDATE users SET name = ?, email = ?, password = ?, phone_number = ?, role = ?, skills = ?, interests = ? WHERE id = ?";
            jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword(), user.getPhoneNumber(), user.getRole(), user.getSkills(), user.getInterests(), user.getId());
            return findById(user.getId()).orElseThrow();
        }
    }

    public Optional<User> findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        return jdbcTemplate.query(sql, userRowMapper, id).stream().findFirst();
    }

    public Optional<User> findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        return jdbcTemplate.query(sql, userRowMapper, email).stream().findFirst();
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
        return count != null && count > 0;
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM users WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public List<User> findAll() {
        String sql = "SELECT * FROM users";
        return jdbcTemplate.query(sql, userRowMapper);
    }
}
