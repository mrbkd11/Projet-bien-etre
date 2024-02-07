package com.example.demo.controller;

import com.example.demo.service.LlamaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class LlamaController {

    private final LlamaService llamaService;

    public LlamaController(LlamaService llamaService) {
        this.llamaService = llamaService;
    }

    @PostMapping("/llama-query")
    public ResponseEntity<String> queryLlama(@RequestBody Map<String, Object> data) {
        return llamaService.query(data);
    }
}
