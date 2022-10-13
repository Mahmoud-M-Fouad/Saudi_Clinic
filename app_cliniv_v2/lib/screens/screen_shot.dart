import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:screenshot/screenshot.dart';
import '../component/component.dart';
import '../component/db.dart';
import '../component/shared_preferences.dart';
import '../component/theme.dart';
import 'package:path_provider/path_provider.dart';
class ScreenShotScreen extends StatefulWidget {
  const ScreenShotScreen({Key? key}) : super(key: key);

  @override
  State<ScreenShotScreen> createState() => _ScreenShotScreenState();
}

class _ScreenShotScreenState extends State<ScreenShotScreen> {
  var list;

  void getData() async {
    list = await allDorWithID(SharedClass.getInt(key: 'ID'));
  }

  ScreenshotController controller = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: controller,
        child: Scaffold(
          body: list?.isEmpty == null
              ? Container()
              : SingleChildScrollView(
            child: SafeArea(
              child: InkWell(
                  onLongPress: () async {
                   controller.captureFromWidget(Directionality(
                     textDirection: ui.TextDirection.rtl,
                     child: Padding(
                         padding: const EdgeInsets.only(
                             top: 90, bottom: 50, left: 15, right: 15),
                         child: Container(
                             padding: const EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               color: Colors.teal.shade100,
                               border: Border.all(
                                   width: 5,
                                   color: Colors.teal.shade300),
                               borderRadius: BorderRadius.circular(20),
                             ),
                             height: 500,
                             child: Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               children: [
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "الأسم      :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].name,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Text(
                                       "السن       :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].age,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Text(
                                       "النوع       :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].type,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "المشكلة        :   ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].problem,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Text(
                                       "الملاحظات   :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].notes,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Text(
                                       "الفلوس المدفوعة  :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].money,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Text(
                                       "باقى الفلوس :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].rest,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 const Spacer(),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.start,
                                   children: [
                                     Icon(
                                       Icons.phone_android,
                                       color: Colors.teal.shade900,
                                     ),
                                     Text(
                                       "          :  ",
                                       style: headingStyle,
                                     ),
                                     Text(
                                       list[0].phone,
                                       style: headingStyle2,
                                     ),
                                   ],
                                 ),
                                 // const SizedBox(width: 20,),
                               ],
                             ))),
                   ));
                   final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
                   String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                   String path = directory;
                   controller.captureAndSave(
                       path, //set path where screenshot will be saved
                       fileName: fileName,
                   );
                  },
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 90, bottom: 50, left: 15, right: 15),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade100,
                              border: Border.all(
                                  width: 5,
                                  color: Colors.teal.shade300),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 500,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الأسم      :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].name,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "السن       :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].age,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "النوع       :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].type,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "المشكلة        :   ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].problem,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الملاحظات   :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].notes,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الفلوس المدفوعة  :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].money,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "باقى الفلوس :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].rest,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      color: Colors.teal.shade900,
                                    ),
                                    Text(
                                      "          :  ",
                                      style: headingStyle,
                                    ),
                                    Text(
                                      list[0].phone,
                                      style: headingStyle2,
                                    ),
                                  ],
                                ),
                                // const SizedBox(width: 20,),
                              ],
                            ))),
                  )),
            ),
          ),)
    );
  }

}
