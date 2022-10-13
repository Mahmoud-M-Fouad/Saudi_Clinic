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
import '../component/myprovider.dart';
import '../component/shared_preferences.dart';
import '../component/theme.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:lottie/lottie.dart';
import 'add2.dart';
import 'home_layout.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {

  var list;
  var count;
  DateTime currentDate = DateTime.now();
  bool isLoading = true;
  void show()async
  {
    await allDorWithDate(DateFormat("yyyy-MM-dd").format(currentDate)).
    then((value) {
      if(value.isEmpty)
        {
          setState(() {
            list = value;
            print(list);
            isLoading = true;
            showToast(context: context,
                msg: "لا يوجد أى كشوفات هذا اليوم",
                color: Colors.red
            );
          });
        }
      else{
        setState(() {
          isLoading = false;
          list = value;
          print(list);
        });
      }
      setState(() {

      });
    });
  }
@override
  void initState() {
  isLoading = true;
  currentDate = DateTime.now();
  show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        //title: const Text(" الرئسية"),
        leading: IconButton(
          icon: buildIcon(icon: Icons.home_outlined),
          onPressed: ()
          {
            navigatorToEnd(
              context: context,
              screen: const HomeLayoutScreen()
            );
          },
        ),
        actions: [
          Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*
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
                */
                IconButton(
                    onPressed: () async {
                      navigatorTo(context,const SearchScreen());
                    },
                    icon: buildIcon(icon: Icons.search_rounded)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: ()  {
                      selectDate(context).then((value){
                        show();
                        setState(() {
                        });
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
      body: isLoading? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/cleaning-teeth.json'),
        ],
      ):
      SingleChildScrollView(
        child: Column(
          children: [
           // list?.isEmpty == null
                //? Container():
                 ListView.separated(
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
                    itemCount: list?.isEmpty == null?0:list.length,
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
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          buildContainerListView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                  ),
                  const Spacer(),
                  buildRowInListView(
                    text: "الأسم",
                    list: list[index].name,
                  ),
                  const Spacer(),
                  buildRowInListView(
                    text: "السن",
                    list: list[index].age,
                  ),
                  const Spacer(),
                  buildRowInListView(
                    text: "النوع",
                    list: list[index].type,
                  ),
                  const Spacer(),
                  buildRowInListView(
                    text: "الفلوس المدفوعة",
                    list: list[index].money,
                  ),
                  const Spacer(),
                  buildRowInListView(
                    text: "باقى الفلوس",
                    list: list[index].rest,
                  ),
                  const Spacer(),
                  buildColumnInListView(
                    text: "المشكلة",
                    list: list[index].problem,
                  ),
                  const Spacer(),
                  buildColumnInListView(
                    text: "الملاحظات",
                    list: list[index].notes,
                  ),
                  const Spacer(),
                  buildPhoneInListView(
                      onPressed: () {
                        makePhoneCall(phoneNumber: list[index].phone);
                      },
                      list: list[index].phone
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
                                deleteDor(list[index].id, context).then((value){
                                  show();
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
              )
          ),
        ],
      ),
    );
  }


  buildContainerListView({
    required Widget child,
}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            border: Border.all(width: 5, color: Colors.teal.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 600,
          child: child
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
