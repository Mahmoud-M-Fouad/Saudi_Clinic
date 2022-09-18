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

  late DateTime currentDate = DateTime.now();
  late String name= "";
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
  var count ;
  var list;
  @override
  void initState() {
    // TODO: implement initState

    count =-1;
    super.initState();

    print(count);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerDate = TextEditingController();
    TextEditingController controllerName = TextEditingController();
    void validateshow(int id) async {
       list = await allDorWithID(id);
      print(list);
      controllerDate.text =  list[0].date;
      name =  list[0].name;
      currentDate = DateTime.parse(list[0].date);
      setState(() {

      });
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var id = SharedClass.getInt(key: 'ID');
                print(await id);
                validateshow(id);
                setState(() {
                  //name =  list[0].name;
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
        title: Text("إضافة إعادة كشف ",style: headingStyleWhite,),
        centerTitle: true,
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

                  buildTextFormFieldNameToAdd2(
                    controller: TextEditingController(text:name),
                  ),
                  buildTextFormFieldDateToAdd(
                      controller: TextEditingController(text:DateFormat("yyyy-MM-dd").format(currentDate)),
                      text: "تاريخ الكشف",
                      onPressed: ()
                      {
                        selectDate(context).then((value)async{
                          count = await allDorCount(DateFormat("yyyy-MM-dd").format(currentDate));
                          print( DateFormat("yyyy-MM-dd").format(currentDate));
                          print(await count);

                        });

                      }
                  ),

                  Center(
                    child: Padding(padding: const EdgeInsets.all(20),
                      child:  buildMaterialButton(
                          text: "حجز الإعادة" ,
                          color: Colors.teal.shade400,
                          function:(){
                            print("After add2 " + DateFormat("yyyy-MM-dd").format(currentDate));
                            updateDate(
                                context: context,
                                id: SharedClass.getInt(key: 'ID'),
                                date: DateFormat("yyyy-MM-dd").format(currentDate)
                            );
                          }
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
