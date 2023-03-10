import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ring_size_calculator/firebase_options.dart';
import 'package:ring_size_calculator/models/ring_size.dart';
import 'package:ring_size_calculator/ui/screens/home.dart';

final ringSizesCollectionRef = FirebaseFirestore.instance.collection("ringSizes").withConverter<RingSize>(
      fromFirestore: (snapshot, _) => RingSize.fromJson(snapshot.data()!),
      toFirestore: (ringSize, _) => ringSize.toJson(),
    );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ring Size Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}
