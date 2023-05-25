import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/record.dart';
import 'button.dart';

class AddNoteForm extends StatefulWidget {
  static const routeName = '/sendginForm';
  final Function (String s ) callBack ;

  const AddNoteForm({super.key, required this.callBack});
  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  Map<String, double> countStatus(List<dynamic> records) {
    final statusCount = <String, double>{
      'Pass': 0,
      'Fail': 0,
      'Absence': 0,
      'Reject': 0,
    };

    for (final record in records) {
      final status = record.status;
      if (statusCount.containsKey(status)) {
        statusCount[status] = statusCount[status]! + 1;
      }
    }

    return statusCount;
  }

  String title = '';
  bool isLoding = false;
  double space = 10;
  final TextEditingController _noteController = TextEditingController();
  String _note = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 800,
        height: 900,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              right: 20,
              top: 10,
              bottom: 100,
              child: Animate(
                effects: [SlideEffect()],
                child: Container(
                  padding: EdgeInsets.only(top: 150),
                  child: Container(
                    decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(56, 142, 60, 1),
                              Color.fromRGBO(76, 175, 80, 1),
                              Color.fromRGBO(139, 195, 74, 1),
                            ])
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                        border:
                        Border.all(color: Colors.white.withOpacity(0.13)),
                        color: Colors.grey.shade200.withOpacity(0.35),

                      ),
                      child: Column(
                        children: [
                          Text(
                            'يرجى ادخال الملاحظة',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width - 800,
                            height: MediaQuery.of(context).size.height - 500,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.43),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _noteController,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40),
                              decoration: InputDecoration(
                                // labelText: 'Enter Message',
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                              ),

                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              // <-- SEE HERE
                              maxLines: 20, // <-- SEE HERE
                            ),
                          ),
                          SizedBox(
                            height: space,
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 120,
                            height: 50,
                            child: Center(
                              child: isLoding
                                  ? CircularProgressIndicator()
                                  : Button(
                                      txt: 'ارسال',
                                      icon: Icons.subdirectory_arrow_left,
                                      isSelected: true,
                                      onPress: () async {
                                        widget.callBack(_noteController.text.trim());
                                        Navigator.pop(context , _noteController.text);
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //  SizedBox(width: 300,),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please sign first."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop(); // dismiss dialog
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> sendRecords(List<dynamic> records, String url) async {
    final token = 'Bearer b0bf5071d23535c6251a9fa6ce2e463f';
    final String endpoint = 'https://example.com/api/records';

    try {
      final response = await http.post(Uri.parse(endpoint),
          headers: {'Authorization': token, 'Content-Type': 'application/json'},
          body: jsonEncode(records.map((r) => r.toJson(url)).toList()));

      if (response.statusCode == 200) {
        print('Records sent successfully!');
      } else {
        print('Failed to send records: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending records: $e');
    }
  }
}
