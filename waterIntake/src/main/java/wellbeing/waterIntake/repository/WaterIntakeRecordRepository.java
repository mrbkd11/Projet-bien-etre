package wellbeing.waterIntake.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import wellbeing.waterIntake.collections.WaterIntakeRecord;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface WaterIntakeRecordRepository extends MongoRepository<WaterIntakeRecord, String> {
    @Query("{'userId': ?0, 'dateTime': { $gte: ?1, $lt: ?2 }}")
    List<WaterIntakeRecord> findByUserIdAndDate(String userId, LocalDate dateStart);
    List<WaterIntakeRecord> findByUserIdAndDateTimeBetween(String userId, LocalDateTime startDateTime, LocalDateTime endDateTime);

    @Query("{'userId': ?0, 'dateTime': {$gte: ?1, $lt: ?2}}")
    List<WaterIntakeRecord> findByUserIdAndDateRange(String userId, LocalDateTime startDate, LocalDateTime endDate);
}
