package com.hospital.service.impl;

import com.hospital.dao.MedicineDAO;
import com.hospital.dao.impl.MedicineDAOImpl;
import com.hospital.model.Medicine;
import com.hospital.service.PharmacyService;
import java.util.List;

public class PharmacyServiceImpl implements PharmacyService {
    private MedicineDAO medicineDAO = new MedicineDAOImpl();

    @Override
    public List<Medicine> getAllInventory() {
        return medicineDAO.getAllMedicines();
    }

    @Override
    public int getTotalCategories() {
        return 8; // Based on Figma mock data
    }

    @Override
    public int getLowStockCount() {
        return 2; // Based on Figma
    }

    @Override
    public int getOutOfStockCount() {
        return 1; // Based on Figma
    }
}
