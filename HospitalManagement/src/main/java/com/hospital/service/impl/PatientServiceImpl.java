package com.hospital.service.impl;

import com.hospital.dao.PatientDAO;
import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.model.Patient;
import com.hospital.service.PatientService;
import java.util.List;

public class PatientServiceImpl implements PatientService {
    private PatientDAO patientDAO = new PatientDAOImpl();

    @Override
    public List<Patient> getRecentPatients() {
        return patientDAO.getAllPatients(); // For demo, assuming all are recent
    }

    @Override
    public int getTotalPatientsToday() {
        return 128; // Dummy data based on Figma: 128
    }

    @Override
    public int getTotalAppointments() {
        return 42; // Dummy data based on Figma: 42
    }
}
