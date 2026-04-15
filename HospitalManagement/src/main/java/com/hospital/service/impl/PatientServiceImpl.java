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
        return patientDAO.getAllPatients();
    }

    @Override
    public int getTotalPatientsToday() {
        return 128;
    }

    @Override
    public int getTotalAppointments() {
        return 42;
    }
}
