import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:arabic_font/arabic_font.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:signature/signature.dart';
import 'package:tsti_signature/models/MyDialog.dart';
import 'package:tsti_signature/widgets/AddNoteForm.dart';
import 'package:tsti_signature/widgets/dropDownMenu.dart';
import 'package:tsti_signature/widgets/sendginForm.dart';
import '../models/PopupUtils.dart';
import '../models/record.dart';
import '../models/staticData.dart';
import '../widgets/button.dart';
import '../widgets/searchBar.dart';
import 'dart:ui' as ui;

class homePage extends StatefulWidget {
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
  String batchNrVar = '45';
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
  List<dynamic> reScedualGardsList = [];
  Map<String, dynamic> companyDic = {};
  Map <String,String> classDic = {} ;
  final _scrollController = ScrollController();
  bool sFeacher = false;
  String batchNr = '';

  // create controller

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  TextEditingController searchController = TextEditingController();

  void performSearch() {
    this.sFeacher = true;
    setState(() {});

    // String searchTerm = searchController.text;
    // Perform the search operation based on the searchTerm
    // Update the filtered records list or trigger the search logic here
  }

  void clearSearch() {
    searchController.clear();
    sFeacher = false;
    setState(() {});
    // Reset the search operation, show all records, or update the filtered records list accordingly
  }

