import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudReportScreen extends StatefulWidget {
  const StudReportScreen({Key? key});

  @override
  State<StudReportScreen> createState() => _StudReportScreenState();
}

class _StudReportScreenState extends State<StudReportScreen> {

  final auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> term1MarksStream = FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.phoneNumber.toString())
        .collection('result')
        .doc('Term1')
        .snapshots();
    Stream<DocumentSnapshot> classdata = FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.phoneNumber.toString())
        .snapshots();
    Stream<DocumentSnapshot> term2MarksStream = FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.phoneNumber.toString())
        .collection('result')
        .doc('Term2')
        .snapshots();
    Stream<DocumentSnapshot> other = FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.phoneNumber.toString())
        .collection('result')
        .doc('Other')
        .snapshots();

    num t1 = 0;
    num t2 = 0;
    var per = "";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5PkW4fJsvhTn3s9hnv2nSU7a5jkGYsUH9Zl7YOHZKeA&s'), // Fetch image from network
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2, // Adjust the flex factor as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vidyaniketan Global Institute's",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Vidya Niketan ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "International Academy",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Sakori, Tal-Junnar, Dist-Pune 412410",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "UDISE CODE: 27250705203",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Mob.No. - 9809719398",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Email- vidyaniketaniasakori@gmail.com",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "REPORT CARD",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Academic Year",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "2023-24",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // Text(
                        //   "STUDENT PROFILE",
                        //   style: TextStyle(
                        //       fontSize: 30, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(height: 10),
                        // Text(
                        //   '',
                        //   style: TextStyle(
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Text(
                        //   'Class: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Roll: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Date of birth: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Address: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Telephone: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Mother\'s name: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // Text(
                        //   'Father\'s name: ',
                        //   style: TextStyle(fontSize: 18),
                        // ),
                        // SizedBox(height: 10),
                        const Text(
                          "Part 1: Scholastic Area: ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FixedColumnWidth(58.0),
                            1: FixedColumnWidth(350.0),
                          },
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SCHOLASTIC AREA',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('TERM 1 (100 MARKS)')),
                                ),
                              ],
                            )
                          ],
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SUBJECTS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'ENGLISH',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'HINDI',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'MARATHI',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SCIENCE',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'MATHS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SOCIAL SCIENCE',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'OBTAINED MARKS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var e1 = term1MarksData?['English'] ?? 0; // Access 'English' field safely
                                      // t1 += num.tryParse(e1) ?? 0;
                                      return Center(
                                        child: Text(
                                          e1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var h1 = term1MarksData?['Hindi'] ?? 0; // Access 'Hindi' field safely
                                      // t1 += num.tryParse(h1) ?? 0;
                                      return Center(
                                        child: Text(
                                          h1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var m1 = term1MarksData?['Marathi'] ?? 0; // Access 'Marathi' field safely
                                      // t1 += num.tryParse(m1) ?? 0;
                                      return Center(
                                        child: Text(
                                          m1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var s1 = term1MarksData?['Science'] ?? 0; // Access 'Science' field safely
                                      // t1 += num.tryParse(s1) ?? 0;
                                      return Center(
                                        child: Text(
                                          s1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var ma1 = term1MarksData?['Maths'] ?? 0; // Access 'Maths' field safely
                                      // t1 += num.tryParse(ma1) ?? 0;
                                      return Center(
                                        child: Text(
                                          ma1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var ss1 = term1MarksData?['SST'] ?? 0; // Access 'SST' field safely
                                      // t1 += num.tryParse(ss1) ?? 0;
                                      return Center(
                                        child: Text(
                                          ss1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'OUT OF MARKS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FixedColumnWidth(58.0),
                            1: FixedColumnWidth(350.0),
                          },
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SCHOLASTIC AREA',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text('TERM 2 (100 MARKS)')),
                                ),
                              ],
                            )
                          ],
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SUBJECTS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'ENGLISH',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'HINDI',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'MARATHI',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SCIENCE',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'MATHS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'SOCIAL SCIENCE',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'OBTAINED MARKS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData =
                                      snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var e2 = term2MarksData?['English'] ?? 0; // Access 'English' field safely
                                      t2 += e2 ?? 0;
                                      return Center(
                                        child: Text(
                                          e2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var h2 = term2MarksData?['Hindi'] ?? 0; // Access 'Hindi' field safely
                                      // t2 += int.tryParse(h2) ?? 0;
                                      return Center(
                                        child: Text(
                                          h2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var m2 = term2MarksData?['Marathi'] ?? 0; // Access 'Marathi' field safely
                                      // t2 += int.tryParse(m2) ?? 0;
                                      return Center(
                                        child: Text(
                                          m2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var s2 = term2MarksData?['Science'] ?? 0; // Access 'Science' field safely
                                      // t2 += int.tryParse(s2) ?? 0;
                                      return Center(
                                        child: Text(
                                          s2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var ma2 = term2MarksData?['Maths'] ?? 0; // Access 'Maths' field safely
                                      // t2 += int.tryParse(ma2) ?? 0;
                                      return Center(
                                        child: Text(
                                          ma2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var ss2 = term2MarksData?['SST'] ?? 0; // Access 'SST' field safely
                                      // t2 += int.tryParse(ss2) ?? 0;
                                      return Center(
                                        child: Text(
                                          ss2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'OUT OF MARKS',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                                TableCell(
                                  child: Center(child: Text('100')),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FixedColumnWidth(150.0),
                          },
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'Term I & II',
                                        style: TextStyle(
                                          fontSize: 19.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'Grade',
                                        style: TextStyle(
                                          fontSize: 19.0,
                                        ),
                                      )),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'Grade',
                                        style: TextStyle(
                                          fontSize: 19.0,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'General Knowledge',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var g1 = term1MarksData?['GK'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          g1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var g2 = term2MarksData?['GK'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          g2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Text(
                                    'Computer',
                                    style: TextStyle(fontSize: 19.0),
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var c1 = term1MarksData?['Com'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          c1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var c2 = term2MarksData?['Com'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          c2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Text(
                                    'Art Education',
                                    style: TextStyle(fontSize: 19.0),
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term1MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term1MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var a1 = term1MarksData?['Art'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          a1.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: term2MarksStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var term2MarksData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var a2 = term2MarksData?['Art'] ?? ''; // Access 'SST' field safely
                                      return Center(
                                        child: Text(
                                          a2.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Table(
                          border: TableBorder.all(),
                          children:  [
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'Overall Marks',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: Center(child: Text('Term1:$t1 Term2:$t2', style: const TextStyle(fontSize: 19.0))),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'Percentage',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: Builder(
                                    builder: (BuildContext context) {
                                      per = (((t1 + t2) / 2)).toStringAsFixed(2);
                                      return Center(
                                        child: Text(per, style: const TextStyle(fontSize: 19.0)),
                                      );
                                    },
                                  ),
                                ),

                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'Grade',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: Builder(
                                    builder: (BuildContext context) {
                                      String getGrade(double percentage) {
                                        if (percentage >= 91) {
                                          return 'A1';
                                        } else if (percentage >= 81) {
                                          return 'A2';
                                        } else if (percentage >= 71) {
                                          return 'B1';
                                        } else if (percentage >= 61) {
                                          return 'B2';
                                        } else if (percentage >= 51) {
                                          return 'C1';
                                        } else if (percentage >= 41) {
                                          return 'C2';
                                        } else if (percentage >= 33) {
                                          return 'D';
                                        } else {
                                          return 'E';
                                        }
                                      }
                                      return Center(
                                        child: Text(getGrade(double.parse(per)), style: const TextStyle(fontSize: 19.0)),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(
                                        'Attendance',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: Center(child: Text('', style: TextStyle(fontSize: 19.0))),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'Height',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: other,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var other = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var h = other?['Height'] ?? '';
                                      return Center(
                                        child: Text(
                                          h.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                      child: Text(
                                        'Weight',
                                        style: TextStyle(fontSize: 19.0),
                                      )),
                                ),
                                TableCell(
                                  child: StreamBuilder<DocumentSnapshot>(
                                    stream: other,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      }
                                      var other = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                      var w = other?['Weight'] ?? '';
                                      return Center(
                                        child: Text(
                                          w.toString(),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                    child: Text(
                                      'Date',
                                      style: TextStyle(fontSize: 19.0),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      DateFormat('yyyy-MM-dd').format(DateTime.now()), // Format current date as desired
                                      style: const TextStyle(fontSize: 19.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Column(
                                    children: [
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: other,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator(),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Center(child: Text('Error: ${snapshot.error}'),
                                            );
                                          }
                                          var otherData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                          var r = otherData?['Remark'] ?? '';
                                          var date = otherData?['Newdate'] ?? '';
                                          return Column(
                                            children: [
                                              Text(
                                                'Teacher\'s Remark: $r',
                                                style: const TextStyle(fontSize: 19.0),
                                              ),
                                              StreamBuilder<DocumentSnapshot>(
                                                stream: classdata,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  if (snapshot.hasError) {
                                                    return Center(child: Text('Error: ${snapshot.error}'),
                                                    );
                                                  }
                                                  var classData = snapshot.data?.data() as Map<String, dynamic>?; // Extract data from DocumentSnapshot
                                                  var c = (int.tryParse(classData?['class'] ?? '0') ?? 0) + 1;
                                                  return Text(
                                                    'Congratulations !!! Promoted to Class $c',
                                                    style: const TextStyle(fontSize: 19.0),
                                                  );
                                                },
                                              ),
                                              Text(
                                                'New session begins on $date',
                                                style: const TextStyle(fontSize: 19.0),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Table(
                          border: TableBorder.all(),
                          children: const [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Text(
                                    'Point Grading Scale: \n A1(91%-100%) A2(81%-90%) B1(71%-80%) B2(61%-70%) C1(51%-60%) C2(41%-50%) D(33%-40%) E(32%-Below) ',
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}