import 'package:lottie/lottie.dart';
import 'package:app_clinic/component/theme.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;
buildTextFormField(
{
  required TextEditingController controller,
  required String text,
  required String textValidate,
  required IconData iconPre,
  required var textInputType,
}
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const UnderlineInputBorder(),
          labelText: text,
          prefixIcon: Icon(iconPre, color: Colors.teal,),
          suffixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear),color: Colors.teal,),
        ),
        keyboardType: textInputType,
        validator:  (value)
        {
          if (value == null || value.isEmpty) {
            return textValidate;
          }
          return null;
        },
      ),
    ),
  );
}

buildTextFormFieldSearch(
    {
      required TextEditingController controller,
      required String text,
      required String textValidate,
      required IconData icoPre,
      required var textInputType,
      required var onChange,
    }
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(50),
          ),
          border: const UnderlineInputBorder(),
          labelText: text,
          labelStyle: headingStyle,
          prefixIcon: Icon(icoPre, color: Colors.teal,),
          suffixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear),color: Colors.teal,),
        ),
        keyboardType: textInputType,
        validator:  (value)
        {
          if (value == null || value.isEmpty) {
            return textValidate;
          }
          return null;
        },
      ),
    ),
  );
}
buildTextFormFieldDateToAdd(
    {
      required TextEditingController controller,
      required String text,
      required var onPressed,
    }
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          prefixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.date_range,color: Colors.teal,),
          ),
          border: const UnderlineInputBorder(),
          labelText: text,
        ),
       readOnly: true,
      ),
    ),
  );
}

buildTextFormFieldNameToAdd2(
    {
      required TextEditingController controller,
      required IconData icon,
      required String text,
    }
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          alignLabelWithHint: true,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: const UnderlineInputBorder(),
          labelText: text,
        ),
        readOnly: true,
      ),
    ),
  );
}

buildTextFormFieldProblem(
    {
      required TextEditingController controller,
      required String text,
      required IconData iconPre,
      required var textInputType,
    }
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: const UnderlineInputBorder(),
          labelText: text,
          prefixIcon: Icon(iconPre, color: Colors.teal,),
          suffixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear),color: Colors.teal,),
        ),
        keyboardType: textInputType,
      ),
    ),
  );
}

buildTextFormFieldDate(
    {
      required TextEditingController controller,
      required String text,
    }
    )
{
  return Directionality(
    textDirection: TextDirection.rtl,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const UnderlineInputBorder(),
        labelText: text,
        prefixIcon: const Icon(Icons.date_range, color: Colors.teal,),
       // suffixIcon: Icon(Icons.clear, color: Colors.teal,),
      ),
      readOnly: true,
    ),
  );
}


void showToast({
  required BuildContext context,
  required String msg,
  required Color color,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
     SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(msg, style:  TextStyle(color: color,fontSize: 18),textAlign: TextAlign.right,),
    ),
  );
}

buildMaterialButton({
  required Color color,
  required String text,
  required var function,
})
{
  return MaterialButton(
    color: color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    onPressed: function,
    child:Text(text ,style: headingStyleWhite ),
  );
}

buildIcon(
{
 // required Color color,
 // required double size,
  required IconData icon,
})
{
  return Icon(
    icon,
    color: Colors.white,
    size: 26,

  );
}

cancelButtonMethod(BuildContext context)
{
  Navigator.pop(context);
}

updateButtonMethod(BuildContext context , var secondRoute)
{
  navigatorTo(context , secondRoute);
}

navigatorTo(BuildContext context ,  var secondRoute )
{
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => secondRoute),
  );
}
showDialogMethod({
  required BuildContext context ,
  required Widget title ,
  required Widget content ,
  required Function cancelButton ,
  required String textCancel ,
  required var continueButton  ,
  required String textContinue
})
{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        backgroundColor: Colors.deepPurple.shade600,
        titleTextStyle: headingStyleWhite2,
        contentTextStyle: headingStyleWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),

        title: title,
        content: content,
        actions: [
          TextButton(onPressed:()
          {
            Navigator.pop(context);
          }
            , child: Text(textCancel,textAlign: TextAlign.left,
                style:TextStyle(fontSize: 20,color: Colors.red.shade700) ),),

          TextButton(onPressed:continueButton, child: Text(textContinue , textAlign: TextAlign.right,
              style:TextStyle(fontSize: 20,color: Colors.green.shade500)
          ))
        ],
      );
    },
  );
}
buildImage({
  required double radius ,
  required String imagePath ,
  required double h ,
  required double w
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      radius: radius,
      child: Image.asset(imagePath,height: h,width: w,),
    ),
  );
}

buildImageProfile({
  required double radius ,
  required String imagePath ,
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      radius: radius,
    ),
  );
}
buildCopy({
  required String textCopy ,required BuildContext context
})
{
  FlutterClipboard.copy(textCopy).then(( value ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('تم النسخ' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
  });
}

buildPast({
  required String textCopy ,required String pasteValue
})
{
  FlutterClipboard.paste().then((value) {
    textCopy = value;
    pasteValue = value;
  });

}

buildColumnInListView(
    {
      required String text,
      required var list,
    })
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$text : ',
        style: headingStyle,
      ),
      Text(
        list,
        style: headingStyle2,
      ),
    ],
  );
}

buildRowInListView(
    {
      required String text,
      required var list,
    })
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$text : \t\t',
        style: headingStyle,
      ),
      Text(
        list,
        style: headingStyle2,
      ),
    ],
  );
}

buildPhoneInListView({
  required var onPressed,
  required var list,
})
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.phone_android,
            color: Colors.teal.shade900,
          )),
      Text(
        ':  ',
        style: headingStyle,
      ),
      Text(
        '$list ',
        style: headingStyle2,
      ),
    ],
  );
}

buildLottie() {
  return Lottie.asset("cleaning-teeth.json");
}


  navigatorToEnd(
      {
        required BuildContext context,
        required var screen,
      })
  {
    return Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
      ),
          (route) => false,//if you want to disable back feature set to false
    );
  }