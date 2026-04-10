package com.hospital.dao;

import com.hospital.model.Revenue;
import java.math.BigDecimal;
import java.util.List;

public interface RevenueDAO {
    List<Revenue> getAllRevenue();
    BigDecimal getTotalRevenue();
    BigDecimal getTotalRevenueToday();
}
