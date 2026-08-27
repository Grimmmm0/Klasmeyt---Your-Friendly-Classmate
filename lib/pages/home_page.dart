import 'package:flutter/material.dart';
import 'package:klasmeyt/feature_box.dart';
import 'package:klasmeyt/themes/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klasmeyt'),
        centerTitle: true,
        leading: const Icon(Icons.menu_outlined),
        backgroundColor: AppColors.iconGrey,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 115,
                  width: 100,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.proButton,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 123,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage('assets/student.png')),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
            ).copyWith(top: 30),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.textGrey,
              ),
              borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Gandang Araw, Klasmeyt ano yun?',
                style: TextStyle(color: AppColors.whiteColor, fontSize: 25),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 10,
              left: 22,
            ),
            child: const Text('Ito ang aking mga tampok',
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          const Column(
            children: [
              FeatureBox(
                color: AppColors.submitButton,
                headerText: 'ChatGPT',
                descriptionText:
                    'AI nang nakakarami ang ChatGPT kahit lola mo alam',
              )
            ],
          ),
        ],
      ),
    );
  }
}
