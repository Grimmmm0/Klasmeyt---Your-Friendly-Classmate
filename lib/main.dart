import 'package:flutter/material.dart';
import 'package:klasmeyt/pages/home_page.dart';
import 'package:klasmeyt/themes/colors.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background,),
      home: const HomePage(),
    );

  }
}



