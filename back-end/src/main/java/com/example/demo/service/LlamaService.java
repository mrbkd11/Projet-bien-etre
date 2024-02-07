package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.HashMap;
import java.util.Map;

@Service
public class LlamaService {

    private final RestTemplate restTemplate;
    private final String baseUrl = "https://api-inference.huggingface.co/models/meta-llama/Llama-2-70b-chat-hf";
    private final String token = "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"; // Secure your token

    @Autowired
    public LlamaService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public ResponseEntity<String> query(Map<String, Object> data) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(token);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(data, headers);

        return restTemplate.postForEntity(baseUrl, entity, String.class);
    }
}