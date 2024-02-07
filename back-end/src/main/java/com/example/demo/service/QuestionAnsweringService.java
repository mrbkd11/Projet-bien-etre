package com.example.demo.service;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.Collections;

@Service
public class QuestionAnsweringService {

    private final RestTemplate restTemplate;
    private final String apiUrl = "https://api-inference.huggingface.co/models/deepset/roberta-base-squad2";
    private final String token = "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"; // Be sure to secure your API tokens!

    public QuestionAnsweringService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public ResponseEntity<String> query(String question, String context) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        String requestBody = "{\"inputs\": {\"question\": \"" + question + "\", \"context\": \"" + context + "\"}}";

        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        return restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class);
    }
}
