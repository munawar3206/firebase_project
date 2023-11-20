import 'package:firebase/constants/domain.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:firebase/helper/colors.dart';
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
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blue,
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
                  color: black,
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
                    color: black,
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
                    color: black,
                  ),
                  border: OutlineInputBorder(),
                  label: Text("Phone Number")),
              maxLength: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                dropdownColor: blue,
                decoration: const InputDecoration(
                    label: Text("Select Domain"),
                    labelStyle: TextStyle(color: black)),
                items: domains
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  techprovider.selectedGroup = val;
                },
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  Navigator.pop(context);
                  techprovider.updatetechname(docId);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: blue,
                    content: Text(
                      "Updated ✅",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
              style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(blue)),
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
