import 'package:flutter/material.dart';
import 'package:second_project/produk/produk_page.dart';
import 'package:second_project/profile.dart';
import 'package:second_project/ui/form_page.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProdukPage(),
    );
  }
}
