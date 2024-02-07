package com.example.demo.controller;

import com.example.demo.service.ImageCaptioningService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api")
public class ImageCaptioningController {

    private final ImageCaptioningService imageCaptioningService;

    public ImageCaptioningController(ImageCaptioningService imageCaptioningService) {
        this.imageCaptioningService = imageCaptioningService;
    }

    @PostMapping("/image-caption")
    public ResponseEntity<String> generateImageCaption(@RequestParam("file") MultipartFile file) {
        return imageCaptioningService.generateCaption(file);
    }
}
