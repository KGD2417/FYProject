import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
            PopupMenuButton(
              color: Color(0xFFe4f1ff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Color(0xFF0f6cbd), width: 1)
              ),
              child: Text("Choose the item"),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    child: Text(
                      "English",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                PopupMenuItem(
                    child: Text(
                      "Hindi",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                PopupMenuItem(
                    child: Text(
                      "Marathi",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
