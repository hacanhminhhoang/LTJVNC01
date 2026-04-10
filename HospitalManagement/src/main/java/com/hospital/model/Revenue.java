package com.hospital.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Revenue {
    private String revenueId;
    private BigDecimal amount;
    private String description;
    private LocalDate revenueDate;
    private String category;
    private String patientId;

    public Revenue() {}

    public Revenue(String revenueId, BigDecimal amount, String description,
                   LocalDate revenueDate, String category, String patientId) {
        this.revenueId = revenueId;
        this.amount = amount;
        this.description = description;
        this.revenueDate = revenueDate;
        this.category = category;
        this.patientId = patientId;
    }

    public String getRevenueId() { return revenueId; }
    public void setRevenueId(String revenueId) { this.revenueId = revenueId; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDate getRevenueDate() { return revenueDate; }
    public void setRevenueDate(LocalDate revenueDate) { this.revenueDate = revenueDate; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }
}
