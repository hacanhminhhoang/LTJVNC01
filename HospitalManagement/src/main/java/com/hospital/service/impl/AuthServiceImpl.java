package com.hospital.service.impl;

import com.hospital.dao.AdminDAO;
import com.hospital.dao.DoctorDAO;
import com.hospital.dao.PatientDAO;
import com.hospital.dao.impl.AdminDAOImpl;
import com.hospital.dao.impl.DoctorDAOImpl;
import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.model.Admin;
import com.hospital.model.Doctor;
import com.hospital.model.Patient;
import com.hospital.service.AuthService;

/**
 * AuthService trả về Object:
 *  - Admin   → vai trò quản trị viên
 *  - Doctor  → vai trò bác sĩ
 *  - Patient → vai trò bệnh nhân
 *  - null    → sai thông tin
 */
public class AuthServiceImpl implements AuthService {
    private final AdminDAO   adminDAO   = new AdminDAOImpl();
    private final DoctorDAO  doctorDAO  = new DoctorDAOImpl();
    private final PatientDAO patientDAO = new PatientDAOImpl();

    @Override
    public Doctor login(String username, String password) {
        Doctor doctor = doctorDAO.getDoctorByUsername(username);
        if (doctor != null && doctor.getPassword().equals(password)) return doctor;
        return null;
    }

    /** Xác thực tài khoản bệnh nhân */
    public Patient loginPatient(String username, String password) {
        Patient patient = patientDAO.getPatientByUsername(username);
        if (patient != null && password.equals(patient.getPassword())) return patient;
        return null;
    }

    /** Xác thực tài khoản quản trị viên (Admin) */
    public Admin loginAdmin(String username, String password) {
        Admin admin = adminDAO.getAdminByUsername(username);
        if (admin != null && password.equals(admin.getPassword())) return admin;
        return null;
    }
}
