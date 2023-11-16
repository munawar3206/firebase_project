import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference techname =
      FirebaseFirestore.instance.collection('techname');

  void deletetechname(docID) {
    techname.doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 54, 244),
        title: Text("StudentTech"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 70, 54, 244),
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          label: Icon(Icons.add)),
      body: StreamBuilder(
        stream: techname.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot namesSnap = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 234, 0),
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              radius: 30,
                              child: Text(
                                namesSnap['domain'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              namesSnap['name'],
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Text(namesSnap['batch'],
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Text(namesSnap['phone'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'name': namesSnap['name'],
                                        'batch': namesSnap['batch'],
                                        'phone': namesSnap['phone'].toString(),
                                        'domain': namesSnap['domain'],
                                        'id': namesSnap.id
                                      });
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deletetechname(namesSnap.id);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
