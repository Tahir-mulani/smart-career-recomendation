package com.techhub.service;


import org.springframework.stereotype.Service;

import com.techhub.dto.CareerRequest;
import com.techhub.entity.Career;
import com.techhub.exception.BusinessValidationException;
import com.techhub.repository.CareerRepository;

import java.util.List;

@Service
public class CareerService {

    private final CareerRepository careerRepository;

    public CareerService(CareerRepository careerRepository) {
        this.careerRepository = careerRepository;
    }

    public Career save(CareerRequest request) {
        Career career = new Career();
        career.setCareerName(request.getCareerName());
        career.setDescription(request.getDescription());
        career.setRequiredSkills(request.getRequiredSkills());
        career.setQualification(request.getQualification());

        return careerRepository.save(career);
    }

    public Career save(Career career) {
        return careerRepository.save(career);
    }

    public Career findById(Long careerId) {
        return careerRepository.findById(careerId)
                .orElseThrow(() -> new BusinessValidationException("careerId", "Career does not exist in the system"));
    }

    public List<Career> findAll() {
        return careerRepository.findAll();
    }

    public void deleteById(Long id) {
        careerRepository.deleteById(id);
    }
}
