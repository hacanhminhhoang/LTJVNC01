package com.hospital.dao;

import com.hospital.model.Patient;
import java.util.List;

public interface PatientDAO {
    List<Patient> getAllPatients();
    Patient getPatientById(String patientId);
    Patient getPatientByUsername(String username);
    boolean addPatient(Patient patient);
    boolean updatePatient(Patient patient);
    boolean deletePatient(String patientId);
    int countTotal();

    // Aliases for admin controllers (delegate to addPatient/updatePatient/deletePatient)
    default boolean insert(Patient p) { return addPatient(p); }
    default boolean update(Patient p) { return updatePatient(p); }
    default boolean delete(String id) { return deletePatient(id); }
}
