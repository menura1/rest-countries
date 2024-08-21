import 'package:flutter/material.dart';
import 'package:rest_countries/presentation/screens/AllCountriesScreen.dart';
import 'package:rest_countries/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: MaterialTheme.darkScheme(),
        useMaterial3: true,
      ),
      home: const AllCountriesScreen(),
    );
  }
}
