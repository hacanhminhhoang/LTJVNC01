package com.hospital.model;

public class Doctor {
    private String doctorId;
    private String username;
    private String password;
    private String fullName;
    private String specialty;
    private String status;
    private String phoneNumber;

    public Doctor() {}

    public Doctor(String doctorId, String username, String password, String fullName, String specialty, String status, String phoneNumber) {
        this.doctorId = doctorId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.specialty = specialty;
        this.status = status;
        this.phoneNumber = phoneNumber;
    }

    public String getDoctorId() { return doctorId; }
    public void setDoctorId(String doctorId) { this.doctorId = doctorId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
}
