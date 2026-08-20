package com.techhub.service;

import com.techhub.entity.Interest;
import com.techhub.entity.UserInterest;
import com.techhub.repository.InterestRepository;
import com.techhub.repository.UserInterestRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class InterestService {

    private final InterestRepository interestRepository;
    private final UserInterestRepository userInterestRepository;

    public InterestService(InterestRepository interestRepository, UserInterestRepository userInterestRepository) {
        this.interestRepository = interestRepository;
        this.userInterestRepository = userInterestRepository;
    }

    public List<Interest> findAll() {
        return interestRepository.findAll();
    }

    public Optional<Interest> findById(Long id) {
        return interestRepository.findById(id);
    }

    public Optional<Interest> findByName(String interestName) {
        return interestRepository.findByName(interestName);
    }

    public Interest save(Interest interest) {
        return interestRepository.save(interest);
    }

    public List<Interest> getUserInterests(Long userId) {
        List<UserInterest> userInterests = userInterestRepository.findByUserId(userId);
        List<Interest> interests = new ArrayList<>();
        for (UserInterest ui : userInterests) {
            interestRepository.findById(ui.getInterestId()).ifPresent(interests::add);
        }
        return interests;
    }

    public void saveUserInterests(Long userId, List<Long> interestIds) {
        userInterestRepository.deleteByUserId(userId);
        if (interestIds != null) {
            for (Long interestId : interestIds) {
                userInterestRepository.save(new UserInterest(userId, interestId));
            }
        }
    }
}
