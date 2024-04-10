package wellbeing.waterIntake.collections;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Setter
@Getter
@AllArgsConstructor
@Document
public class User {
    @Id
    private String id;
    private String username;
    private String email;
    private double dailyWaterIntakeGoal; // in liters

    // Constructors, Getters, and Setters
}