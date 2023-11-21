import 'package:firebase/constants/domain.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:firebase/helper/colors.dart';
import 'package:flutter/cupertino.dart';
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
        backgroundColor: blue,
        title: const Text("Add Devops"),
        // elevation: 10,
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            CupertinoTextField(
              placeholderStyle: TextStyle(color: blue),
              prefix: Icon(Icons.person),
              placeholder: "Name",
              controller: techprovider.studname,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                border: Border.all(),
              ),
              // decoration: const InputDecoration(
              //   icon: Icon(
              //     Icons.person,
              //     color: black,
              //   ),
              //   border: OutlineInputBorder(),
              //   label: Text("Devops Name"),
              // ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              placeholderStyle: TextStyle(color: blue),
              prefix: Icon(Icons.class_),
              placeholder: "Batch",
              controller: techprovider.studbatch,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                border: Border.all(),
              ),
              // decoration: const InputDecoration(
              //     icon: Icon(
              //       Icons.class_,
              //       color: black,
              //     ),
              //     border: OutlineInputBorder(),
              //     label: Text("Batch")),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              placeholderStyle: TextStyle(color: blue),
              prefix: Icon(Icons.phone),
              placeholder: "Phone Number",
              controller: techprovider.studphone,
              keyboardType: TextInputType.number,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                border: Border.all(),
              ),
              maxLength: 10,

              //   decoration: const InputDecoration(
              //       icon: Icon(
              //         Icons.phone,
              //         color: black,
              //       ),
              //       border: OutlineInputBorder(),
              //       label: Text("Phone Number")),
              //   maxLength: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                dropdownColor: blue,
                decoration: const InputDecoration(
                  label: Text(
                    "Select Domain",
                    style: TextStyle(color: blue),
                  ),
                ),
                items: domains
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: black)),
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
            CupertinoButton(
              color: blue,
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  techprovider.addtechname();
                  techprovider.studname.clear();
                  techprovider.studbatch.clear();
                  techprovider.studphone.clear();

                  Navigator.pop(context);
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Devops Added",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  duration: Duration(seconds: 3),
                ));
              },
              // style: const ButtonStyle(
              //     minimumSize:
              //         MaterialStatePropertyAll(Size(double.infinity, 50)),
              //     backgroundColor: MaterialStatePropertyAll(blue)),
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
