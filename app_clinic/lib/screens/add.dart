import 'package:app_clinic/component/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../component/component.dart';
import '../component/const.dart';
import '../component/db.dart';
import '../component/shared_preferences.dart';
import '../model/model.dart';
import 'dart:ui' as ui;
class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  var formKey = GlobalKey <FormState>();
  late int id;

  late DateTime currentDate = DateTime.now();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerProblem = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMoney = TextEditingController();
  TextEditingController controllerRest = TextEditingController();
  TextEditingController controllerNotes = TextEditingController();

  var count ;

  @override
  void initState() {
    // TODO: implement initState

     count =-1;
    super.initState();
setState(() {

});
    print(count);
  }
  Widget build(BuildContext context) {
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

    void validateAndSave()async {
      final FormState? form = formKey.currentState;
      if (form!.validate())
      {
        int id = await maxID() >=0?await maxID() : 0;
        setState(() {
          print(id);
          var person =  Clinic( id: ++id, name: controllerName.text,
              phone:controllerPhone.text,age: controllerAge.text,
              problem: controllerProblem.text,date: DateFormat("yyyy-MM-dd").format(currentDate),
              type: "??????", money: controllerMoney.text,notes: controllerNotes.text,rest: controllerRest.text
          );
          setState(() {
            insertDor(person,context).then((value){
              controllerName.clear();
              controllerPhone.clear();
              controllerAge.clear();
              controllerProblem.clear();
              controllerMoney.clear();
              controllerRest.clear();
              controllerNotes.clear();
            });
          });
          //Navigator.pop(context);
          setState(() {
          });
          print('Form is valid');
        });
      }
      else {
        print('Form is invalid');
      }
      setState(() {

      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("?????????? ?????? ????????",style: headingStyleWhite,),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                count = await allDorCount(DateFormat("yyyy-MM-dd").format(
                    currentDate));
                setState(() {

                });
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

            count == -1?Container():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child:  CircleAvatar(
                  child: Text("${count+1}"),
                ),
              ),
            ),

            buildTextFormFieldDateToAdd(
                controller: TextEditingController(text:DateFormat("yyyy-MM-dd").format(currentDate)),
                text: "?????????? ??????????",
                onPressed: () {
                  selectDate(context).then((value) async {
                    count = await allDorCount(DateFormat("yyyy-MM-dd").format(
                        currentDate));
                    print(await count);
                  }
                  );
                }
            ),
            buildTextFormField(
                controller: controllerName,
                text: "??????????",
                iconPre: Icons.person,
                textInputType: TextInputType.text,
                textValidate: "???????? ??????????"
            ),
            buildTextFormField(
                controller: controllerPhone,
                text: "?????? ????????????",
                iconPre: Icons.phone_android,
                textInputType: TextInputType.phone,
                textValidate: "???????? ?????? ????????????"
            ),
            buildTextFormField(
                controller: controllerAge,
                text: "????????",
                iconPre: Icons.numbers,
                textInputType: TextInputType.number,
                textValidate: "???????? ????????"
            ),
            buildTextFormField(
                controller: controllerMoney,
                text: "????????????",
                iconPre: Icons.attach_money,
                textInputType: TextInputType.number,
                textValidate: "???????? ????????????"
            ),
            buildTextFormField(
                controller: controllerRest,
                text: "???????? ????????????",
                iconPre: Icons.monetization_on,
                textInputType: TextInputType.number,
                textValidate: "???????? ???????? ????????????"
            ),
            buildTextFormFieldProblem(
              controller: controllerProblem,
              text: "?????????? ???? ????????",
              iconPre: Icons.note_alt_outlined,
              textInputType: TextInputType.text,
            ),
            buildTextFormFieldProblem(
              controller: controllerNotes,
              text: "?????????????????? ???? ????????",
              iconPre: Icons.note_alt,
              textInputType: TextInputType.text,
            ),
            Center(
              child: Padding(padding: const EdgeInsets.all(20),
                child:  buildMaterialButton(
                    text: "?????? ??????????" ,
                    color: Colors.teal.shade400,
                    function:validateAndSave
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
