import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:arabic_font/arabic_font.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:tsti_signature/widgets/dropDownMenu.dart';
import 'package:tsti_signature/widgets/sendginForm.dart';
import '../models/record.dart';
import '../widgets/button.dart';

class homePage extends StatefulWidget   {
  static const routeName = '/homePage';

   homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  String value = 'Item 1';
  String selectedValue = 'Item 1';
  String startDate = "20/20/2020";
  String endDate = "20/20/2030";
  String instructorName = "Nitro";
  List<Map<String, dynamic>> data = [
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "John",
      "Nationality": "USA",
      "Company": "ABC Inc.",
      "Height": 1.8,
      "Weight": 75,
      "Status": "Pass",
    },
    {
      "Name": "Alice",
      "Nationality": "Canada",
      "Company": "XYZ Ltd.",
      "Height": 1.65,
      "Weight": 60,
      "Status": "Fail",
    },
    {
      "Name": "Bob",
      "Nationality": "UK",
      "Company": "PQR Co.",
      "Height": 1.75,
      "Weight": 80,
      "Status": "Absence",
    },
  ];
  final List<Map<String, dynamic>> list1 = [
    {"Name": "Alice", "Age": 25},
    {"Name": "Bob", "Age": 30},
    {"Name": "Charlie", "Age": 35},
    {"Name": "David", "Age": 40},
  ];
  final List<Map<String, dynamic>> list2 = [
    {"Name": "Eve", "Age": 45},
    {"Name": "Frank", "Age": 50},
    {"Name": "Grace", "Age": 55},
    {"Name": "Henry", "Age": 60},
  ];
  late TabController _tabController;
  List<dynamic> newGardsList = [];
  List<dynamic> reNewGardsList = [];
  Map<String, dynamic> companyDic = {};
  final _scrollController = ScrollController();
  // create controller

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: initt(),
          builder: (ctx, f) {
            if (f.hasError) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(56, 142, 60, 1),
                      Color.fromRGBO(76, 175, 80, 1),
                      Color.fromRGBO(139, 195, 74, 1),
                    ])),
                child: Container(
                  child: Center(child: Text("Error")),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.13)),
                    color: Colors.grey.shade200.withOpacity(0.35),
                  ),
                ),
              );
            }
            if (f.connectionState == ConnectionState.waiting) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(56, 142, 60, 1),
                      Color.fromRGBO(76, 175, 80, 1),
                      Color.fromRGBO(139, 195, 74, 1),
                    ])),
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.13)),
                    color: Colors.grey.shade200.withOpacity(0.35),
                  ),
                ),
              );
            } else {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(56, 142, 60, 1),
                          Color.fromRGBO(76, 175, 80, 1),
                          Color.fromRGBO(139, 195, 74, 1),
                        ])),
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.13)),
                        color: Colors.grey.shade200.withOpacity(0.35),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    right: 50,
                    child: SingleChildScrollView(
                      child: DefaultTabController(
                        length: 2,
                        child: Animate(
                          effects: [FadeEffect()],
                          child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.height - 200,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.13)),
                                color: Colors.grey.shade200.withOpacity(0.63),
                              ),
                              child: Column(
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    indicatorColor: Colors.blue,
                                    labelColor: Colors.blue,
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Tab(
                                          child: Text(
                                        'جديد ',
                                        style: TextStyle(fontSize: 24),
                                      )),
                                      Tab(
                                          child: Text(
                                        'تجديد',
                                        style: TextStyle(fontSize: 24),
                                      )),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        // Personal Tab
                                        Center(
                                          child: DataTable2(
                                            scrollController: _scrollController,
                                            dataRowHeight: 120,
                                            columns: [
                                              DataColumn2(
                                                  label: Text(
                                                "الاسم",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الجنسية",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الشركة",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "اسم الكورس",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الطول",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الوزن",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "النتيجة",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                            ],
                                            rows: newGardsList
                                                .map(
                                                  (item) => DataRow2(cells: [
                                                    DataCell(Text(
                                                      item.nameEn,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.nationality,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.company,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.course,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.height,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.weight,
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.black),
                                                    )),
                                                    DataCell(
                                                      StatefulBuilder(
                                                        builder: (BuildContext context, StateSetter setState)=> DropdownButton<String>(
                                                          value: item.status,
                                                          //item.status ,
                                                          onChanged:
                                                              (String? newValue) {
                                                            setState(() {
                                                              item.status =
                                                                  newValue;

                                                            });
                                                              },
                                                          items: <String>[
                                                            'Pass',
                                                            'Fail',
                                                            'Absence',
                                                            'Reject'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 25),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                                .toList(),
                                          ),
                                        ),

                                        // Documents Tab
                                        Center(
                                          child: DataTable2(
                                            dataRowHeight: 120,
                                            columns: [
                                              DataColumn2(
                                                  label: Text(
                                                "الاسم",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الجنسية",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الشركة",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "اسم الكورس",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الطول",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "الوزن",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                              DataColumn2(
                                                  label: Text(
                                                "النتيجة",
                                                style: TextStyle(fontSize: 25),
                                              )),
                                            ],
                                            rows: reNewGardsList
                                                .map(
                                                  (item) => DataRow2(cells: [
                                                    DataCell(Text(
                                                      item.nameEn,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.nationality,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.company,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.course,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.height,
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )),
                                                    DataCell(Text(
                                                      item.weight,
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.black),
                                                    )),
                                                    DataCell(
                                                      StatefulBuilder(
                                                        builder: (BuildContext context, StateSetter setState)=> DropdownButton<String>(
                                                          value: item.status,
                                                          //item.status ,
                                                          onChanged:
                                                              (String? newValue) {
                                                            setState(() {
                                                              item.status =
                                                                  newValue;

                                                            });
                                                          },
                                                          items: <String>[
                                                            'Pass',
                                                            'Fail',
                                                            'Absence',
                                                            'Reject'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                          value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 25),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                  Animate(
                    effects: [FadeEffect()],
                    child: Positioned(
                      bottom: MediaQuery.of(context).size.height - 150,
                      right: 50,
                      child: Container(
                        width: MediaQuery.of(context).size.width  - 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Button(
                                txt: "نجاح للكل",
                                icon: Icons.subdirectory_arrow_left,
                                isSelected: true,
                                onPress: () {
                                  try {
                                    int idx = _tabController.index;
                                    if (idx == 0) {
                                      // new patch
                                      for (var i in newGardsList) {
                                        i.status = 'Pass';
                                      }
                                      setState(() {});
                                    } else {
                                      // renew patch
                                      for (var i in reNewGardsList) {
                                        i.status = 'Pass';
                                      }
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    print(">>>>   " + e.toString());
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Button(
                                txt: "رسوب للكل",
                                icon: Icons.subdirectory_arrow_left,
                                isSelected: true,
                                onPress: () {
                                  try {
                                    int idx = _tabController.index;
                                    if (idx == 0) {
                                      // new patch
                                      for (var i in newGardsList) {
                                        i.status = 'Fail';
                                      }
                                      setState(() {});
                                    } else {
                                      // renew patch
                                      for (var i in reNewGardsList) {
                                        i.status = 'Fail';
                                      }
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    print(">>>>   " + e.toString());
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Button(
                                txt: "ارسال النتائج",
                                icon: Icons.subdirectory_arrow_left,
                                isSelected: true,
                                onPress: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: sendginForm(
                                          neww: _tabController.index == 0 ? true : false ,
                                            rec: _tabController.index == 0
                                                ? this.newGardsList
                                                : this.reNewGardsList)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  // Function 1: GetCompanyData

  Future<String?> getClassesData() async {
    String url =
        "https://www.tsti.ae/version-live/api/1.1/obj/classes/?constraints=[ { \"key\": \"Status\", \"constraint_type\": \"equals\", \"value\": \"Ongoing\" }]";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // debugPrint(response.body.toString());
      return jsonResponse.toString();
    }
    return null;
  }

  Future<bool> checkForInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<List<String>> getPatchNr() async {
    String url =
        "https://www.tsti.ae/version-live/api/1.1/obj/classes/?constraints=[ { \"key\": \"Status\", \"constraint_type\": \"equals\", \"value\": \"Ongoing\" }]";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var dynamicResult2 = jsonDecode(response.body);
      int count = dynamicResult2["response"]["count"];

      List<String> titles = [];

      for (int i = 0; i < count; i++) {
        String title =
            dynamicResult2["response"]["results"][i]["batch"].toString();
        titles.add(title);
      }

      return titles;
    }

    return [];
  }

  // fetaching gards new
  Future<List> fetchRecordsNewGards() async {
      List<String> patchNr = await getPatchNr();
      String url =
      '''https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "New" }, { "key": "Batch", "constraint_type": "equals", "value": "${patchNr[0]}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]''';
      final response =
      await http.get(Uri.parse(url), headers: {'Accept-Charset': 'utf-8'});
      if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)["response"];
      final List<dynamic> records = data["results"]
          .map((item) => Record(
      modifiedDate: item["Modified Date"] ?? '',
      createdDate: item["Created Date"] ?? '',
      createdBy: item["Created By"] ?? '',
      assdAttachment: item["passport attachment"] ?? '',
      assdExpiry: item["passport expiry"] ?? '',
      assdNumber: item["passport number"] ?? '',
      className: item["Class"] ?? '',
      company: this.companyDic[item["company"]] ?? '',
                course: item["course"] ?? '',
                courseType: item["course-type"] ?? '',
                dob: item["dob"] ?? '',
                education: item["education"] ?? '',
                eidBackAttachment: item["eid back attachment"] ?? '',
                eidExpiry: item["eid expiry"] ?? '',
                eidFrontAttachment: item["eid front attachment"] ?? '',
                eidNumber: item["eid number"] ?? '',
                empid: item["empid"] ?? '',
                experienceInUae: item["experience in uae"] ?? '',
                experienceOutUae: item["experience out uae"] ?? '',
                gender: item["gender"] ?? '',
                height: item["height"] ?? '',
                language: item["language"] ?? '',
                licenseFor: item["license for"] ?? '',
                medicalReportAttachment:
                    item["medical report attachment"] ?? '',
                nameAr: item["name ar"] ?? '',
                nameEn: item["name en"] ?? '',
                nationalityAr: item["nationality ar"] ?? '',
                nationality: item["nationality"] ?? '',
                nsiAttachment: item["NSI attachment"] ?? '',
                passportAttachment: item["passport attachment"] ?? '',
                passportExpiry: item["passport expiry"] ?? '',
                passportNumber: item["passport number"] ?? '',
                photo: item["photo"] ?? '',
                remarks: item["remarks"] ?? '',
                securityExperience: item["security experience"] ?? '',
                status: 'Pass',
                trainee: item["Trainee"] ?? '',
                uid: item["uid"] ?? '',
                visaAttachment: item["visa attachment"] ?? '',
                weight: item["weight"] ?? '',
                returnRemarks: item["return remarks"] ?? '',
                reviewedBy: item["Reviewed By"] ?? '',
                completeDate: item["complete date"] ?? '',
                isPaid: item["isPaid"] ?? false,
                paymentVar: item["paymentVar"] ?? '',
                paymentID: item["paymentID"] ?? 0,
                pmethod: item["pmethod"] ?? '',
                batch: item["batch"] ?? '',
                id: item['_id'] ?? '',
              ))
          .toList();

      this.newGardsList = records;
      return records;
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<List> fetchRecordsReNewGards() async {
    List<String> patchNr = await getPatchNr();
    String url =
        '''https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "Renew" }, { "key": "Batch", "constraint_type": "equals", "value": "${patchNr[0]}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]''';
    final response =
        await http.get(Uri.parse(url), headers: {'Accept-Charset': 'utf-8'});
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)["response"];
      final List<dynamic> records = data["results"]
          .map((item) => Record(
                modifiedDate: item["Modified Date"] ?? '',
                createdDate: item["Created Date"] ?? '',
                createdBy: item["Created By"] ?? '',
                assdAttachment: item["passport attachment"] ?? '',
                assdExpiry: item["passport expiry"] ?? '',
                assdNumber: item["passport number"] ?? '',
                className: item["Class"] ?? '',
                company: this.companyDic[item["company"]] ?? '',
                course: item["course"] ?? '',
                courseType: item["course-type"] ?? '',
                dob: item["dob"] ?? '',
                education: item["education"] ?? '',
                eidBackAttachment: item["eid back attachment"] ?? '',
                eidExpiry: item["eid expiry"] ?? '',
                eidFrontAttachment: item["eid front attachment"] ?? '',
                eidNumber: item["eid number"] ?? '',
                empid: item["empid"] ?? '',
                experienceInUae: item["experience in uae"] ?? '',
                experienceOutUae: item["experience out uae"] ?? '',
                gender: item["gender"] ?? '',
                height: item["height"] ?? '',
                language: item["language"] ?? '',
                licenseFor: item["license for"] ?? '',
                medicalReportAttachment:
                    item["medical report attachment"] ?? '',
                nameAr: item["name ar"] ?? '',
                nameEn: item["name en"] ?? '',
                nationalityAr: item["nationality ar"] ?? '',
                nationality: item["nationality"] ?? '',
                nsiAttachment: item["NSI attachment"] ?? '',
                passportAttachment: item["passport attachment"] ?? '',
                passportExpiry: item["passport expiry"] ?? '',
                passportNumber: item["passport number"] ?? '',
                photo: item["photo"] ?? '',
                remarks: item["remarks"] ?? '',
                securityExperience: item["security experience"] ?? '',
                status: 'Pass' ?? '',
                trainee: item["Trainee"] ?? '',
                uid: item["uid"] ?? '',
                visaAttachment: item["visa attachment"] ?? '',
                weight: item["weight"] ?? '',
                returnRemarks: item["return remarks"] ?? '',
                reviewedBy: item["Reviewed By"] ?? '',
                completeDate: item["complete date"] ?? '',
                isPaid: item["isPaid"] ?? false,
                paymentVar: item["paymentVar"] ?? '',
                paymentID: item["paymentID"] ?? 0,
                pmethod: item["pmethod"] ?? '',
                batch: item["batch"] ?? '',
                id: item['_id'] ?? '',
              ))
          .toList();

      this.reNewGardsList = records;
      return records;
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<void> initt() async {
    try {
      if (this.newGardsList.isEmpty) {
        this.companyDic = await getCompanyData() as Map<String, dynamic>;
        await fetchRecordsNewGards();
        await fetchRecordsReNewGards();
      } else {
        print('already loaded');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getCompanyData() async {
    final response = await http.get(
        Uri.parse('https://www.tsti.ae/version-live/api/1.1/obj/companies'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final dynamic results = data["response"]["results"];
      final Map<String, String> companies = {};

      for (final company in results) {
        final String id = company['_id'] ?? "";
        final String name = company['name'] ?? "";
        companies[id] = name;
      }
      //companies.forEach((k, v) => print("Key : $k, Value : $v"));
      return companies;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

}
