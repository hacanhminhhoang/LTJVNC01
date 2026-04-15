package com.hospital.model;

public class Staff {
    private String staffId;
    private String fullName;
    private String role;
    private String departmentId;
    private String phoneNumber;
    private String email;
    
    // Virtual property for JOIN representation
    private String departmentName;

    public Staff() {}

    public Staff(String staffId, String fullName, String role, String departmentId, String phoneNumber, String email) {
        this.staffId = staffId;
        this.fullName = fullName;
        this.role = role;
        this.departmentId = departmentId;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    public String getStaffId() { return staffId; }
    public void setStaffId(String staffId) { this.staffId = staffId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getDepartmentId() { return departmentId; }
    public void setDepartmentId(String departmentId) { this.departmentId = departmentId; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}
