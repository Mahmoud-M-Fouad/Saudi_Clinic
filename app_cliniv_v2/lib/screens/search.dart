import 'package:app_clinic/screens/screen_shot.dart';
import 'package:app_clinic/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../component/component.dart';
import '../component/db.dart';
import '../component/shared_preferences.dart';
import '../component/theme.dart';
import '../model/model.dart';
import 'add2.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controllerSearch = TextEditingController();
  DateTime currentDate = DateTime.now();
  var list;
  var count;
  late String name = "";
  bool isLoading = true;
  void show()async
  {
    await allDorWithLast50Date().
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
    show();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("بحث عن كشف",style: headingStyleWhite,),
        title: Text("بحث عن كشف",style: headingStyleWhite,),
        centerTitle: true,
        /*
        actions: [
          IconButton(
              onPressed: () async {
                print(await checkName(name));
                if(controllerSearch.text.isNotEmpty&&await checkName(name))
                {
                  list = await allClinicSearch(name);
                  print(await list);
                  print(await name);
                }
                else
                {
                  list=[];
                  showToast(
                      context:context,
                      msg: "لا يوجد كشف بهذا الأسم",
                      color: Colors.red
                  );
                }
                setState(() {});
              },
              icon: buildIcon(icon: Icons.refresh)
          ),
        ],
        */
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 90,
              child: buildTextFormFieldSearch(
                  controller: controllerSearch,
                  text: "أسم الكشف",
                  textValidate: "أدخل أسم الكشف",
                  textInputType: TextInputType.text,
                  icoPre: Icons.search_rounded,
                onChange: (val)async
                  {
                    setState(() {
                      name = val;
                    });

                    if(controllerSearch.text.isNotEmpty)
                    {
                      list = await allClinicSearch(name);
                      print(await list);
                      print(await name);
                    }
                  }
              )
            ),
            //list?.isEmpty == null
                //? Container():
              isLoading?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/cleaning-teeth.json'),
                ],
              ):
              ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return buildListView(index: index);
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
    );
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
                    text: "التاريخ",
                    list: list[index].date,
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
          height: 620,
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
