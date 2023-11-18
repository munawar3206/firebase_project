import 'package:firebase/controller/internet_connectivity_provider.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:firebase/helper/colors.dart';
import 'package:firebase/model/techname_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<InternetConnectivityProvider>(context, listen: false)
        .getInternetConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: const Text("Devops 👨‍💻"),
        centerTitle: true,
      ),
      body: Consumer<technameProvider>(
        builder: (context, provider, child) {
          if (provider.technames.isEmpty) {
            provider.fetchtechname();
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: blue),
                      boxShadow: const [
                        BoxShadow(
                          color: white,
                          spreadRadius: 3.5,
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
                                color: black,
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
                                provider
                                    .deletetechname(namesSnap.id.toString());
                              },
                              icon: const Icon(Icons.delete))
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
          backgroundColor: blue,
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          label: const Icon(Icons.add)),
    );
  }
}
