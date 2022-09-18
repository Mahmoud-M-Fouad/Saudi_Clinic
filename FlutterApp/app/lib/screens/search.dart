import 'package:app_clinic/screens/screen_shot.dart';
import 'package:app_clinic/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late DateTime currentDate = DateTime.now();
  TextEditingController controllerSearch = TextEditingController();

  var list;
  var count;
  late String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("بحث عن كشف",style: headingStyleWhite,),
        centerTitle: true,
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
      ),
      body: SingleChildScrollView(
        child: Column(
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
            list?.isEmpty == null
                ? Container()
                : ListView.separated(
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
              itemCount: list.length,
// shrinkWrap: true,
            )
          ],
        ),
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
                                  deleteDor(list[index].id, context);
                                  setState(() {});
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
                                    SharedClass.setId(
                                        key: 'ID', num: list[index].id);
                                    navigatorTo(context, const Add2Screen());
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