  late DismissDirection d;
  final _key = GlobalKey<FormState>();

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
                  image: DecorationImage(
                    image: AssetImage('assests/b.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.13)),
                    color: Colors.grey.shade200.withOpacity(0.35),
                  ),
                ),
              );
            } else {
              return /*  Center(
                child: Container(
                  height: 40,
                  width: 300,
                  child:TextField()
                ),
              );*/
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                var screenSize =
                    constraints.biggest; // Initialize the screen size
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assests/b.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                            effects: [FadeEffect(), SlideEffect()],
                            child: Container(
                                width: screenSize.width - 100,
                                height: screenSize.height - 200,
                                //MediaQuery.of(context).size.height - 200,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.13)),
                                  color: Colors.grey.shade200.withOpacity(0.3),
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
                                        Tab(
                                            child: Text(
                                          'الحراس المعاد جدولتهم',
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
                                              scrollController:
                                                  _scrollController,
                                              dataRowHeight: 120,
                                              columns: [
                                                DataColumn2(
                                                    label: Text(
                                                  "الاسم",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الجنسية",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الشركة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "اسم الكورس",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الطول",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الوزن",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "النتيجة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "خيارات",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                              ],
                                              rows: sFeacher
                                                  ? this
                                                      .searchByName(
                                                          this.newGardsList,
                                                          searchController.text
                                                              .toString())
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.company,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                isDense: true,
                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        'zzz');
                                                                    dynamic x =
                                                                        await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AddNoteForm(
                                                                                callBack: (x) {
                                                                                  item.note = x;
                                                                                },
                                                                              )),
                                                                    );
                                                                    print(item +
                                                                        "item<<<<<");
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .note_add_outlined,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .red,
                                                                  )),
                                                              //SizedBox(width: 5,),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool b =
                                                                        false;
                                                                    await MyAlertDialog.showConfirmationDialog(
                                                                        context,
                                                                        'هل تريد حقا اعادة جدولة هذا الحارس ',
                                                                        () async {
                                                                      b = true;
                                                                    }, () {});
                                                                    if (b) {
                                                                      DateTime
                                                                          d =
                                                                          await _selectDate(
                                                                              context);
                                                                      String
                                                                          date =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(d);

                                                                      await addRecordToFirebase(
                                                                          item,
                                                                          date,
                                                                          item.note
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .schedule_outlined,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          )),
                                                        ]),
                                                      )
                                                      .toList()
                                                  : this
                                                      .newGardsList
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.company,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isDense: true,
                                                                isExpanded:
                                                                    true,

                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  dynamic x =
                                                                      await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            content: AddNoteForm(
                                                                              callBack: (x) {
                                                                                item.note = x;
                                                                              },
                                                                            )),
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .note_add_outlined,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                              //SizedBox(width: 5,),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool b =
                                                                        false;
                                                                    await MyAlertDialog.showConfirmationDialog(
                                                                        context,
                                                                        'هل تريد حقا اعادة جدولة هذا الحارس ',
                                                                        () async {
                                                                      b = true;
                                                                    }, () {});
                                                                    if (b) {
                                                                      DateTime
                                                                          d =
                                                                          await _selectDate(
                                                                              context);
                                                                      String
                                                                          date =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(d);

                                                                      await addRecordToFirebase(
                                                                          item,
                                                                          date,
                                                                          item.note
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .schedule_outlined,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          )),
                                                        ]),
                                                      )
                                                      .toList(),
                                            ),
                                          ),
                                          Center(
                                            child: DataTable2(
                                              scrollController:
                                                  _scrollController,
                                              dataRowHeight: 120,
                                              columns: [
                                                DataColumn2(
                                                    label: Text(
                                                  "الاسم",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الجنسية",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الشركة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "اسم الكورس",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الطول",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الوزن",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "النتيجة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "خيارات",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                              ],
                                              rows: sFeacher
                                                  ? this
                                                      .searchByName(
                                                          this.reNewGardsList,
                                                          searchController.text
                                                              .toString())
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.company,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                isDense: true,
                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    dynamic x =
                                                                        await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AddNoteForm(
                                                                                callBack: (x) {
                                                                                  item.note = x;
                                                                                },
                                                                              )),
                                                                    );
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .note_add_outlined,
                                                                    size: 30,
                                                                  )),
                                                              //SizedBox(width: 5,),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool b =
                                                                        false;
                                                                    await MyAlertDialog.showConfirmationDialog(
                                                                        context,
                                                                        'هل تريد حقا اعادة جدولة هذا الحارس ',
                                                                        () async {
                                                                      b = true;
                                                                    }, () {});
                                                                    if (b) {
                                                                      DateTime
                                                                          d =
                                                                          await _selectDate(
                                                                              context);
                                                                      String
                                                                          date =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(d);
                                                                      await addRecordToFirebase(
                                                                          item,
                                                                          date,
                                                                          item.note
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .schedule_outlined,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          )),
                                                        ]),
                                                      )
                                                      .toList()
                                                  : this
                                                      .reNewGardsList
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.company,
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isDense: true,
                                                                isExpanded:
                                                                    true,

                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  dynamic x =
                                                                      await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            content: AddNoteForm(
                                                                              callBack: (x) {
                                                                                item.note = x;
                                                                              },
                                                                            )),
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .note_add_outlined,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                              //SizedBox(width: 5,),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool b =
                                                                        false;
                                                                    await MyAlertDialog.showConfirmationDialog(
                                                                        context,
                                                                        'هل تريد حقا اعادة جدولة هذا الحارس ',
                                                                        () async {
                                                                      b = true;
                                                                    }, () {});
                                                                    if (b) {
                                                                      DateTime
                                                                          d =
                                                                          await _selectDate(
                                                                              context);
                                                                      String
                                                                          date =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(d);

                                                                      await addRecordToFirebase(
                                                                          item,
                                                                          date,
                                                                          item.note
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .schedule_outlined,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          )),
                                                        ]),
                                                      )
                                                      .toList(),

                                              /*map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.company,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  dynamic x =
                                                                      await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            content: AddNoteForm(
                                                                              callBack: (x) {
                                                                                item.note = x;
                                                                              },
                                                                            )),
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .note_add_outlined,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                              //SizedBox(width: 5,),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool b =
                                                                        false;
                                                                    await MyAlertDialog.showConfirmationDialog(
                                                                        context,
                                                                        'هل تريد حقا اعادة جدولة هذا الحارس ',
                                                                        () async {
                                                                      b = true;
                                                                    }, () {});
                                                                    if (b) {
                                                                      DateTime
                                                                          d =
                                                                          await _selectDate(
                                                                              context);
                                                                      String
                                                                          date =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(d);

                                                                      await addRecordToFirebase(
                                                                          item,
                                                                          date,
                                                                          item.note
                                                                              .toString());
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .schedule_outlined,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          )),
                                                        ]),
                                                      )
                                                      .toList(),*/
                                            ),
                                          ),
                                          Center(
                                            child: DataTable2(
                                              scrollController:
                                                  _scrollController,
                                              dataRowHeight: 120,
                                              columns: [
                                                DataColumn2(
                                                    label: Text(
                                                  "الاسم",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الجنسية",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "اسم الكورس",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الطول",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "الوزن",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "تاريخ الاعادة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "خيارات",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  "النتيجة",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                )),
                                              ],
                                              rows: sFeacher
                                                  ? this
                                                      .searchByName(
                                                          this
                                                              .reScedualGardsList,
                                                          searchController.text
                                                              .toString())
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(Text(
                                                            item.dob,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(IconButton(
                                                              onPressed:
                                                                  () async {
                                                                dynamic x =
                                                                    await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      AlertDialog(
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          content:
                                                                              AddNoteForm(
                                                                            callBack:
                                                                                (x) {
                                                                              item.note = x;
                                                                            },
                                                                          )),
                                                                );
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .note_add_outlined,
                                                                size: 30,
                                                              ))),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                isDense: true,
                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      )
                                                      .toList()
                                                  : this
                                                      .reScedualGardsList
                                                      .map(
                                                        (item) =>
                                                            DataRow2(cells: [
                                                          DataCell(Text(
                                                            item.nameEn,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.nationality,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                                          DataCell(Text(
                                                            item.course,
                                                            style: TextStyle(
                                                                fontSize: 20),
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
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(Text(
                                                            item.dob,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                          DataCell(IconButton(
                                                            onPressed:
                                                                () async {
                                                              dynamic x =
                                                                  await showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        content:
                                                                            AddNoteForm(
                                                                          callBack:
                                                                              (x) {
                                                                            item.note =
                                                                                x;
                                                                          },
                                                                        )),
                                                              );
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .note_add_outlined,
                                                              size: 30,
                                                            ),
                                                          )),
                                                          DataCell(
                                                            StatefulBuilder(
                                                              builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          setState) =>
                                                                  DropdownButton<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                isDense: true,
                                                                value:
                                                                    item.status,
                                                                //item.status ,
                                                                onChanged: (String?
                                                                    newValue) {
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
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                      value,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25),
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
                      effects: [FadeEffect(), SlideEffect(begin: Offset(0, 0))],
                      child: Positioned(
                        top: 100,
                        //MediaQuery.of(context).size.height - 150,
                        right: 50,
                        child: Container(
                          width: screenSize.width - 100,
                          //MediaQuery.of(context).size.width - 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SearchBar(
                                  searchController: searchController,
                                  onSearch: performSearch,
                                  onClear: clearSearch,
                                ),
                              )),
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
                                        builder: (BuildContext context) {
                                          if (_tabController.index == 2) {
                                            // print("debug");

                                            if (!reScedualGardsList.isEmpty)
                                              return AlertDialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: sendginForm(
                                                    batchNrVarInSendingForm: batchNrVar,
                                                      tab: 2,
                                                      rec: this
                                                          .reScedualGardsList));

                                            return AlertDialog(
                                              title: Text('تنبيه'),
                                              content: Text(
                                                  'لا يوجد حراس ضمن اعادة الجدولة'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          } else {
                                            return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: sendginForm(
                                                  batchNrVarInSendingForm: batchNrVar,
                                                    tab: _tabController.index,
                                                    rec: _tabController.index ==
                                                            0
                                                        ? this.newGardsList
                                                        : this.reNewGardsList));
                                          }
                                        });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),

                                      //  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                      color: Colors.grey.shade200
                                          .withOpacity(0.45)),
                                  child: DropdownButtonFormField<String>(
                                   decoration: InputDecoration(
                                     enabledBorder: InputBorder.none,
                                    prefixText: '            Batch Nr:  ',

                                   ),

                                    value: batchNrVar,
                                    onChanged: (newValue) {
                                      setState(() {
                                        this.newGardsList = [] ;
                                        batchNrVar = newValue!;
                                      });
                                    },
                                    items: MyData.myList
                                        .map((e) => DropdownMenuItem<String>(
                                              value: e.toString(),
                                              child: Text(e.toString()),
                                            ))
                                        .toList(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    dropdownColor: Colors.grey[200],
                                    icon: Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            // Get the screen size and resolution
                          }),
                    )
                  ],
                );
              });
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
  Future<List> fetchRecordsNewGards(String BatchNr) async {
    List<dynamic> records2 = [];
    List<String> patchNr = await getPatchNr();
    String url = '''https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "New" }, { "key": "Batch", "constraint_type": "equals", "value": "${batchNrVar}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]''';
    final response =
        await http.get(Uri.parse(url), headers: {'Accept-Charset': 'utf-8'});
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)["response"];
      // print(data[0]["results"]["batch"] ?? '404');

      final List<dynamic> records = data["results"]
          .map((item) => Record(
              reschedule: item["xxx"] ?? '',
              modifiedDate: item["Modified Date"] ?? '',
              createdDate: item["Created Date"] ?? '',
              createdBy: item["Created By"] ?? '',
              assdAttachment: item["passport attachment"] ?? '',
              assdExpiry: item["passport expiry"] ?? '',
              assdNumber: item["passport number"] ?? '',
              className:  this.classDic[item["Class"]]?? '4 04notfound' ,  //item["Class"] ?? '',
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
              medicalReportAttachment: item["medical report attachment"] ?? '',
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
              note: item['note'] ?? ''))
          .toList();
      if(data['remaining']!=0){
        String url2 = 'https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "New" }, { "key": "Batch", "constraint_type": "equals", "value": "${batchNrVar}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]&cursor=99&limit=200';
        final remainingDataResponse =
        await http.get(Uri.parse(url2), headers: {'Accept-Charset': 'utf-8'});
        final dynamic dataRe = json.decode(remainingDataResponse.body)["response"];
             records2 = dataRe["results"]
            .map((item) => Record(
            reschedule: item["xxx"] ?? '',
            modifiedDate: item["Modified Date"] ?? '',
            createdDate: item["Created Date"] ?? '',
            createdBy: item["Created By"] ?? '',
            assdAttachment: item["passport attachment"] ?? '',
            assdExpiry: item["passport expiry"] ?? '',
            assdNumber: item["passport number"] ?? '',
            className:  this.classDic[item["Class"]]?? '4 04notfound' ,  //item["Class"] ?? '',
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
            medicalReportAttachment: item["medical report attachment"] ?? '',
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
            note: item['note'] ?? ''))
            .toList();

      }
      batchNr = records[0].batch.toString() ?? '';
      MyData.data = batchNr;
      this.newGardsList = records + records2 ;
      //print(this.newGardsList.length);


      return records;
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<List> fetchRecordsReNewGards(String BatchNr) async {
    List<dynamic> records2 = [];
    List<String> patchNr = await getPatchNr();
    String url =
        '''https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "Renew" }, { "key": "Batch", "constraint_type": "equals", "value": "${batchNrVar}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]''';
    final response =
        await http.get(Uri.parse(url), headers: {'Accept-Charset': 'utf-8'});
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)["response"];
      final List<dynamic> records = data["results"]
          .map((item) => Record(
              reschedule: item["zxz"] ?? '',
              modifiedDate: item["Modified Date"] ?? '',
              createdDate: item["Created Date"] ?? '',
              createdBy: item["Created By"] ?? '',
              assdAttachment: item["passport attachment"] ?? '',
              assdExpiry: item["passport expiry"] ?? '',
              assdNumber: item["passport number"] ?? '',
              className:  this.classDic[item["Class"]] ?? '',
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
              medicalReportAttachment: item["medical report attachment"] ?? '',
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
              note: item['note'] ?? ''))
          .toList();

      if(data['remaining']!=0){
        String url2 = 'https://www.tsti.ae/api/1.1/obj/new_request?constraints=[ { "key": "Course-type", "constraint_type": "equals", "value": "Renew" }, { "key": "Batch", "constraint_type": "equals", "value": "${batchNrVar}" }, { "key": "Status", "constraint_type": "equals", "value": "Scheduled" }]&cursor=99&limit=200';
        final remainingDataResponse =
        await http.get(Uri.parse(url2), headers: {'Accept-Charset': 'utf-8'});
        final dynamic dataRe = json.decode(remainingDataResponse.body)["response"];
        records2 = dataRe["results"]
            .map((item) => Record(
            reschedule: item["xxx"] ?? '',
            modifiedDate: item["Modified Date"] ?? '',
            createdDate: item["Created Date"] ?? '',
            createdBy: item["Created By"] ?? '',
            assdAttachment: item["passport attachment"] ?? '',
            assdExpiry: item["passport expiry"] ?? '',
            assdNumber: item["passport number"] ?? '',
            className:  this.classDic[item["Class"]]?? '4 04notfound' ,  //item["Class"] ?? '',
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
            medicalReportAttachment: item["medical report attachment"] ?? '',
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
            note: item['note'] ?? ''))
            .toList();

      }


      this.reNewGardsList = records + records2;
      print( this.reNewGardsList.length);
      return records;
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<List<dynamic>> fetchRecordsReScedualGards() async {
    List<dynamic> dataList = [];

    try {
      // Access the Firestore collection where your data is stored
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('reschedule');

      // Retrieve the documents from the collection
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Loop through the documents
      querySnapshot.docs.forEach((doc) {
        // Access the data fields within each document
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String redate = data['redate'] ?? 'notFound404';
        data = data['gard'];

        // Create a Record object from the data
        Record record = Record(
            reschedule: data["zxz"] ?? 'notfund404',
            modifiedDate: data["Modified Date"] ?? '',
            createdDate: data["Created Date"] ?? '',
            createdBy: data["Created By"] ?? '',
            assdAttachment: data["passport attachment"] ?? '',
            assdExpiry: data["passport expiry"] ?? '',
            assdNumber: data["passport number"] ?? '',
            className: data["Class"] ?? '',
            company: data["company"] ?? '',
            course: data["course"] ?? '',
            courseType: data["coursetype"] ?? '',
            dob: redate ?? '',
            education: data["education"] ?? '',
            eidBackAttachment: data["eid back attachment"] ?? '',
            eidExpiry: data["eid expiry"] ?? '',
            eidFrontAttachment: data["eid front attachment"] ?? '',
            eidNumber: data["eid number"] ?? '',
            empid: data["employeeid"] ?? 'xxx',
            experienceInUae: data["experience in uae"] ?? '',
            experienceOutUae: data["experience out uae"] ?? '',
            gender: data["gender"] ?? '',
            height: data["height"] ?? '',
            language: data["language"] ?? '',
            licenseFor: data["license for"] ?? '',
            medicalReportAttachment: data["medical report attachment"] ?? '',
            nameAr: data["name ar"] ?? '',
            nameEn: data["name"] ?? '404 notfind',
            nationalityAr: data["nationality ar"] ?? '',
            nationality: data["nationality"] ?? '',
            nsiAttachment: data["NSI attachment"] ?? '',
            passportAttachment: data["passport attachment"] ?? '',
            passportExpiry: data["passport expiry"] ?? '',
            passportNumber: data["passport number"] ?? '',
            photo: data["photo"] ?? '',
            remarks: data["remarks"] ?? '',
            securityExperience: data["security experience"] ?? '',
            status: 'Pass' ?? '',
            trainee: data["Trainee"] ?? '',
            uid: data["uid"] ?? '',
            visaAttachment: data["visa attachment"] ?? '',
            weight: data["weight"] ?? '',
            returnRemarks: data["return remarks"] ?? '',
            reviewedBy: data["Reviewed By"] ?? '',
            completeDate: data["complete date"] ?? '',
            isPaid: data["isPaid"] ?? false,
            paymentVar: data["paymentVar"] ?? '',
            paymentID: data["paymentID"] ?? 0,
            pmethod: data["pmethod"] ?? '',
            batch: data["batch"] ?? '',
            id: data['_id'] ?? '',
            note: data['note'] ?? '');

        // Add the Record object to the dataList
        dataList.add(record);
      });
      this.reScedualGardsList = dataList;
    } catch (e) {
      // Handle any errors that occur during the data retrieval process
      print('Error retrieving data from Firebase: $e');
    }

    return dataList;
  }

  Future<void> initt() async {
    try {
      if (this.newGardsList.isEmpty) {
        this.companyDic = await getCompanyData() as Map<String, dynamic>;
        await fetchOngoingClasses();
        await fetchRecordsNewGards(batchNrVar);
        await fetchRecordsReNewGards(batchNrVar);
        await fetchRecordsReScedualGards();

        List<String> patchNrsList = await getPatchNr();
        MyData.myList = Set<String>.from(patchNrsList).toList();



        // await getExcludedEmployeeIds();
      } else {
        print('already loaded');


      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, String>> fetchOngoingClasses() async {
    final url = 'https://www.tsti.ae/version-live/api/1.1/obj/classes/?constraints=[ { \"key\": \"Status\", \"constraint_type\": \"equals\", \"value\": \"Ongoing\" }]';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final classes = jsonData['response']['results'];
      final classMap = Map<String, String>();
      for (var classData in classes) {
        final id = classData['_id'];
        final title = classData['title'];
        classMap[id] = title;
      }
      this.classDic = classMap ;
      return classMap;
    } else {

      throw Exception('Failed to fetch ongoing classes');
    }
  }



  List<dynamic> searchByName(List<dynamic> records, String name) {
    if (name.isEmpty) {
      return records; // Return all records if the name is empty
    }

    name = name
        .toLowerCase(); // Convert name to lowercase for case-insensitive search

    return records.where((record) {
      // Filter records by name
      return record.nameEn.toLowerCase().contains(name);
    }).toList();
  }

  Future<List<String>> getExcludedEmployeeIds() async {
    QuerySnapshot rescheduleSnapshot =
        await FirebaseFirestore.instance.collection('reschedule').get();

    List<String> excludedIds = rescheduleSnapshot.docs.map((doc) {
      Map<String, dynamic> gardData = doc.data() as Map<String, dynamic>;
      print(gardData['gard']['employeeid'] ?? 'notfound');
      gardData ??= {}; // Assign an empty map if gardData is null
      String employeeId = gardData['employeeid'] ?? '';
      return employeeId;
    }).toList();

    return excludedIds;
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

  DateTime selectedDate = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    return selectedDate;

    //print(selectedDate);
  }

  Future<void> addRecordToFirebase(Record record, String d, String note) async {
    try {
      // Access the "reschedule" collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('reschedule');

      // Create a new document with an auto-generated ID
      DocumentReference document = collection.doc();

      // Convert the record to a JSON-compatible map using the toJson method
      Map<String, dynamic> recordData = record.toJson('');
      print(recordData.toString() + "<<<<<<<<<<<<<<<<<");

      // Set the record data in the document
      await document.set({
        'gard': recordData,
        'redate': d.toString().length > 8
            ? d.toString().substring(0, 10)
            : d.toString(),
        'note': note
      });
      print('Record added successfully');
    } catch (e) {
      print('Error adding record: $e');
    }
  }

}

void doNothing(BuildContext context) {}

void handelTheNote(BuildContext context) {
  MyDialog.showAlert(context, 'dummy');
}

Future<void> createDocumentWithId(String documentId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collection = firestore.collection('your_collection_name');

  // Replace 'your_collection_name' with the actual name of your collection

  DocumentReference docRef = collection.doc(documentId);

  Map<String, dynamic> data = {
    'field1': 'value1',
    'field2': 'value2',
    // Add more fields and their values as needed
  };

  docRef
      .set(data)
      .then((value) =>
          print('Document created successfully with ID: $documentId'))
      .catchError((error) => print('Failed to create document: $error'));
}
