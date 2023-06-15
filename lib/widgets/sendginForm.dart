import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                                      await storageRef
                                          .getDownloadURL();
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
                        

                            /*SizedBox(
                              height: space,
                            ),
                            widget.counter == 2 || widget.counter == 3
                                ? Animate(
                                    effects: [SlideEffect()],
                                    child: Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        children: [
                                          Form(
                                            key: _key,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    //        height: 150,
                                                    ),
                                                Container(
                                                  height: 40,
                                                  width: 300,
                                                  child: TextFormField(
                                                      key: ValueKey('username'),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.white),
                                                        labelText: 'الاسم',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors
                                                            .grey.shade200
                                                            .withOpacity(0.45),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.7),
                                                          ),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        16.0),
                                                      ),
                                                      onSaved: (val) {
                                                        if (val != null) {
                                                          val = val
                                                              ?.replaceAll(
                                                                  " ", "")
                                                              .toString();
                                                        }
                                                      },
                                                      validator: (val) {
                                                        if (val == null) {
                                                          return;
                                                        }
                                                        //   val = val?.replaceAll(" ", "").toString();
                                                      }),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 40,
                                                  width: 300,
                                                  child: TextFormField(
                                                    key: ValueKey('password'),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    obscureText: true,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                          Icons.password,
                                                          color: Colors.white),
                                                      labelText: 'Password',
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors
                                                          .grey.shade200
                                                          .withOpacity(0.45),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 16.0),
                                                    ),
                                                    onSaved: (val) {
                                                      if (val != null) {
                                                        //val = val?.replaceAll(" ", "").toString();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Signature(
                                              width: 600,
                                              height: 200,
                                              controller: _controller2,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: space,
                            ),
                            widget.counter > 2
                                ? Animate(
                                    effects: [SlideEffect()],
                                    child: Container(
                                      width: 500,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Signature(
                                              width: 600,
                                              height: 200,
                                              controller: _controller3,
                                              backgroundColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),*/
                            SizedBox(
                              height: 30,
                            ),
                            /*
                            Container(
                              child: Row(
                                children: [
                                  isLoding
                                      ? CircularProgressIndicator()
                                      : Button(
                                          txt: 'ارسال',
                                          icon: Icons.subdirectory_arrow_left,
                                          isSelected: true,
                                          onPress: () async {
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

                                              // to handle the reshcedual grads
                                              if (widget.tab == 2) {
                                                CollectionReference
                                                    collectionRef =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            // this is list of the patch nr where we fetching
                                                            '46')
                                                        .doc()
                                                        .collection(
                                                            'reSchedual');

                                                // Create a new batch
                                                WriteBatch batchRE =
                                                    FirebaseFirestore.instance
                                                        .batch();

                                                // Iterate over each record in the list
                                                for (var record in widget.rec) {
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
                                                    'note': record.note ?? ''
                                                  });
                                                }

                                                // Commit the batch to Firestore
                                                await batchRE.commit();
                                                return;
                                              }

                                              CollectionReference
                                                  collectionRef =
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          // this is list of the patch nr where we fetching
                                                          '46')
                                                      .doc()
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
                                                      record.note ?? 'defalst'
                                                });
                                              }

                                              // Commit the batch to Firestore
                                              await batch.commit();


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
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Button(
                                    txt: 'اضافة شرطي اخر',
                                    icon: Icons.subdirectory_arrow_left,
                                    isSelected: true,
                                    onPress: () {
                                      if (widget.counter == 3) return;
                                      widget.counter++;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),*/
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
