package wellbeing.waterIntake.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import wellbeing.waterIntake.collections.User;

public interface UserRepository extends MongoRepository<User, String> {
}