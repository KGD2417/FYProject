import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/bus_screen.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key});

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  final CollectionReference buses =
  FirebaseFirestore.instance.collection('bus_tracking');

  Stream<QuerySnapshot> getBusStream(){
    final busesStream = buses.orderBy('busNo',descending: true).snapshots();
    return busesStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus List",style: TextStyle(fontSize: 24),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getBusStream(),
        builder: (context,snapshots){
          if(snapshots.hasData){
            List busList = snapshots.data!.docs;

            return ListView.builder(
                itemCount: busList.length,
                itemBuilder: (context,index){
                  DocumentSnapshot document =busList[index];
                  String docId =document.id;

                  //get busNo from each doc
                  Map<String,dynamic> data =
                  document.data() as Map<String,dynamic>;
                  String busNo = data['busNo'].toString();
                  String src = data['sName'].toString();
                  String dest = data['dName'].toString();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Colors.black,

                        )
                      ),
                      title: Text(
                        "Bus Number: "+busNo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text("Source: "+src+"\nDestination: "+dest),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BusScreen(docId: docId,)));
                          }, icon: const Icon(Icons.arrow_circle_right_outlined))
                        ],
                      ),
                    ),
                  );


            });
          }
          else{
            return const Text("No buses..");
          }
        },
      )
    );
  }
}
