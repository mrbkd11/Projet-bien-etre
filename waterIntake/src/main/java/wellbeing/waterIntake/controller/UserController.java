package wellbeing.waterIntake.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import wellbeing.waterIntake.collections.User;
import wellbeing.waterIntake.repository.UserRepository;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/add")
    public ResponseEntity<User> createUser(@RequestBody User user) {
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    }
    @GetMapping("/{userId}/daily-goal")
    public ResponseEntity<Double> getDailyWaterIntakeGoal(@PathVariable String userId) {
        return userRepository.findById(userId)
                .map(user -> ResponseEntity.ok(user.getDailyWaterIntakeGoal()))
                .orElse(ResponseEntity.notFound().build());
    }
}

