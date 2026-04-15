package com.hospital.dao;

import com.hospital.model.Department;
import java.util.List;

public interface DepartmentDAO {
    List<Department> getAllDepartments();
    Department getDepartmentById(String id);
    boolean addDepartment(Department department);
    boolean updateDepartment(Department department);
    boolean deleteDepartment(String id);
}
