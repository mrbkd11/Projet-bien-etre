package com.example.demo.controller;

import com.example.demo.entity.QueryInput;
import com.example.demo.service.QuestionAnsweringService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;





@RestController
@RequestMapping("/api")
public class QuestionAnsweringController {

    private final QuestionAnsweringService qaService;

    public QuestionAnsweringController(QuestionAnsweringService qaService) {
        this.qaService = qaService;
    }

    @PostMapping("/ask")
    public ResponseEntity<String> askQuestion(@RequestBody QueryInput input) {
        return qaService.query(input.getQuestion(), input.getContext());
    }
}
