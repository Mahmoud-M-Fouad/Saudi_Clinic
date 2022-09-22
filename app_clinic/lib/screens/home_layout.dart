import 'package:app_clinic/screens/home.dart';
import 'package:app_clinic/screens/profile.dart';
import 'package:app_clinic/screens/profile2.dart';
import 'package:flutter/material.dart';

import '../component/component.dart';
import '../component/theme.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}
var list;
bool isLoading = false;
class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("الصفحة الرئيسية",style: headingStyleWhite,),
        centerTitle: true,
      ),
      body : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Saudi Clinic',style: headingStyle2,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('image/clinic3.PNG',),
              ),
            ),
            Column(
              children: [
                MaterialButton(
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: (){
                    navigatorTo(context,  HomeScreen());
                  },

                  child: const Text("فتح التطبيق" ,style: TextStyle(color: Colors.white), ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('مكان العيادة خلف مدرسة المشتركة ',style: headingStyle3,),
                  Text('مواعيد العمل كل الأيام  ',style: headingStyle3,),
                  Text(' من الساعة 5 مساءاً إلى 10 مساءاً ماعدا الجمعة ',style: headingStyle3,),
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  navigatorTo(context, const PeofileScreen());
                }, icon:  Icon(Icons.not_listed_location_rounded,color: Colors.deepPurple.shade200,)),
                IconButton(onPressed: (){
                  navigatorTo(context, const PeofileScreen2());
                }, icon:  Icon(Icons.not_listed_location_rounded,color: Colors.deepPurple.shade200,)),
              ],
            ),

          ],
        ),
      ),
    );

  }
}
