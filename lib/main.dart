import 'package:firebase/controller/internet_connectivity_provider.dart';
import 'package:firebase/controller/techname_provider.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/splash.dart';
import 'package:firebase/views/add.dart';
import 'package:firebase/views/edit.dart';
import 'package:firebase/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => technameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InternetConnectivityProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          '/s': (context) => const SplashScreen(),
          '/': (context) => Homepage(),
          '/add': (context) => AddUser(),
          '/update': (context) => Update(),
        },
        initialRoute: '/s',
      ),
    );
  }
}
