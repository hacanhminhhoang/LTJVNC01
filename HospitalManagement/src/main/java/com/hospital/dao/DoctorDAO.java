package com.hospital.dao;

import com.hospital.model.Doctor;
import java.util.List;

public interface DoctorDAO {
    Doctor getDoctorByUsername(String username);
    List<Doctor> getAllDoctors();
    int countTotal();
    boolean insert(Doctor d);
    boolean update(Doctor d);
    boolean delete(String doctorId);
}
