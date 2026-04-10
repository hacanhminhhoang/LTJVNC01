package com.hospital.dao;

import com.hospital.model.Report;
import java.util.List;

public interface ReportDAO {
    List<Report> getAll();
    boolean insert(Report r);
    boolean updateStatus(String reportId, String status);
}
