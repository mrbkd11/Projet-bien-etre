package wellbeing.waterIntake;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

@SpringBootApplication
@EnableMongoAuditing

public class WaterIntakeApplication {

	public static void main(String[] args) {
		SpringApplication.run(WaterIntakeApplication.class, args);
	}

}
