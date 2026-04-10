package com.hospital.dao;

import com.hospital.model.Appointment;
import java.util.List;

public interface AppointmentDAO {
    List<Appointment> getAllAppointments();
    Appointment getById(String id);
    boolean insert(Appointment a);
    boolean update(Appointment a);
    boolean delete(String id);
    int countTotal();
}
