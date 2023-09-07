import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tsti_signature/models/MyDialog.dart';
import '../models/record.dart';
import '../models/staticData.dart';
import 'button.dart';

class sendginForm extends StatefulWidget {
  static const routeName = '/sendginForm';
  final List<dynamic> rec;
  final int tab;
  int counter = 1;
  bool f2 = true ;
  bool f3 = true ;
  final String batchNrVarInSendingForm ;


  sendginForm({super.key, required this.rec, required this.tab , required this.batchNrVarInSendingForm});


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

  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController rankController2 = TextEditingController();
  final TextEditingController nameController3 = TextEditingController();
  final TextEditingController rankController3 = TextEditingController();
  String s1 = '';
  String s2 = '';
  String s3 = '';

  SignatureController _controller = SignatureController(
    penStrokeWidth: 2,

    /// signature pen color
    penColor: Colors.black,

    /// signature background color when exported!
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  SignatureController _controller2 = SignatureController(
    penStrokeWidth: 2,

    /// signature pen color
    penColor: Colors.black,

    /// signature background color when exported!
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  SignatureController _controller3 = SignatureController(
    penStrokeWidth: 2,

    /// signature pen color
    penColor: Colors.black,

    /// signature background color when exported!
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  final _key = GlobalKey<FormState>();
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
                image: DecorationImage(
                  image: AssetImage('assests/a.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30),
                  borderRadius: BorderRadius.all(Radius.circular(30)),

                //  border: Border.all(color: Colors.white.withOpacity(0.5)),
                //  color: Colors.grey.shade200.withOpacity(0.25),
                ),
              ),
            ),
            Positioned(
              right: 200,
              left: 10,
              top: 10,
              bottom: 100,
              child: SingleChildScrollView(
                child: Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //signither
                      Container(
                        child: Column(
                          children: [
                            //SizedBox(height: 10,),
                            Text(
                              'يرجى التوقيع ادناة',
                              style: GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: space,
                            ),
                            Animate(
                              effects: [SlideEffect()],
                              child: Container(
                                width: 500,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.black , width: 5)
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
                            ),
                            SizedBox(height: 15,),
                            widget.counter == 2 || widget.counter == 3 ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:300,
                                  child: TextField(
                                    controller: nameController2,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0 )),
                                        borderSide: BorderSide(color: Colors.green , width: 3) ,

                                      ),

                                      hintText: 'الاسم',
                                      hintStyle: TextStyle(
                                        //textAlign: TextAlign.right,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 82, 46, 1),
                                          width: 2.0,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width:300,

                                  child: TextField(
                                    controller: rankController2,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0 )),
                                        borderSide: BorderSide(color: Colors.green , width: 3) ,

                                      ),

                                      hintText: 'الرتبة',
                                      hintStyle: TextStyle(
                                        //textAlign: TextAlign.right,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 82, 46, 1),
                                          width: 2.0,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Animate(
                                  effects: [SlideEffect()],
                                  child: Container(
                                    width: 500,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black , width: 5)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Signature(
                                        width: 600,
                                        height: 200,
                                        controller: _controller2,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,)

                              ],
                            ) : SizedBox.shrink(),
                            widget.counter > 2 ?  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:300,
                                  child: TextField(
                                    controller: nameController3,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0 )),
                                        borderSide: BorderSide(color: Colors.green , width: 3) ,

                                      ),

                                      hintText: 'الاسم',
                                      hintStyle: TextStyle(
                                        //textAlign: TextAlign.right,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 82, 46, 1),
                                          width: 2.0,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width:300,

                                  child: TextField(
                                    controller: rankController3,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0 )),
                                        borderSide: BorderSide(color: Colors.green , width: 3) ,

                                      ),

                                      hintText: 'الرتبة',
                                      hintStyle: TextStyle(
                                        //textAlign: TextAlign.right,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 82, 46, 1),
                                          width: 2.0,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Animate(
                                  effects: [SlideEffect()],
                                  child: Container(
                                    width: 500,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black , width: 5)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Signature(
                                        width: 600,
                                        height: 200,
                                        controller: _controller3,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,)

                              ],
                            ) : SizedBox.shrink(),

                            widget.counter == 3 ? SizedBox.shrink() :  InkWell(
                              child: Row(children: [
                               Text( 'اضافة توقيع' , style:  GoogleFonts.cairo(fontSize: 20 , fontWeight: FontWeight.bold),) ,
                                SizedBox(width: 10,),
                                Icon(Icons.add , size: 25,color: Color.fromRGBO(0, 82, 46, 1),)
                              ],),
                              onTap: (){
                                if(widget.counter == 2){
                                  if (_controller2.isEmpty || nameController2.text == '' || rankController2.text == '')
                                    {
                                      MyDialog.showAlert(context, 'يرجى ملئ بيانات الضابط الثاني مع التوقيع');
                                      return ;
                                    }


                                }
                                if (widget.counter == 3) return;
                                widget.counter++;
                                setState(() {});
                              },
                            ),
                            SizedBox(height: 10,),
                            isLoding
                                ? CircularProgressIndicator() :
                             InkWell(
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:Color.fromRGBO(0, 82, 46, 1) ,
                                ),

                                child: Center(child: Text('ارسال' ,style:  GoogleFonts.cairo(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white),)),
                              ),
                              onTap: () async {
                                try {
                                  // in case the user didnot sigh
                                  if (_controller.isEmpty) {
                                    return await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('انذار'),
                                          content: Text(
                                              'يرجي التوقيع بداية '),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('قبول'),
                                              onPressed: () {
                                                Navigator.of(
                                                    context)
                                                    .pop();
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

                                  //Handling the second person data in case he is exist
                                  if(widget.counter >= 2 && widget.f2 ){
                                    // in case something is messing
                                    if(nameController2.text =='' || rankController2.text == '' || _controller2.isEmpty){
                                      MyDialog.showAlert(context, 'يرجى ملئ بيانات الضابط الثاني مع التوقيع');
                                      return;}
                                    else {
                                      // upload the signether image and get the link
                                      final timestamp = DateTime.now()
                                          .toString()
                                          .replaceAll(' ', '_');
                                      final signatureBytes =
                                      await _controller2
                                          .toPngBytes();
                                      final storageRef = FirebaseStorage
                                          .instance
                                          .ref()
                                          .child('signatures')
                                          .child('mySignature' +
                                            timestamp +
                                          '.png');
                                      await storageRef
                                          .putData(signatureBytes!);
                                      s2 =
                                      await storageRef.getDownloadURL();
                                      widget.f2 = false;




                                    }

                                  }
                                  //Handling the 3rd person data in case he is exist
                                  if(widget.counter == 3 && widget.f3){
                                    // in case something is messing
                                    if(nameController3.text =='' || rankController3.text == '' || _controller3.isEmpty){
                                      MyDialog.showAlert(context, 'يرجى ملئ بيانات الضابط الثالث مع التوقيع');
                                      return;}
                                    else {
                                      // upload the signether image and get the link
                                      final timestamp = DateTime.now()
                                          .toString()
                                          .replaceAll(' ', '_');
                                      final signatureBytes =
                                      await _controller3
                                          .toPngBytes();
                                      final storageRef = FirebaseStorage
                                          .instance
                                          .ref()
                                          .child('signatures')
                                          .child('mySignature' +
                                          timestamp +
                                          '.png');
                                      await storageRef
                                          .putData(signatureBytes!);
                                      s3 =
                                      await storageRef
                                          .getDownloadURL();
                                      widget.f3 = false ;





                                    }

                                  }



                                  // create time stamp and uplooding the signither image

                                  final timestamp = DateTime.now()
                                      .toString()
                                      .replaceAll(' ', '_');
                                  final signatureBytes =
                                      await _controller
                                      .toPngBytes();
                                  final storageRef = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('signatures')
                                      .child('mySignature' +
                                      timestamp +
                                      '.png');
                                  await storageRef
                                      .putData(signatureBytes!);
                                  final downloadURL =
                                      await storageRef
                                      .getDownloadURL();
                                   s1 = downloadURL ;

                                  // to handle the reshcedual grads
                                  if (widget.tab == 2) {
                                    CollectionReference
                                    collectionRef =
                                    FirebaseFirestore.instance
                                        .collection(
                                      // this is list of the patch nr where we fetching
                                        'rescheduleResults').doc(widget.batchNrVarInSendingForm).collection('gards');

                                    // Create a new batch
                                    WriteBatch batchRE =
                                    FirebaseFirestore.instance
                                        .batch();

                                    // Iterate over each record in the list
                                    /*for (var record in widget.rec) {
                                      // Create a new document reference with a unique ID
                                      DocumentReference
                                      documentRef =
                                      collectionRef.doc();

                                      // Add the record data to the batch
                                      batchRE.set(documentRef, {
                                        'company':
                                        record.company ?? '',
                                        'course':
                                        record.course ?? '',
                                        'coursetype':
                                        record.courseType ?? '',
                                        'employeeid':
                                        record.empid ?? '',
                                        'height':
                                        record.height ?? '',
                                        'name': record.nameEn ?? '',
                                        'nationality':
                                        record.nationality ??
                                            '',
                                        'result':
                                        record.status ?? '',
                                        'signature': downloadURL ??
                                            '404notfound',
                                        'weight':
                                        record.weight ?? '',
                                        'note': record.note ?? '' ,
                                        'className' : record.className
                                      });
                                    }*/
                                    for (var record in widget.rec) {
                                      // Create a new document reference with a unique ID
                                      DocumentReference documentRef =
                                      collectionRef.doc();

                                      // Add the record data to the batch
                                      batchRE.set(documentRef, {
                                        'company':
                                        record.company ?? '',
                                        'course': record.course ?? '',
                                        'coursetype':
                                        record.courseType ?? '',
                                        'employeeid':
                                        record.empid ?? '',
                                        'height': record.height ?? '',
                                        'name': record.nameEn ?? '',
                                        'nationality':
                                        record.nationality ?? '',
                                        'result': record.status ?? '',
                                        'signature': downloadURL ??
                                            '404notfound',
                                        'weight': record.weight ?? '',
                                        'note':
                                        record.note ?? 'defalst' ,
                                        'signature2' : s2 ,
                                        'signature3' : s3 ,
                                        'name1' : 'sayaah',
                                        'rank1' : 'Rank1111' ,
                                        'name2' : nameController2.text ,
                                        'rank2' : rankController2.text ,
                                        'name3' : nameController3.text ,
                                        'rank3' : rankController3.text ,
                                        'className' :record.className
                                      });
                                    //  print(record.className + "<<<<<<<<<<<<<<<<<<<<<<<<<<");
                                  //    print(MyData.getDataByKey(record.className));



                                    }


                                    // Commit the batch to Firestore
                                    await batchRE.commit();
                                    /////
                                    String? url =  await  sendDataToAPI(widget.rec);
                                    if(url == null)
                                      throw Exception('Something went wrong with API ingtration plz renew you plan!');
                                    await sendEmail(['louai.ibrahim@tsti.ae'] , url);
                                    try{
                                      //String? x =  await  createPDF(widget.rec,s1);
                                      print(url+"<<<<<<<<<<<");
                                      await sendEmail(['louai.ibrahim@tsti.ae'] , url);
                                      print('url2 $url');
                                     // print(x);
                                    }
                                    catch(e){

                                      print('error  $e');
                                    }



                                    // delete the reschdeul collection after this

                                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                                    CollectionReference collection = firestore.collection('reschedule');

                                    QuerySnapshot querySnapshot = await collection.get();

                                    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
                                      await docSnapshot.reference.delete();
                                    }


                                    return;
                                  }
                                  // this line to check if this collection with batch nr is exesit or not
                                  // true ==> the doc already uploded
                                  // false ==>
                                  final condition = await checkCollectionExists(widget.batchNrVarInSendingForm, widget.tab == 0
                                      ? "new"
                                      : "renew");
                                  print(widget.rec.length);
                                  if(condition){
                                    MyDialog.showAlert(context,'هذه الدفعة موجودة بالفعل في النظام , يرجى التاكد من التبويب جديد او تجديد و المجاولة من جديد') ;
                                    return;
                                  }
                                  // handle the new and renew gards
                                  CollectionReference
                                  collectionRef =
                                  FirebaseFirestore.instance.collection('result').doc(widget.batchNrVarInSendingForm)
                                      .collection(
                                      widget.tab == 0
                                          ? "new"
                                          : "renew");

                                  // Create a new batch
                                  WriteBatch batch =
                                  FirebaseFirestore.instance
                                      .batch();

                                  // Iterate over each record in the list
                                  for (var record in widget.rec) {
                                    // Create a new document reference with a unique ID
                                    DocumentReference documentRef =
                                    collectionRef.doc();

                                    // Add the record data to the batch
                                    batch.set(documentRef, {
                                      'company':
                                      record.company ?? '',
                                      'course': record.course ?? '',
                                      'coursetype':
                                      record.courseType ?? '',
                                      'employeeid':
                                      record.empid ?? '',
                                      'height': record.height ?? '',
                                      'name': record.nameEn ?? '',
                                      'nationality':
                                      record.nationality ?? '',
                                      'result': record.status ?? '',
                                      'signature': downloadURL ??
                                          '404notfound',
                                      'weight': record.weight ?? '',
                                      'note':
                                      record.note ?? 'defalst' ,
                                      'signature2' : s2 ,
                                      'signature3' : s3 ,
                                      'name1' : 'sayaah',
                                      'rank1' : 'Rank1111' ,
                                      'name2' : nameController2.text ,
                                      'rank2' : rankController2.text ,
                                      'name3' : nameController3.text ,
                                      'rank3' : rankController3.text ,
                                      'className' :record.className
                                    });
                                  }

                                  // Commit the batch to Firestore
                                  await batch.commit();
                                  String? url2 =  await  sendDataToAPI(widget.rec);
                                  if(url2 == null)
                                    throw Exception('Something went wrong with API ingtration plz renew you plan!');
                                  await sendEmail(['louai.ibrahim@tsti.ae'] , url2);

                                  print('xxxx');
                                  try{
                                    //String? x =  await  createPDF(widget.rec,s1);
                                   // print(x.toString() + '<<<<<<<<');
                                    await sendEmail(['louai.ibrahim@tsti.ae'] , url2);
                                    print('url2 $url2');
                                  }
                                  catch(e){

                                    print('error  $e');
                                  }




                                  print(this.s1);
                                  setState(() {
                                    isLoding = false;
                                  });
                                  await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('اشعار'),
                                      content: Text(
                                          'تمت العملية بنجاح'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(
                                                context)
                                                .pop();
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
                                            Navigator.of(
                                                context)
                                                .pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                                } finally {
                                  setState(() {
                                    isLoding = false;
                                  });
                                 // Navigator.pop(context);
                                }
                              },
                            ),
                            SizedBox(height: 10,),

                            SizedBox(height: 10),
                        


                            SizedBox(
                              height: 30,
                            ),

                          ],
                        ),
                      ),
                        SizedBox(width: 100,),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            padding: EdgeInsets.only(top: 20),
                            child: CircularChart(
                              passPercent: statistic['Pass'],
                              failPercent: statistic['Fail'],
                              absencePercent: statistic['Absence'],
                              rejectPercent: statistic['Reject'],
                            ),
                          ),
                          getColorExplanation(),
                          SizedBox(height: 20),
                          //   SizedBox(width: 100,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.rec[0].batch != ''
                                  ? Text(
                                      'رقم الدفعة            : ${widget.rec[0].batch}',
                                      style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'العدد الكلي            : ${widget.rec.length}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الناجحين        : ${statistic['Pass']}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الراسبين         : ${statistic['Fail']}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد الغياب            : ${statistic['Absence']}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'عدد المرفوضين      : ${statistic['Reject']}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              Text(
                                'نوع الدفعة             : ${widget.tab == 0 ? "جديد" : "تجديد"}',
                                style:  GoogleFonts.cairo(fontSize: 24 , fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: space,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                      /*IconButton(onPressed: () async {

                        print('start');
                         await  sendDataToAPI(widget.rec);
                         print('end');
                      }, icon: Icon(Icons.add  , size: 50,))*/
                    ],
                  ),
                ),
              ),
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
/*
  Future<bool> checkCollectionExists(String batchNumber, String collectionName) async {
    /*
    In this updated function, we retrieve the specific batch document based on the provided batch number.
    Then, we check if the document exists. If it doesn't exist, we return false indicating that the batch doesn't exist.
    If the batch document exists, we check if the document data contains the specified collection name as a key.
    If the collection name doesn't exist within the batch, we also return false.
    If the batch document exists and the collection name exists within the batch,
    we return true indicating that the collection exists within the specified batch.
    */

    final firestore = FirebaseFirestore.instance;
    final resultCollection = firestore.collection('result');
    final batchDoc = await resultCollection.doc(batchNumber.toString()).get();


    if (!batchDoc.exists) {
      // Batch document doesn't exist
      print('batch condition');
      return false;
    }
    final batchData = batchDoc.data();
    if ( !batchData!.containsKey(collectionName)) {
      // Collection doesn't exist within the batch
      print('2nd contions');
      return false;
    }
    // if this function returned true send feedback that this batch already uploaded
    return true;
  }
