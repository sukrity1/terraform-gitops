package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@SpringBootApplication
@RestController
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    // 1. A nice UI for the Homepage (http://localhost:80)
    @GetMapping("/")
    public String welcome() {
        return "<html>" +
                "<head><title>Java API</title></head>" +
                "<body style='font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #f0f2f5;'>" +
                "  <div style='text-align: center; padding: 50px; background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);'>" +
                "    <h1 style='color: #2c3e50;'>Hello from Sukrity Sinha!</h1>" +
                "    <a href='https://www.linkedin.com/in/sukrity1/' style='text-decoration: none; color: #3498db;'>LinkedIn profile</a>" +
                "  </div>" +
                "</body>" +
                "</html>";
    }

    // 2. The JSON endpoint for Docker/ECS Health Checks (http://localhost:80/health)
    @GetMapping("/health")
    public Map<String, String> health() {
        return Map.of("status", "ok");
    }
}