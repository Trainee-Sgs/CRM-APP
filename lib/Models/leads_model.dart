class LeadResponse {
  final bool error;
  final String type;
  final String cid;
  final String uid;
  final String enquiryType;
  final String deviceId;
  final String token;
  final int totalCount;
  final List<LeadDetail> details;

  LeadResponse({
    required this.error,
    required this.type,
    required this.cid,
    required this.uid,
    required this.enquiryType,
    required this.deviceId,
    required this.token,
    required this.totalCount,
    required this.details,
  });

  factory LeadResponse.fromJson(Map<String, dynamic> json) {
    return LeadResponse(
      error: json['error'] ?? false,
      type: json['type']?.toString() ?? '',
      cid: json['cid']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      enquiryType: json['enquiry_type']?.toString() ?? '',
      deviceId: json['device_id']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      totalCount: json['total_count'] ?? 0,
      details: (json['details'] as List?)
              ?.map((d) => LeadDetail.fromJson(d))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'type': type,
      'cid': cid,
      'uid': uid,
      'enquiry_type': enquiryType,
      'device_id': deviceId,
      'token': token,
      'total_count': totalCount,
      'details': details.map((d) => d.toJson()).toList(),
    };
  }
}

class LeadDetail {
  final int id;
  final String enquiryDate;
  final String leName;
  final String companyName;
  final String contactPerson;
  final String mobile1;
  final String mobile2;
  final String email;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String leadSource;
  final String productService;
  final String category;
  final String requirementNotes;
  final String attendedBy;
  final int enquiryType;
  final String assignedTo;
  final String remarks;

  LeadDetail({
    required this.id,
    required this.enquiryDate,
    required this.leName,
    required this.companyName,
    required this.contactPerson,
    required this.mobile1,
    required this.mobile2,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.leadSource,
    required this.productService,
    required this.category,
    required this.requirementNotes,
    required this.attendedBy,
    required this.enquiryType,
    required this.assignedTo,
    required this.remarks,
  });

  factory LeadDetail.fromJson(Map<String, dynamic> json) {
    return LeadDetail(
      id: json['id'] ?? 0,
      enquiryDate: json['enquiry_date']?.toString() ?? '',
      leName: json['le_name']?.toString() ?? '',
      companyName: (json['comany_name'] ?? json['company_name'] ?? '').toString(), // Supporting provided typo 'comany_name'
      contactPerson: json['contact_person']?.toString() ?? '',
      mobile1: json['mobile_1']?.toString() ?? '',
      mobile2: (json['moble_2'] ?? json['mobile_2'] ?? '').toString(), // Supporting provided typo 'moble_2'
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      pincode: json['pincode']?.toString() ?? '',
      leadSource: json['lead_source']?.toString() ?? '',
      productService: json['product_service']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      requirementNotes: json['requirement_notes']?.toString() ?? '',
      attendedBy: json['attended_by']?.toString() ?? '',
      enquiryType: json['enquiry_type'] is int ? json['enquiry_type'] : 0,
      assignedTo: json['assigned_to']?.toString() ?? '',
      remarks: json['remarks']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enquiry_date': enquiryDate,
      'le_name': leName,
      'comany_name': companyName,
      'contact_person': contactPerson,
      'mobile_1': mobile1,
      'moble_2': mobile2,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'lead_source': leadSource,
      'product_service': productService,
      'category': category,
      'requirement_notes': requirementNotes,
      'attended_by': attendedBy,
      'enquiry_type': enquiryType,
      'assigned_to': assignedTo,
      'remarks': remarks,
    };
  }

  /// Support for existing Map-style access in UI
  dynamic operator [](String key) {
    switch (key) {
      case 'id': return id;
      case 'enquiry_date': return enquiryDate;
      case 'le_name': return leName;
      case 'comany_name':
      case 'company_name': return companyName;
      case 'contact_person': return contactPerson;
      case 'mobile_1': return mobile1;
      case 'moble_2':
      case 'mobile_2': return mobile2;
      case 'email': return email;
      case 'address': return address;
      case 'city': return city;
      case 'state': return state;
      case 'pincode': return pincode;
      case 'lead_source': return leadSource;
      case 'product_service': return productService;
      case 'category': return category;
      case 'requirement_notes': return requirementNotes;
      case 'attended_by': return attendedBy;
      case 'enquiry_type': return enquiryType;
      case 'assigned_to': return assignedTo;
      case 'remarks': return remarks;
      default: return null;
    }
  }
}
