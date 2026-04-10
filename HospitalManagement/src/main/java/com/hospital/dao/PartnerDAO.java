package com.hospital.dao;

import com.hospital.model.Partner;
import java.util.List;

public interface PartnerDAO {
    List<Partner> getAll();
    Partner getById(String id);
    boolean insert(Partner p);
    boolean update(Partner p);
    boolean delete(String id);
}
