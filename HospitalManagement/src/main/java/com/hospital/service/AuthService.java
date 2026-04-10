package com.hospital.service;

import com.hospital.model.Doctor;

public interface AuthService {
    Doctor login(String username, String password);
}
