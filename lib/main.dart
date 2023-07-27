import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SCREEN/BEFORE/SCREEN_firstloading.dart';
import 'MAPPICKER/SCREENmappicker.dart';
import 'SCREEN/LOCATION/SCREEN_LOCATION_BIKE_ST1_test.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SCREENfirstloading(),
      // home: const SCREENlocationbikest1test(),
    );
  }
}
