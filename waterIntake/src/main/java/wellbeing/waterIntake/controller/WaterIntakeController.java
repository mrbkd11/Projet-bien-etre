package wellbeing.waterIntake.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import wellbeing.waterIntake.collections.WaterIntakeDto;
import wellbeing.waterIntake.collections.WaterIntakeRecord;
import wellbeing.waterIntake.repository.UserRepository;
import wellbeing.waterIntake.repository.WaterIntakeRecordRepository;
import org.springframework.web.bind.annotation.*;

import java.time.*;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.LinkedHashMap;



@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS})

@RestController
@RequestMapping("/waterIntake")
public class WaterIntakeController {

    @Autowired
    private WaterIntakeRecordRepository waterIntakeRecordRepository;

    @Autowired
    private UserRepository userRepository;


    @GetMapping("/daily/{userId}")
    public double getDailyIntake(
            @PathVariable String userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        // Convert the date to the start and end of the day in UTC (or any other time zone as required)
        ZoneId zoneId = ZoneId.of("UTC"); // Choose the appropriate time zone. For example, ZoneId.systemDefault() or ZoneId.of("America/New_York")
        ZonedDateTime startOfDay = date.atStartOfDay(zoneId);
        ZonedDateTime endOfDay = startOfDay.plusDays(1).minusNanos(1);

        // Now convert startOfDay and endOfDay to LocalDateTime for querying, since ZonedDateTime might not be directly supported depending on your JPA provider
        LocalDateTime startDateTime = startOfDay.toLocalDateTime();
        LocalDateTime endDateTime = endOfDay.toLocalDateTime();

        // Update findByUserIdAndDate to findByUserIdAndDateTimeBetween or similar method that matches your naming
        List<WaterIntakeRecord> records = waterIntakeRecordRepository.findByUserIdAndDateTimeBetween(userId, startDateTime, endDateTime);

        return records.stream().mapToDouble(WaterIntakeRecord::getAmount).sum();
    }


    @PostMapping("/updateGoal/{userId}")
    public ResponseEntity<?> updateDailyWaterIntakeGoal(@PathVariable String userId, @RequestBody Map<String, Double> body) {
        Double newGoal = body.get("newGoal"); // Extracting newGoal from the request body
        return userRepository.findById(userId).map(user -> {
            user.setDailyWaterIntakeGoal(newGoal);
            userRepository.save(user);
            return ResponseEntity.ok().build();
        }).orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/range/{userId}")
    public List<WaterIntakeRecord> getRecordsByDateRange(
            @PathVariable String userId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {

        return waterIntakeRecordRepository.findByUserIdAndDateRange(userId, startDate, endDate);
    }
    @PostMapping("/logIntake")
    public ResponseEntity<WaterIntakeRecord> logWaterIntake(@RequestBody WaterIntakeDto intakeDto) {
        WaterIntakeRecord record = new WaterIntakeRecord();
        record.setUserId(intakeDto.getUserId());
        record.setAmount(intakeDto.getAmount());
        // Set dateTime to now in UTC
        record.setDateTime(LocalDateTime.now(ZoneOffset.UTC));
        WaterIntakeRecord savedRecord = waterIntakeRecordRepository.save(record);
        return ResponseEntity.ok(savedRecord);
    }
    @GetMapping("/weeklySummary/{userId}")
    public ResponseEntity<Map<LocalDate, Double>> getWeeklyIntakeSummary(@PathVariable String userId) {
        // Define the start and end of the current week in UTC
        LocalDate today = LocalDate.now(ZoneOffset.UTC);
        LocalDate startOfWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate endOfWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

        // Convert to LocalDateTime for start and end of week
        LocalDateTime startDateTime = startOfWeek.atStartOfDay(ZoneOffset.UTC).toLocalDateTime();
        LocalDateTime endDateTime = endOfWeek.atTime(LocalTime.MAX).withNano(0).atZone(ZoneOffset.UTC).toLocalDateTime();

        // Fetch records from the database
        List<WaterIntakeRecord> records = waterIntakeRecordRepository.findByUserIdAndDateTimeBetween(userId, startDateTime, endDateTime);

        // Aggregate records by date and sum the water intake amounts
        Map<LocalDate, Double> dailySummaries = records.stream()
                .collect(Collectors.groupingBy(
                        record -> record.getDateTime().toLocalDate(),
                        LinkedHashMap::new, // Maintain the order of days
                        Collectors.summingDouble(WaterIntakeRecord::getAmount)
                ));

        return ResponseEntity.ok(dailySummaries);
    }


    // Additional methods for updating goals, fetching summaries, etc.
}