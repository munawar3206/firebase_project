import 'package:firebase/controller/internet_connectivity_provider.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:firebase/helper/colors.dart';
import 'package:firebase/model/techname_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetConnectivityProvider>(context, listen: false)
        .getInternetConnectivity(context);
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 77, 117),
        title: const Text("Devops 👨‍💻"),
        centerTitle: true,
      ),
      body: Consumer<technameProvider>(
        builder: (context, provider, child) {
          if (provider.technames.isEmpty) {
            // provider.fetchtechname();
            return Center(
              child: Lottie.asset("asset/Animation - 1700211173728.json",
                  height: 250, width: 250),
            );
          }
          return ListView.builder(
            itemCount: provider.technames.length,
            itemBuilder: (context, index) {
              final TechModel namesSnap = provider.technames[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color.fromARGB(255, 3, 77, 117),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: white,
                          spreadRadius: 4,
                          //  blurRadius: 2.5
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: blue,
                          radius: 30,
                          child: Text(
                            namesSnap.domain.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text("👨‍💻  "),
                              Text(
                                namesSnap.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("🏛️  "),
                              Text(namesSnap.batch.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("📞  "),
                              Text(namesSnap.phone.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/update',
                                    arguments: {
                                      'name': namesSnap.name,
                                      'batch': namesSnap.batch,
                                      'phone': namesSnap.phone.toString(),
                                      'domain': namesSnap.domain,
                                      'id': namesSnap.id
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: blue,
                                    title: const Text('Confirm Deletion'),
                                    content: const Text(
                                        'Are you sure you want to delete'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider.deletetechname(
                                              namesSnap.id.toString());
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text("Deleted!!"),
                                            duration: Duration(seconds: 3),
                                          ));
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 3, 77, 117),
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          label: const Icon(Icons.add)),
    );
  }
}
