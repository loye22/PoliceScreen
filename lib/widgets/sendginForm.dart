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

class sendginForm extends StatefulWidget {
  static const routeName = '/sendginForm';
  final List<dynamic> rec;
  final bool neww;

  const sendginForm({super.key, required this.rec, required this.neww});

//  const AddDepartmantForm({Key? key}) : super(key: key);

  @override
  State<sendginForm> createState() => _sendginFormState();
}

class _sendginFormState extends State<sendginForm> {
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

  SignatureController _controller = SignatureController(
    penStrokeWidth: 2,

    /// signature pen color
    penColor: Colors.black,

    /// signature background color when exported!
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  String title = '';
  bool isLoding = false;
  double space = 10;

  @override
  Widget build(BuildContext context) {
    dynamic statistic = countStatus(widget.rec);

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 50,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(56, 142, 60, 1),
                    Color.fromRGBO(76, 175, 80, 1),
                    Color.fromRGBO(139, 195, 74, 1),
                  ])),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30),
                  borderRadius: BorderRadius.all(Radius.circular(30)),

                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                  color: Colors.grey.shade200.withOpacity(0.25),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 10,
              bottom: 100,
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: EdgeInsets.only(top: 200),

                      child: Column(
                        children: [
                          //SizedBox(height: 10,),
                          Text(
                            'يرجى التوقيع ادناة',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: space,
                          ),
                          Container(
                            width: 500,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Signature(
                                width: 600,
                                height: 200,
                                controller: _controller,
                                backgroundColor: Colors.white,
                              ),
                            ),
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
                                      txt: 'submit',
                                      icon: Icons.subdirectory_arrow_left,
                                      isSelected: true,
                                      onPress: () async {
                                        try {
                                          if (_controller.isEmpty) {
                                            return await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('انذار'),
                                                  content:
                                                      Text('يرجي التوقيع بداية '),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('قبول'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          setState(() {
                                            isLoding = true;
                                          });
                                          final timestamp = DateTime.now()
                                              .toString()
                                              .replaceAll(' ', '_');
                                          final signatureBytes =
                                              await _controller.toPngBytes();
                                          final storageRef = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child('signatures')
                                              .child('mySignature' +
                                                  timestamp +
                                                  '.png');
                                          await storageRef.putData(signatureBytes!);
                                          final downloadURL =
                                              await storageRef.getDownloadURL();
                                          final firestoreInstance =
                                              FirebaseFirestore.instance;
                                          final collectionReference =
                                              firestoreInstance.collection(
                                                  widget.neww
                                                      ? "new_" + timestamp
                                                      : "renew_" + timestamp);
                                          final data = this
                                              .widget
                                              .rec
                                              .map((r) => r.toJson(downloadURL))
                                              .toList();
                                          // Create a new batch
                                          final batch = firestoreInstance.batch();
                                          // Add each document in the list to the batch
                                          for (final item in data) {
                                            // Create a new document reference with a unique ID
                                            final documentReference =
                                                collectionReference.doc();
                                            // Add the document data to the batch
                                            batch.set(documentReference, item);
                                          }
                                          // Commit the batch to Firestore
                                          await batch.commit();

/*
                                  final timestamp =
                                      DateTime.now().toString().replaceAll(' ', '_');
                                  // Convert the signature image to bytes in PNG format
                                  final signatureBytes =
                                      await _controller.toPngBytes();
                                  final storageRef = FirebaseStorage.instance
                                      .ref()
                                      .child('signatures')
                                      .child('mySignaturexxx' + timestamp + '.png');
                                  await storageRef.putData(signatureBytes!);
                                  final downloadURL =
                                      await storageRef.getDownloadURL();
                                  final firestoreInstance = FirebaseFirestore.instance;
                                  final collectionReference = firestoreInstance.collection(DateTime.now().toString().substring(0,10));
                                  dynamic data =  this.widget.rec.map((r) => r.toJson(downloadURL)).toList();
                                  for (final item in data) {
                                    await collectionReference.add(item);
                                  }*/
                                          setState(() {
                                            isLoding = false;
                                          });
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('zzz'),
                                                  content:
                                                      Text('تمت العملية بنجاح'),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        } catch (e) {
                                          print(e);
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('$e'),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        } finally {
                                          setState(() {
                                            isLoding = false;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  //  SizedBox(width: 300,),
                    SingleChildScrollView(
                      child: Row(
                        children: [
                          Container(
                            width: 550,
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: CircularChart(
                              passPercent: statistic['Pass'] - 40,
                              failPercent: statistic['Fail'] + 20,
                              absencePercent: statistic['Absence'] + 10,
                              rejectPercent: statistic['Reject'] + 10,
                            ),
                          ),
                          SizedBox(width: 100,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'رقم الدفعة            : ${widget.rec[0].batch}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'العدد الكلي            : ${widget.rec.length}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الناجحين        : ${statistic['Pass']}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الراسبين         : ${statistic['Fail']}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الغياب            : ${statistic['Absence']}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد المرفوضين      : ${statistic['Reject']}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'نوع الدفعة             : ${widget.neww ? "جديد" : "تجديد"}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: space,
                              ),
                            ],
                          ),
                          SizedBox(width: 50,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*  Container(
              width: 600,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Signature(
                  width: 600,
                  height: 200,
                  controller: _controller,
                  backgroundColor: Colors.white,
                ),
              ),
            ),*/

            /*   Positioned(
              bottom: 100,
              left: 10,
              right: 10,
              child:    Container(
              width: 600,
              height: 200,

                foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Signature(
                width: 600,
                height: 200,
                controller: _controller,
                backgroundColor: Colors.white,
              ),
            ),),*/
            /*Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                width: 120,
                height: 50,
                child: Center(
                  child: isLoding
                      ? CircularProgressIndicator()
                      : Button(
                          txt: 'submit',
                          icon: Icons.subdirectory_arrow_left,
                          isSelected: true,
                          onPress: () async {
                            try {
                              if (_controller.isEmpty) {
                                return await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('انذار'),
                                      content: Text('يرجي التوقيع بداية '),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('قبول'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              setState(() {
                                isLoding = true;
                              });
                              final timestamp = DateTime.now()
                                  .toString()
                                  .replaceAll(' ', '_');
                              final signatureBytes =
                                  await _controller.toPngBytes();
                              final storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('signatures')
                                  .child('mySignature' + timestamp + '.png');
                              await storageRef.putData(signatureBytes!);
                              final downloadURL =
                                  await storageRef.getDownloadURL();
                              final firestoreInstance =
                                  FirebaseFirestore.instance;
                              final collectionReference =
                                  firestoreInstance.collection(widget.neww
                                      ? "new_" + timestamp
                                      : "renew_" + timestamp);
                              final data = this
                                  .widget
                                  .rec
                                  .map((r) => r.toJson(downloadURL))
                                  .toList();
                              // Create a new batch
                              final batch = firestoreInstance.batch();
                              // Add each document in the list to the batch
                              for (final item in data) {
                                // Create a new document reference with a unique ID
                                final documentReference =
                                    collectionReference.doc();
                                // Add the document data to the batch
                                batch.set(documentReference, item);
                              }
                              // Commit the batch to Firestore
                              await batch.commit();

/*
                              final timestamp =
                                  DateTime.now().toString().replaceAll(' ', '_');
                              // Convert the signature image to bytes in PNG format
                              final signatureBytes =
                                  await _controller.toPngBytes();
                              final storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child('signatures')
                                  .child('mySignaturexxx' + timestamp + '.png');
                              await storageRef.putData(signatureBytes!);
                              final downloadURL =
                                  await storageRef.getDownloadURL();
                              final firestoreInstance = FirebaseFirestore.instance;
                              final collectionReference = firestoreInstance.collection(DateTime.now().toString().substring(0,10));
                              dynamic data =  this.widget.rec.map((r) => r.toJson(downloadURL)).toList();
                              for (final item in data) {
                                await collectionReference.add(item);
                              }*/
                              setState(() {
                                isLoding = false;
                              });
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('zzz'),
                                      content: Text('تمت العملية بنجاح'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } catch (e) {
                              print(e);
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('$e'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } finally {
                              setState(() {
                                isLoding = false;
                              });
                              Navigator.pop(context);
                            }
                          },
                        ),
                ),
              ),
            ),*/
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

class CircularChart extends StatelessWidget {
  final double passPercent;
  final double failPercent;
  final double absencePercent;
  final double rejectPercent;

  CircularChart({
    required this.passPercent,
    required this.failPercent,
    required this.absencePercent,
    required this.rejectPercent,
  });

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData('Pass', passPercent),
      ChartData('Fail', failPercent),
      ChartData('Absent', absencePercent),
      ChartData('Reject', rejectPercent),
    ];

    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) => '${data.y}${data.x}',
          startAngle: 270,
          endAngle: 270,
          pointColorMapper: (ChartData data, _) {
            switch (data.x) {
              case 'Pass':
                return Colors.green;
              case 'Fail':
                return Colors.red;
              case 'Absent':
                return Colors.grey;
              case 'Reject':
                return Colors.yellow;
              default:
                return Colors.black;
            }
          },
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            textStyle: TextStyle(fontSize: 25),
          ),
        )
      ],
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
