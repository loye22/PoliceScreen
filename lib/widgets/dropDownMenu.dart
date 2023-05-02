import 'package:flutter/material.dart';

class GlassDropDownMenu extends StatefulWidget {
  final List<String> items;
  final String value;
  final Function(String) onChanged;
  final Function(int)? onSelectedItem;

  GlassDropDownMenu({
    required this.items,
    required this.value,
    required this.onChanged,
    this.onSelectedItem,
  });

  @override
  _GlassDropDownMenuState createState() => _GlassDropDownMenuState();
}

class _GlassDropDownMenuState extends State<GlassDropDownMenu> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.items.indexOf(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      isExpanded: true,
      value: _selectedIndex,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 32,
      underline: Container(),
      style: TextStyle(fontSize: 24),
      onChanged: (int? newIndex) {
        setState(() {
          _selectedIndex = newIndex!;
        });
        widget.onChanged(widget.items[_selectedIndex]);
        if (widget.onSelectedItem != null) {
          widget.onSelectedItem!(_selectedIndex);
        }
      },
      items: widget.items.asMap().entries.map<DropdownMenuItem<int>>((entry) {
        int index = entry.key;
        String value = entry.value;

        return DropdownMenuItem<int>(
          value: index,
          child: Text(
            textAlign: TextAlign.center,
            "        $value",
            style: TextStyle(
              color: _selectedIndex == index ? Colors.black : Colors.grey[700],
            ),
          ),
        );
      }).toList(),
    );
  }
}
