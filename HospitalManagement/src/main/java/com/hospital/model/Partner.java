package com.hospital.model;

import java.time.LocalDate;

public class Partner {
    private String partnerId;
    private String partnerName;
    private String partnerType;
    private String contactEmail;
    private String phone;
    private String address;
    private String status;
    private LocalDate contractStart;
    private LocalDate contractEnd;

    public Partner() {}

    public Partner(String partnerId, String partnerName, String partnerType,
                   String contactEmail, String phone, String address,
                   String status, LocalDate contractStart, LocalDate contractEnd) {
        this.partnerId = partnerId;
        this.partnerName = partnerName;
        this.partnerType = partnerType;
        this.contactEmail = contactEmail;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.contractStart = contractStart;
        this.contractEnd = contractEnd;
    }

    public String getPartnerId() { return partnerId; }
    public void setPartnerId(String partnerId) { this.partnerId = partnerId; }

    public String getPartnerName() { return partnerName; }
    public void setPartnerName(String partnerName) { this.partnerName = partnerName; }

    public String getPartnerType() { return partnerType; }
    public void setPartnerType(String partnerType) { this.partnerType = partnerType; }

    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDate getContractStart() { return contractStart; }
    public void setContractStart(LocalDate contractStart) { this.contractStart = contractStart; }

    public LocalDate getContractEnd() { return contractEnd; }
    public void setContractEnd(LocalDate contractEnd) { this.contractEnd = contractEnd; }
}
