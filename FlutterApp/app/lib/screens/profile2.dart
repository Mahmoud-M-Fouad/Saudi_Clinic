
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/component.dart';
import '../component/theme.dart';

class PeofileScreen2 extends StatelessWidget {
  const PeofileScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Uri toLaunch = Uri(scheme: 'https', host: 'github.com', path: 'Mahmoud-M-Fouad');
     String pasteValue='';
    return Scaffold(
      appBar: AppBar(
        title: Text("Saudi Clinic",style: headingStyleWhite,),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple.shade500,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.,
                children: [

                  buildImageProfile(
                    imagePath:'image/dr.jpg',
                    radius: 100,
                  ),
                  const SizedBox(height: 20,),
                  Text("Dr. Mahmoud Ali Abu Al-Saud",style: headingStyleWhite,),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      makePhoneCall(phoneNumber: "01022902564");
                    },
                    onLongPress: ()
                    {
                      buildCopy(textCopy: "01022902564", context: context);
                    },
                    child: buildColumnShow(
                        icon: Icons.phone, list: "01022902564"),
                  ),
                  const SizedBox(height: 20,),
                  //--------------------------------------------------------------
                  Container(color:  Colors.deepPurple.shade500,height: 20,padding: EdgeInsets.all(10),),
                  //--------------------------------------------------------------
                  buildImageProfile(
                    imagePath:'image/noon.jpeg',
                    radius: 100,
                  ),
                  const SizedBox(height: 20,),
                  Text("ِAhmed Adel",style: headingStyleWhite,),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      makePhoneCall(phoneNumber: "01069042990");
                    },
                    onLongPress: ()
                    {
                      buildCopy(textCopy: "01069042990", context: context);
                    },
                    child: buildColumnShow(
                        icon: Icons.phone, list: "01069042990"),
                  ),
                  const SizedBox(height: 20,),

                ],
            ),
          ),
        ),
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
  Future<void> makeMail({required String mail}) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: mail,
    );
    await launchUrl(launchUri);
  }
  Future<void> launchInBrowser({required Uri url}) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
  buildColumnShow({required IconData icon, required var list}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$list",
          style: headingStyleWhite,
          textAlign: TextAlign.right,
          maxLines: 2,
        ),
        const SizedBox(width: 20,),
        Icon(
          icon,
          color: Colors.yellowAccent.shade700,
        ),
      ],
    );
  }
}
