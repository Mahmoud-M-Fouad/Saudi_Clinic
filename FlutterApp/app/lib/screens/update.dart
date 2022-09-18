import 'package:app_clinic/component/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../component/component.dart';
import '../component/const.dart';
import '../component/db.dart';
import '../component/shared_preferences.dart';
import '../model/model.dart';
import 'dart:ui' as ui;
class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  var formKey = GlobalKey <FormState>();
  late int id;
  late String type;


  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerProblem = TextEditingController();
  TextEditingController controllerMoney = TextEditingController();
  TextEditingController controllerRest = TextEditingController();
  TextEditingController controllerNotes = TextEditingController();
  var count ;
  late DateTime currentDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState

    count =-1;
    super.initState();

    print(count);
  }
  Widget build(BuildContext context) {
    var list;
    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(DateTime.now().year-1),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate) {
        setState(() {
          currentDate = pickedDate;
        });
      }
    }
    TextEditingController controllerDate = TextEditingController();

    void validateshow(int id) async {
       list = await allDorWithID(id);
      print(list);
      controllerName.text = list[0].name;
      controllerPhone.text =  list[0].phone;
      controllerAge.text =  list[0].age;
      controllerProblem.text =  list[0].problem;
      controllerDate.text =  list[0].date;
      controllerMoney.text =  list[0].money;
      controllerRest.text =  list[0].rest;
      controllerNotes.text =  list[0].notes;
      type =  list[0].type;
      currentDate = DateTime.parse(list[0].date);
      setState(() {

      });
    }

    return Scaffold(
      appBar: AppBar(
        title:Text("تعديل بيانات الكشف",style: headingStyleWhite,),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {

                });
                var id = SharedClass.getInt(key: 'ID');
                print(await id);
                validateshow(id);

              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextFormFieldDateToAdd(
                      controller: TextEditingController(text:DateFormat("yyyy-MM-dd").format(currentDate)),
                      text: "تاريخ الكشف",
                      onPressed: ()
                      {
                        selectDate(context);

                      }
                  ),
                  buildTextFormField(
                      controller: controllerName,
                      text: "الأسم",
                      iconPre: Icons.person,
                      textInputType: TextInputType.text,
                      textValidate: "أدخل الأسم"
                  ),
                  buildTextFormField(
                      controller: controllerPhone,
                      text: "رقم الهاتف",
                      iconPre: Icons.phone_android,
                      textInputType: TextInputType.phone,
                      textValidate: "أدخل رقم الهاتف"
                  ),
                  buildTextFormField(
                      controller: controllerAge,
                      text: "السن",
                      iconPre: Icons.numbers,
                      textInputType: TextInputType.number,
                      textValidate: "أدخل السن"
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerMoney,
                    text: "الفلوس",
                    iconPre: Icons.monetization_on_outlined,
                    textInputType: TextInputType.number,
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerRest,
                    text: "باقى الفلوس",
                    iconPre: Icons.attach_money,
                    textInputType: TextInputType.number,
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerProblem,
                    text: "مشكلة أن وجدا",
                    iconPre: Icons.note_alt_outlined,
                    textInputType: TextInputType.text,
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerNotes,
                    text: "الملاحظات",
                    iconPre: Icons.note_alt,
                    textInputType: TextInputType.text,
                  ),

                  Center(
                    child: Padding(padding: const EdgeInsets.all(20),
                      child:  buildMaterialButton(
                          text: "تعديل الكشف" ,
                        color: Colors.teal.shade400,
                        function: ()
                        {
                          print(SharedClass.getInt(key: 'ID'),);
                          final FormState? form = formKey.currentState;
                          if (form!.validate()) {
                            var math = Clinic(
                              id: SharedClass.getInt(key: 'ID'),
                              date: DateFormat("yyyy-MM-dd").format(currentDate),
                              name: controllerName.text,
                              phone: controllerPhone.text,
                              age: controllerAge.text,
                              problem: controllerProblem.text,
                              money: controllerMoney.text,
                              rest: controllerRest.text,
                              notes: controllerNotes.text,
                              type: type,
                            );
                            updateDor(math , context);
                            print(controllerDate.text);
                            print('Form is valid');
                          } else {
                            print('Form is invalid');
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
