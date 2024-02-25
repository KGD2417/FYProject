import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,right: 10,left: 10,bottom: 10),
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 26,
                  ),
                  labelText: "Search Your Interest",
                  labelStyle: const TextStyle(
                      color: Colors.grey
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  isDense: true
              ),
            ),
          ],
        ),
      ),
    );
  }
}
