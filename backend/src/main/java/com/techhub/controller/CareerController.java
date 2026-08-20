package com.techhub.controller;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.techhub.dto.CareerRequest;
import com.techhub.entity.Career;
import com.techhub.service.CareerService;

import java.util.List;

@RestController
@RequestMapping("/api/careers")
public class CareerController {

    private final CareerService careerService;

    public CareerController(CareerService careerService) {
        this.careerService = careerService;
    }

    @PostMapping
    public ResponseEntity<Career> save(@Valid @RequestBody CareerRequest request) {
        Career career = careerService.save(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(career);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Career> getById(@PathVariable Long id) {
        Career career = careerService.findById(id);
        return ResponseEntity.ok(career);
    }

    @GetMapping
    public ResponseEntity<List<Career>> getAll() {
        List<Career> careers = careerService.findAll();
        return ResponseEntity.ok(careers);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Career> update(@PathVariable Long id, @Valid @RequestBody CareerRequest request) {
        Career career = careerService.findById(id);
        career.setCareerName(request.getCareerName());
        career.setDescription(request.getDescription());
        career.setRequiredSkills(request.getRequiredSkills());
        career.setQualification(request.getQualification());
        Career updated = careerService.save(career);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        careerService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
