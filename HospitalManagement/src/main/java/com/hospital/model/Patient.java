package com.hospital.model;

public class Patient {
    private String patientId;
    private String username;
    private String password;
    private String fullName;
    private String diagnosis;
    private String status;
    private String appointmentTime;

    public Patient() {
    }

    public Patient(String patientId, String username, String password, String fullName, String diagnosis, String status, String appointmentTime) {
        this.patientId = patientId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.diagnosis = diagnosis;
        this.status = status;
        this.appointmentTime = appointmentTime;
    }

    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(String appointmentTime) { this.appointmentTime = appointmentTime; }
}
