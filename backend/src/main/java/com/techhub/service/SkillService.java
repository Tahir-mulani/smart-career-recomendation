package com.techhub.service;

import com.techhub.entity.Skill;
import com.techhub.entity.UserSkill;
import com.techhub.repository.SkillRepository;
import com.techhub.repository.UserSkillRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class SkillService {

    private final SkillRepository skillRepository;
    private final UserSkillRepository userSkillRepository;

    public SkillService(SkillRepository skillRepository, UserSkillRepository userSkillRepository) {
        this.skillRepository = skillRepository;
        this.userSkillRepository = userSkillRepository;
    }

    public List<Skill> findAll() {
        return skillRepository.findAll();
    }

    public Optional<Skill> findById(Long id) {
        return skillRepository.findById(id);
    }

    public Optional<Skill> findByName(String skillName) {
        return skillRepository.findByName(skillName);
    }

    public Skill save(Skill skill) {
        return skillRepository.save(skill);
    }

    public List<Skill> getUserSkills(Long userId) {
        List<UserSkill> userSkills = userSkillRepository.findByUserId(userId);
        List<Skill> skills = new ArrayList<>();
        for (UserSkill us : userSkills) {
            skillRepository.findById(us.getSkillId()).ifPresent(skills::add);
        }
        return skills;
    }

    public List<Skill> getUserPrimarySkills(Long userId) {
        List<UserSkill> primaryUserSkills = userSkillRepository.findPrimarySkillsByUserId(userId);
        List<Skill> skills = new ArrayList<>();
        for (UserSkill us : primaryUserSkills) {
            skillRepository.findById(us.getSkillId()).ifPresent(skills::add);
        }
        return skills;
    }

    public void saveUserSkills(Long userId, List<Long> primarySkillIds, List<Long> secondarySkillIds) {
        userSkillRepository.deleteByUserId(userId);

        if (primarySkillIds != null) {
            for (Long skillId : primarySkillIds) {
                userSkillRepository.save(new UserSkill(userId, skillId, true, "Beginner"));
            }
        }

        if (secondarySkillIds != null) {
            for (Long skillId : secondarySkillIds) {
                // Ensure primary skills take precedence if duplicate submitted
                if (primarySkillIds == null || !primarySkillIds.contains(skillId)) {
                    userSkillRepository.save(new UserSkill(userId, skillId, false, "Beginner"));
                }
            }
        }
    }
}
