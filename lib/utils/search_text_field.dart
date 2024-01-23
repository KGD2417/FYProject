import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
