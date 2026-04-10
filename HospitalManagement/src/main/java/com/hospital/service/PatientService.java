package com.hospital.service;

import com.hospital.model.Patient;
import java.util.List;

public interface PatientService {
    List<Patient> getRecentPatients();
    int getTotalPatientsToday();
    int getTotalAppointments();
}
