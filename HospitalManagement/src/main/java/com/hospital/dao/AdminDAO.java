package com.hospital.dao;

import com.hospital.model.Admin;

public interface AdminDAO {
    Admin getAdminByUsername(String username);
}
