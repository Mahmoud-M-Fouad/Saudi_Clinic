import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import '../component/component.dart';
import '../component/db.dart';
import '../component/shared_preferences.dart';
import '../component/theme.dart';
import '../model/model.dart';
class Add2Screen extends StatefulWidget {
  const Add2Screen({Key? key}) : super(key: key);

  @override
  State<Add2Screen> createState() => _Add2ScreenState();
}

class _Add2ScreenState extends State<Add2Screen> {
  var formKey = GlobalKey <FormState>();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerMoney = TextEditingController();
  TextEditingController controllerRest = TextEditingController();
  TextEditingController controllerProblem = TextEditingController();
  TextEditingController controllerNotes = TextEditingController();
  late DateTime currentDate = DateTime.now();
  late String name= "";
  late String phone= "";
  late String age= "";
  bool isLoading = true;
  bool isLoading2 = true;
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
  void validateShow(int id) async {

    list = await allDorWithID(id).then((value){
      controllerDate.text =  value[0].date;
      name =  value[0].name;
      phone =  value[0].phone;
      age =  value[0].age;
      currentDate = DateTime.parse(value[0].date);
      isLoading = false;
    });
    await allDorCount(DateFormat("yyyy-MM-dd").format(currentDate)).then((value) {
      count = value;
      isLoading2 = false;
    });
    print(list);

    setState(() {

    });
  }
  void showCount()async
  {
    await allDorCount(
        DateFormat("yyyy-MM-dd").format(currentDate)).
    then((value) {
      count = value;
      isLoading2 = false;
      print(count);
      print(isLoading);
      setState(() {
        // count = value;
      });
    });
  }
  var count ;
  var list;
  @override
  void initState() {
    // TODO: implement initState
    count =-1;
    isLoading = true;
    isLoading2 = true;
    validateShow(SharedClass.getInt(key: 'ID'));
    super.initState();

    print(count);
  }

  @override
  Widget build(BuildContext context) {

    void validateAndSave()async {
      final FormState? form = formKey.currentState;
      if (form!.validate())
      {
        int id = await maxID() >=0?await maxID() : 0;
        setState(() {
          print(id);
          var person =  Clinic( id: ++id, name: name,
              phone:phone,age: age,
              problem: controllerProblem.text,date: DateFormat("yyyy-MM-dd").format(currentDate),
              type: "إعادة", money: controllerMoney.text,notes: controllerNotes.text,rest: controllerRest.text
          );
          setState(() {
            insertDor(person,context).then((value){
              controllerProblem.clear();
              controllerMoney.clear();
              controllerRest.clear();
              controllerNotes.clear();
              showCount();
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
        /*
        actions: [
          IconButton(
              onPressed: () async {
                var id = SharedClass.getInt(key: 'ID');
                print(await id);
                validateShow(id);
                setState(() {
                  //name =  list[0].name;
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
        */
        title: Text("إضافة إعادة كشف ",style: headingStyleWhite,),
        centerTitle: true,
      ),
      body: isLoading&&isLoading2?const CircularProgressIndicator():
      SingleChildScrollView(
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

                  buildTextFormFieldNameToAdd2(
                    controller: TextEditingController(text:name),
                    text: "الأسم",
                    icon:Icons.person ,
                  ),
                  buildTextFormFieldNameToAdd2(
                    controller: TextEditingController(text:phone),
                    text: "رقم الهاتف",
                    icon:Icons.person ,
                  ),
                  buildTextFormFieldNameToAdd2(
                    controller: TextEditingController(text:age),
                    text: "السن",
                    icon:Icons.person ,
                  ),
                  buildTextFormFieldDateToAdd(
                      controller: TextEditingController(text:DateFormat("yyyy-MM-dd").format(currentDate)),
                      text: "تاريخ الكشف",
                      onPressed: ()
                      {
                        selectDate(context).then((value)async{
                          showCount();

                        });

                      }
                  ),
                  buildTextFormField(
                      controller: controllerMoney,
                      text: "الفلوس",
                      iconPre: Icons.attach_money,
                      textInputType: TextInputType.number,
                      textValidate: "أدخل الفلوس"
                  ),
                  buildTextFormField(
                      controller: controllerRest,
                      text: "باقى الفلوس",
                      iconPre: Icons.monetization_on,
                      textInputType: TextInputType.number,
                      textValidate: "أدخل باقى الفلوس"
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerProblem,
                    text: "مشكلة أن وجدا",
                    iconPre: Icons.note_alt_outlined,
                    textInputType: TextInputType.text,
                  ),
                  buildTextFormFieldProblem(
                    controller: controllerNotes,
                    text: "الملاحظات أن وجدا",
                    iconPre: Icons.note_alt,
                    textInputType: TextInputType.text,
                  ),
                  Center(
                    child: Padding(padding: const EdgeInsets.all(20),
                      child:  buildMaterialButton(
                          text: "حجز الإعادة" ,
                          color: Colors.teal.shade400,
                        function: validateAndSave
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
