package com.hospital.dao;

import com.hospital.model.Staff;
import java.util.List;

public interface StaffDAO {
    List<Staff> getAllStaff();
    List<Staff> getStaffByDepartment(String departmentId);
    Staff getStaffById(String id);
    boolean addStaff(Staff staff);
    boolean updateStaff(Staff staff);
    boolean deleteStaff(String id);
}
