import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: 'Klasmeyt',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.iconGrey),
          textTheme: GoogleFonts.pixelifySansTextTheme(
            ThemeData.dark().textTheme.copyWith(
                  bodyMedium: const TextStyle(
                    fontSize: 15,
                    color: AppColors.whiteColor,
                  ),
                ),
          ),
        ),
        home: const HomePage());
  }
}