*/



// new new new

  Future<bool> checkCollectionExists(String batchNumber, String collectionName) async {
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('result')
        .doc(batchNumber)
        .collection(collectionName);

    final QuerySnapshot querySnapshot = await collectionReference.get();
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isNotEmpty;


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

      //Set<int>.from(titles).toList();
      print(Set<String>.from(titles).toList());
      return titles;
    }

    return [];
  }


  Future<String?> sendDataToAPI(List<dynamic> recordList) async {
    // API endpoint URL
    final url = Uri.parse('https://rest.apitemplate.io/v2/create-pdf?template_id=22677b23a84850c2');//   cc177b238ce1be88');

    // Request headers
    final headers = {
      'X-API-KEY': 'd716MTI4ODg6OTk0NDpkNWRGOFdzTXNVOHFrWGp', // 'e524MTM0NDM6MTA1MDE6WElVbXdlNmdSeGpoWFhFdw=', //'d716MTI4ODg6OTk0NDpkNWRGOFdzTXNVOHFrWGp',
      'Content-Type': 'application/json',
    };

    // Prepare the request body
    final requestBody = {
      'course': 'New Basic Security Guard',
      'timing': 'Morning,Batch 44',
      'signature': s1,
      'signature2': s2,
      'signature3': s3,

      'date' :DateFormat('ddMMyyyy').format( DateTime.now()).toString() ,
      'name1' : 'sayaah' ,
      'rank1' : 'whatrere' ,
      'name2' : nameController2.text ,
      'rank2' : rankController2.text ,
      'name3' : nameController3.text ,
      'rank3' : rankController3.text ,
      'students': recordList.map((record) => {
        'name': record.nameEn,
        'nationality': record.nationality,
        'height': record.height,
        'weight': record.weight,
        'result': record.status,
        'company': record.company,
      }).toList(),
    };

    // Convert the request body to JSON
    final requestBodyJson = jsonEncode(requestBody);

    try {
      // Send the POST request
      final response = await http.post(url, headers: headers, body: requestBodyJson);

      // Handle the API response
      if (response.statusCode == 200) {
        // Request successful
        final responseData = jsonDecode(response.body);
        print(responseData['download_url']);
        return responseData['download_url'];
        // Handle the response data as needed
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        return'';
      }
    } catch (error) {
      // Error occurred
      print('Error sending request: $error');
    }
  }

  Future<void> sendEmail(List<String> emails, String fileUrl) async {
    final apiUrl = 'https://www.tsti.ae/version-test/api/1.1/wf/send-email';

    // JSON payload
    final payload = jsonEncode({
      'emails': emails,
      'subject': 'TEST EMAIL',
      'body': 'Dear Sie/Madam please find the result link attached in the this email\n ${fileUrl}',
      'file': fileUrl,
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 200) {
        print('Email sent successfully!');
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending email: $error');
    }



  }



 /* Future<void> createPDF() async {
    final url = 'https://rest.apitemplate.io/v2/create-pdf?template_id=cc177b238ce1be88';
    final apiKey = 'd716MTI4ODg6OTk0NDpkNWRGOFdzTXNVOHFrWGp';

    final headers = {
      'X-API-KEY': apiKey,
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "course": "New Basic Security Guard",
      "timing": "Morning,Batch 44",
      "signature": "signature1",
      "name1": "name1",
      "rank1": "rank1",
      "students": [
        {
          "name": "SAMEER NEYYATHOOR ALIBAPPU NEYYATHOOR",
          "nationality": "Indian",
          "height": "174",
          "weight": "74",
          "result": "Reject",
          "company": "ORION SECURITY SERVICES L.L.C"
        },
        {
          "name": "SAMEER NEYYATHOOR ALIBAPPU NEYYATHOOR",
          "nationality": "Indian",
          "height": "174",
          "weight": "74",
          "result": "Reject",
          "company": "ORION SECURITY SERVICES L.L.C"
        }
      ]
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final downloadUrl = responseData['download_url'];
        final transactionRef = responseData['transaction_ref'];
        final totalPages = responseData['total_pages'];
        final status = responseData['status'];
        final templateId = responseData['template_id'];

        print('Download URL: $downloadUrl');
        print('Transaction Reference: $transactionRef');
        print('Total Pages: $totalPages');
        print('Status: $status');
        print('Template ID: $templateId');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
*/

  Future<String> createPDF(List<dynamic> records ,String s1) async {
    final url = 'https://rest.apitemplate.io/v2/create-pdf?template_id=cc177b238ce1be88';
    final apiKey = 'd716MTI4ODg6OTk0NDpkNWRGOFdzTXNVOHFrWGp';

    final headers = {
      'X-API-KEY': apiKey,
      'Content-Type': 'application/json',
    };

    final students = records.map((record) {
      return {
        "name": record.nameEn,
        "nationality": record.nationality,
        "height": record.height,
        "weight": record.weight,
        "result": record.status,
        "company": record.company,
      };
    }).toList();

    /*
    *
    *  'name1' : 'sayaah' ,
      'rank1' : 'whatrere' ,
      'name2' : nameController2.text ,
      'rank2' : rankController2.text ,
      'name3' : nameController3.text ,
      'rank3' : rankController3.text ,
    * */
    final body = jsonEncode({
      "course": 'records.first.course', // Assuming the course is the same for all records
      "timing": 'records.first.batch', // Assuming the batch is the same for all records
      "signature": s1,
      "name1":'Mr Sayaah' ?? 'notfound', // Assuming the name1 is the same for all records
      'rank1' : 'R1' ,
      'name2' : nameController2.text ,
      'rank2' : rankController2.text ,
      'name3' : nameController3.text ,
      'rank3' : rankController3.text ,
      "students": students,

    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final downloadUrl = responseData['download_url'] as String;

        return downloadUrl;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return '';
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
      //      isVisible: true,
        //    labelPosition: ChartDataLabelPosition.inside,
          //  textStyle: TextStyle(fontSize: 20),
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

Widget getColorExplanation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.green, // Color square 1: Green
              ),
              SizedBox(width: 8),
              Text('Pass'), // Explanation 1: Pass
            ],
          ),
          SizedBox(width: 20),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.red, // Color square 2: Red
              ),
              SizedBox(width: 8),
              Text('Fail'), // Explanation 2: Fail
            ],
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.grey, // Color square 3: Grey
              ),
              SizedBox(width: 8),
              Text('Absent'), // Explanation 3: Absent
            ],
          ),
          SizedBox(width: 8),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.yellow, // Color square 4: Yellow
              ),
              SizedBox(width: 8),
              Text('Reject'), // Explanation 4: Reject
            ],
          ),
        ],
      ),
    ],
  );



}
