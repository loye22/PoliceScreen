import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar22 extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  SearchBar22({
    required this.searchController,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<SearchBar22> createState() => _SearchBar22State();
}

class _SearchBar22State extends State<SearchBar22> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        color: Colors.grey.shade200.withOpacity(0.35),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        controller: widget.searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed:(){
              widget.onClear();
            },
          ),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSubmitted: (_) {
        widget.onSearch();
        },
      ),
    );
  }
}
