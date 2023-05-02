import 'dart:convert';
import 'package:http/http.dart' as http;


class Record {
  final String modifiedDate;
  final String createdDate;
  final String createdBy;
  final String assdAttachment;
  final String assdExpiry;
  final String assdNumber;
  final String className;
  final String company;
  final String course;
  final String courseType;
  final String dob;
  final String education;
  final String eidBackAttachment;
  final String eidExpiry;
  final String eidFrontAttachment;
  final String eidNumber;
  final String empid;
  final String experienceInUae;
  final String experienceOutUae;
  final String gender;
  final String height;
  final String language;
  final String licenseFor;
  final String medicalReportAttachment;
  final String nameAr;
  final String nameEn;
  final String nationalityAr;
  final String nationality;
  final String nsiAttachment;
  final String passportAttachment;
  final String passportExpiry;
  final String passportNumber;
  final String photo;
  final String remarks;
  final String securityExperience;
   String status;
  final String trainee;
  final String uid;
  final String visaAttachment;
  final String weight;
  final String returnRemarks;
  final String reviewedBy;
  final String completeDate;
  final bool isPaid;
  final String paymentVar;
  final int paymentID;
  final String pmethod;
  final String batch;
  final String id;

  Record({required this.modifiedDate,
    required this.createdDate,
    required this.createdBy,
    required this.assdAttachment,
    required this.assdExpiry,
    required this.assdNumber,
    required this.className,
    required this.company,
    required this.course,
    required this.courseType,
    required this.dob,
    required this.education,
    required this.eidBackAttachment,
    required this.eidExpiry,
    required this.eidFrontAttachment,
    required this.eidNumber,
    required this.empid,
    required this.experienceInUae,
    required this.experienceOutUae,
    required this.gender,
    required this.height,
    required this.language,
    required this.licenseFor,
    required this.medicalReportAttachment,
    required this.nameAr,
    required this.nameEn,
    required this.nationalityAr,
    required this.nationality,
    required this.nsiAttachment,
    required this.passportAttachment,
    required this.passportExpiry,
    required this.passportNumber,
    required this.photo,
    required this.remarks,
    required this.securityExperience,
    required this.status,
    required this.trainee,
    required this.uid,
    required this.visaAttachment,
    required this.weight,
    required this.returnRemarks,
    required this.reviewedBy,
    required this.completeDate,
    required this.isPaid,
    required this.paymentVar,
    required this.paymentID,
    required this.pmethod,
    required this.batch,
    required this.id});



  Map<String, dynamic> toJson(String signature ) =>
      {
        'employeeid': empid,
        'name': nameEn,
        'nationality': nationality,
        'height': height,
        'weight': weight,
        'company': company,
        'course': course,
        'coursetype': courseType,
        'result': status,
        'signature': signature,

      };




}




