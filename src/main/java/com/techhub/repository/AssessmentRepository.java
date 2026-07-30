package com.techhub.repository;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.techhub.entity.Assessment;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

@Repository
public class AssessmentRepository {

    private final JdbcTemplate jdbcTemplate;

    public AssessmentRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Assessment> assessmentRowMapper = (rs, rowNum) -> {
        Assessment assessment = new Assessment();
        assessment.setId(rs.getLong("id"));
        assessment.setTestName(rs.getString("test_name"));
        assessment.setDuration(rs.getInt("duration"));
        assessment.setTotalMarks(rs.getInt("total_marks"));
        return assessment;
    };

    public Assessment save(Assessment assessment) {
        if (assessment.getId() == null) {
            String sql = "INSERT INTO assessments (test_name, duration, total_marks) VALUES (?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
                ps.setString(1, assessment.getTestName());
                ps.setInt(2, assessment.getDuration());
                ps.setInt(3, assessment.getTotalMarks());
                return ps;
            }, keyHolder);
            assessment.setId(keyHolder.getKey().longValue());
            return assessment;
        } else {
            String sql = "UPDATE assessments SET test_name = ?, duration = ?, total_marks = ? WHERE id = ?";
            jdbcTemplate.update(sql, assessment.getTestName(), assessment.getDuration(), assessment.getTotalMarks(), assessment.getId());
            return findById(assessment.getId()).orElseThrow();
        }
    }

    public Optional<Assessment> findById(Long id) {
        String sql = "SELECT * FROM assessments WHERE id = ?";
        return jdbcTemplate.query(sql, assessmentRowMapper, id).stream().findFirst();
    }

    public List<Assessment> findAll() {
        String sql = "SELECT * FROM assessments";
        return jdbcTemplate.query(sql, assessmentRowMapper);
    }

    public void deleteById(Long id) {
        String sql = "DELETE FROM assessments WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
