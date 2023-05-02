import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownButtonNew extends StatefulWidget {
  @override
  _DropdownButtonNewState createState() => _DropdownButtonNewState();
}

class _DropdownButtonNewState extends State<DropdownButtonNew> {
  String _selectedItem = 'Pass';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue!;
        });
      },
      items: <String>[
        'Pass',
        'Fail',
        'Absence',
        'Reject'
      ].map<DropdownMenuItem<String>>(
              (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 25),
              ),
            );
          }
      ).toList(),
    );
  }
}
