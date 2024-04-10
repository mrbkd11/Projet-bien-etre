package wellbeing.waterIntake.collections;

import java.time.LocalDateTime;

public class WaterIntakeDto {

    private String userId;
    private double amount;
    // Optionally, if you want the client to specify the date and time of the water intake
    private LocalDateTime dateTime;

    // Default constructor
    public WaterIntakeDto() {}

    // Constructor with fields
    public WaterIntakeDto(String userId, double amount, LocalDateTime dateTime) {
        this.userId = userId;
        this.amount = amount;
        this.dateTime = dateTime;
    }

    // Getters and setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "WaterIntakeDto{" +
                "userId='" + userId + '\'' +
                ", amount=" + amount +
                ", dateTime=" + dateTime +
                '}';
    }
}
