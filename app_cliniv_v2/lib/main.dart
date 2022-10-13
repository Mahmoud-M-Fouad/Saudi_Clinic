import 'package:app_clinic/model/model.dart';
import 'package:app_clinic/screens/add.dart';
import 'package:app_clinic/screens/home.dart';
import 'package:app_clinic/screens/home_layout.dart';
import 'package:app_clinic/screens/screen_shot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component/db.dart';
import 'component/myprovider.dart';
import 'component/shared_preferences.dart';
import 'component/theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  createDatabase();
  await SharedClass.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'العيادة',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          backgroundColor: Colors.white,
      ),
      home: const HomeLayoutScreen(),
      //home: HomeScreen(),
    );
  }
}

