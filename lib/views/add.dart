import 'package:firebase/constants/domain.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final techprovider = Provider.of<technameProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 54, 244),
        title: const Text("Add Devops 🖥️"),
        elevation: 10,
        centerTitle: true,
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
                label: Text("Devops Name"),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                dropdownColor: const Color.fromARGB(255, 86, 33, 243),
                decoration: const InputDecoration(
                  label: Text(
                    "Select Domain 🖱️",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                items: domains
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ))
                    .toList(),
                onChanged: (val) {
                  techprovider.selectedGroup = val;
                },
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  techprovider.addtechname();
                  techprovider.studname.clear();
                  techprovider.studbatch.clear();
                  techprovider.studphone.clear();

                  Navigator.pop(context);
                }
              },
              style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 70, 54, 244))),
              child: const Text(
                "Submit 🖱️",
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
