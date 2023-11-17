import 'dart:html';

import 'package:firebase/constants/domain.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Update extends StatelessWidget {
  Update({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final techprovider = Provider.of<technameProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    techprovider.studname.text = args['name'];
    techprovider.studbatch.text = args['phone'];
    techprovider.studphone.text = args['batch'];
    techprovider.selectedGroup = args["domain"];
    final docId = args['id'];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 54, 244),
        title: const Text("Edit 📝"),
        centerTitle: true,
        elevation: 10,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              controller: techprovider.studname,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                label: Text(
                  "Devops Name",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: techprovider.studbatch,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.class_,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  label: Text("Batch")),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: techprovider.studphone,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  label: Text("Phone Number")),
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
                  techprovider.selectedGroup = val;
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  Navigator.pop(context);
                  techprovider.updatetechname(docId);
                }
              },
              style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 70, 54, 244))),
              child: const Text(
                "Update ☑️",
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
