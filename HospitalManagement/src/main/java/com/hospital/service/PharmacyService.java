package com.hospital.service;

import com.hospital.model.Medicine;
import java.util.List;

public interface PharmacyService {
    List<Medicine> getAllInventory();
    int getTotalCategories();
    int getLowStockCount();
    int getOutOfStockCount();
}
