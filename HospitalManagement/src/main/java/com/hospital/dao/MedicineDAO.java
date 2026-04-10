package com.hospital.dao;

import com.hospital.model.Medicine;
import java.util.List;

public interface MedicineDAO {
    List<Medicine> getAllMedicines();
    Medicine getMedicineById(String medicineId);
    boolean addMedicine(Medicine medicine);
    boolean updateMedicine(Medicine medicine);
}
