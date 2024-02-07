package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ImageCaptioningService {

    private final RestTemplate restTemplate;
    private final String apiUrl = "https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-large";
    private final String token = "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"; // Secure your token

    @Autowired
    public ImageCaptioningService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public ResponseEntity<String> generateCaption(MultipartFile file) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
            // The content type may need to be set to application/octet-stream or the specific image content type
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

            ByteArrayResource byteArrayResource = new ByteArrayResource(file.getBytes()) {
                @Override
                public String getFilename() {
                    return file.getOriginalFilename(); // This is important for the API to process the file
                }
            };

            HttpEntity<ByteArrayResource> entity = new HttpEntity<>(byteArrayResource, headers);

            return restTemplate.postForEntity(apiUrl, entity, String.class);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
