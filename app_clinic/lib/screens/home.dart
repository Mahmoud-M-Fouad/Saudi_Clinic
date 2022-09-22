import 'package:app_clinic/component/db.dart';
import 'package:app_clinic/screens/add.dart';
import 'package:app_clinic/screens/screen_shot.dart';
import 'package:app_clinic/screens/search.dart';
import 'package:app_clinic/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../component/component.dart';
import '../component/const.dart';
import '../component/myprovider.dart';
import '../component/shared_preferences.dart';
import '../component/theme.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'add2.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var list;
var count;
bool isLoading = true;
class _HomeScreenState extends State<HomeScreen> {
  late DateTime currentDate = DateTime.now();

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        //title: const Text(" الرئسية"),
        leading: buildIcon(icon: Icons.home_outlined),
        actions: [
          Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      count = await allDorCount(DateFormat("yyyy-MM-dd").format(currentDate));
                      if (await checkDor(DateFormat("yyyy-MM-dd").format(currentDate))) {
                        list = await allDorWithDate(DateFormat("yyyy-MM-dd").format(currentDate));
                      } else {
                        list=[];
                        showToast(
                            context: context,
                            msg: "لا يوجد أى كشوفات هذا اليوم",
                            color: Colors.red);
                      }

                      setState(() {});
                    },
                    icon: buildIcon(icon: Icons.refresh)),
                IconButton(
                    onPressed: () async {
                      navigatorTo(context,const SearchScreen());
                    },
                    icon: buildIcon(icon: Icons.search_rounded)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        selectDate(context).then((value)  async{
                          list = await allDorWithDate(DateFormat("yyyy-MM-dd").format(currentDate));
                          //list = await allDor();
                          //list =  provider.allReservation(DateFormat("yyyy-MM-dd").format(currentDate));
                          count = await allDorCount(DateFormat("yyyy-MM-dd").format(currentDate));
                          print(await list);
                          print(await DateFormat("yyyy-MM-dd")
                              .format(currentDate));
                        });
                      });
                      //2022-09-28
                      setState(() {

                      });
                    },
                    icon: buildIcon(icon: Icons.date_range)),
                Text(
                  DateFormat("yyyy-MM-dd").format(currentDate),
                  style: headingStyleWhite2,
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            list?.isEmpty == null
                ? Container()
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return buildListView(
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: list.length,
// shrinkWrap: true,
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          count = await allDorCount(DateFormat("yyyy-MM-dd").format(currentDate));
          await SharedClass.setCounter(key: 'count', count: count);
          setState(() {
            navigatorTo(context,const AddScreen());
          });
        },
        child: buildIcon(icon: Icons.add),
      ),

    );
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        //currentDate = pickedDate;
        currentDate = pickedDate;
        isLoading = false;

      });
      //list = await allDor();
    }
  }
  buildListView({
    required int index,
  }) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  border: Border.all(width: 5, color: Colors.teal.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الأسم      :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].name,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "السن       :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].age,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "النوع       :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].type,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "المشكلة        :   ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].problem,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "الملاحظات   :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].notes,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "الفلوس المدفوعة  :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].money,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "باقى الفلوس :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].rest,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              makePhoneCall(phoneNumber: list[index].phone);
                            },
                            icon: Icon(
                              Icons.phone_android,
                              color: Colors.teal.shade900,
                            )),
                        Text(
                          "          :  ",
                          style: headingStyle,
                        ),
                        Text(
                          list[index].phone,
                          style: headingStyle2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialogMethod(
                              context: context,
                              cancelButton: () {
                                Navigator.pop(context);
                              },
                              continueButton: () {
                                Navigator.pop(context);

                                setState(() {
                                  deleteDor(list[index].id, context);
                                });
                                setState(() {

                                });
                              },
                              content: const Text(
                                "هل تريد حذف هذا الكشف",
                                textAlign: TextAlign.right,
                              ),
                              title: const Text(
                                "رسالة تنبية",
                                textAlign: TextAlign.right,
                              ),
                              textCancel: 'لا',
                              textContinue: 'نعم',
                            );
                            //
                            print("${list[index].id}");
                          },
                            icon: Icon(Icons.delete,color: Colors.red.shade900,size: 29,)
                        ),
                        IconButton(
                            onPressed: () {
                              showDialogMethod(
                                context: context,
                                cancelButton: () {
                                  Navigator.pop(context);
                                },
                                continueButton: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    SharedClass.setId(
                                        key: 'ID', num: list[index].id);
                                    navigatorTo(context, const UpdateScreen());
                                    print(list[index].id);
                                  });
                                },
                                content: const Text(
                                  "هل تريد تعديل هذا الكشف",
                                  textAlign: TextAlign.right,
                                ),
                                title: const Text(
                                  "رسالة تنبية",
                                  textAlign: TextAlign.right,
                                ),
                                textCancel: 'لا',
                                textContinue: 'نعم',
                              );
                            },
                            icon: Icon(Icons.edit,color: Colors.deepPurple.shade700,size: 29,)
                        ),
                        IconButton(
                            onPressed: () {
                              showDialogMethod(
                                context: context,
                                cancelButton: () {
                                  Navigator.pop(context);
                                },
                                continueButton: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    SharedClass.setId(key: 'ID', num: list[index].id);
                                    navigatorTo(context, const Add2Screen());
                                    setState(() {

                                    });
                                    print(list[index].id);
                                  });
                                },
                                content: const Text(
                                  "هل تريد حجز إعادة هذا الكشف",
                                  textAlign: TextAlign.right,
                                ),
                                title: const Text(
                                  "رسالة تنبية",
                                  textAlign: TextAlign.right,
                                ),
                                textCancel: 'لا',
                                textContinue: 'نعم',
                              );
                            },
                            icon: Icon(Icons.repeat_one_outlined,color: Colors.teal.shade900,size: 29,)
                        )
                      ],
                    ),
                    // const SizedBox(width: 20,),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
