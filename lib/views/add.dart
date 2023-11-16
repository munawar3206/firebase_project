import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final domains = [
    "Mern,",
    "Mean",
    "Flutter",
    ".net",
    "Python",
    "C-sharp",
    "Node",
    "React",
    "Golang"
  ];
  String? selectedGroup;
  final CollectionReference techname =
      FirebaseFirestore.instance.collection('techname');
  TextEditingController studname = TextEditingController();
  TextEditingController studbatch = TextEditingController();
  TextEditingController studphone = TextEditingController();

  void addStud() {
    final data = {
      'name': studname.text,
      'batch': studbatch.text,
      'phone': studphone.text,
      'domain': selectedGroup
    };
    techname.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 54, 244),
        title: const Text("Add Techies"),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            controller: studname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Devops Name"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: studbatch,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Batch")),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: studphone,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Phone Number")),
            maxLength: 10,
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  label: Text("Select Domain"),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 70, 54, 244))),
              items: domains
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val;
              }),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              addStud();
              Navigator.pop(context);
            },
            style: const ButtonStyle(
                minimumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 50)),
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 70, 54, 244))),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
