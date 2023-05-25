import 'package:flutter/material.dart';

class MyAlertDialog {
  static Future<void> showConfirmationDialog(
      BuildContext context, String message, Function yesFunction, Function noFunction) async {
    return  showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تاكيد'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                yesFunction();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('لا'),
              onPressed: () {
                noFunction();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
