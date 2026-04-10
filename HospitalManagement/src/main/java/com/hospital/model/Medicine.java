package com.hospital.model;

import java.sql.Date;

public class Medicine {
    private String medicineId;
    private String name;
    private String category;
    private int quantity;
    private double price;
    private Date expirationDate;

    public Medicine() {
    }

    public Medicine(String medicineId, String name, String category, int quantity, double price, Date expirationDate) {
        this.medicineId = medicineId;
        this.name = name;
        this.category = category;
        this.quantity = quantity;
        this.price = price;
        this.expirationDate = expirationDate;
    }

    public String getMedicineId() { return medicineId; }
    public void setMedicineId(String medicineId) { this.medicineId = medicineId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Date getExpirationDate() { return expirationDate; }
    public void setExpirationDate(Date expirationDate) { this.expirationDate = expirationDate; }
}
