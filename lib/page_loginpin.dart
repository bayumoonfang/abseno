



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'helper/app_helper.dart';
import 'helper/app_link.dart';
import 'helper/page_route.dart';

class PageLoginPIN extends StatefulWidget{
  final String getEmail;
  const PageLoginPIN(this.getEmail);
  @override
  _PageLoginPIN createState() => _PageLoginPIN();
}


class _PageLoginPIN extends State<PageLoginPIN> {
  final _verif1 = TextEditingController();
  final _verif2 = TextEditingController();
  final _verif3 = TextEditingController();
  final _verif4 = TextEditingController();
  final _verif5 = TextEditingController();
  final _verif6 = TextEditingController();

  showsuccess(String txtError){AppHelper().showFlushBarsuccess(context, txtError);
  return;}showerror(String txtError){AppHelper().showFlushBarerror(context, txtError);return;}

  proses_login() async {
    if(_verif1.text.isEmpty || _verif2.text.isEmpty || _verif3.text.isEmpty || _verif4.text.isEmpty || _verif5.text.isEmpty ||
        _verif6.text.isEmpty) {
      showerror("PIN tidak lengkap");
      return false;
    }
    final response = await http.post(applink+"mobile/api_mobile.php?act=proses_login", body: {
      "login_pin": _verif1.text+_verif2.text+_verif3.text+_verif4.text+_verif5.text+_verif6.text,
      "login_email": widget.getEmail.toString()
    }).timeout(Duration(seconds: 10),onTimeout: (){
      http.Client().close();
      showsuccess("Koneksi Terputus, silahkan ulangi sekali lagi");
      return http.Response('Error',500);
    });

    Map data = jsonDecode(response.body);
    if(data["message"] != '') {
      if(data["message"] == '0') {
        showsuccess("Mohon maaf, password salah");
      } else if(data["message"] == '1') {
        showsuccess("Mohon maaf, user anda sudah tidak aktif");
      } else {
        //savepref(widget.getEmail, data["karyawan_no"].toString(),)
        //Navigator.pushReplacement(context, ExitPage(page: PageLoginPIN(_emailq.text)));
      }
    }

  }


  @override
  Widget build(BuildContext context) {
   return RawKeyboardListener(
       focusNode: FocusNode(),
     onKey: (event) {
       if(event.isKeyPressed(LogicalKeyboardKey.backspace)){

       }
     },
     child : WillPopScope(child: Scaffold(
         appBar: new AppBar(
           elevation: 0,
           backgroundColor: Colors.white,
           leading: Builder(
             builder: (context) => IconButton(
                 icon: new FaIcon(FontAwesomeIcons.angleLeft,color: Colors.black,size: 25,),
                 color: Colors.white,
                 onPressed: () => {
                   Navigator.pop(context)
                 }),
           ),
         ),
         body: Container(
           height: double.infinity,
           width: double.infinity,
           color: Colors.white,
           padding: const EdgeInsets.only(left: 25,right: 25),
           child: Column(
             children: [
               Align(alignment: Alignment.center,
                   child : Padding(padding: const EdgeInsets.only(top: 50),child: Text("Login With Your PIN",style:
                   GoogleFonts.poppins(fontWeight: FontWeight.bold,
                       fontSize: 20),),)),
               Align(alignment: Alignment.center,
                   child : Padding(padding: const EdgeInsets.only(top: 3),child: Text("Masukan 6 digit PIN untuk masuk ke akun anda"
                     ,style: GoogleFonts.lato(fontSize: 13),),)),
               Center(
                   child : Padding(padding: const EdgeInsets.only(top: 50),
                     child: Form(
                         child : Wrap(
                           alignment: WrapAlignment.center,
                           spacing: 20,
                           children: [
                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 autofocus: true,
                                 controller: _verif1,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     FocusScope.of(context).nextFocus();
                                   }
                                 },
                                 style: Theme.of(context).textTheme.headline4,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 controller: _verif2,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     FocusScope.of(context).nextFocus();
                                   }else {
                                     FocusScope.of(context).previousFocus();
                                   }
                                 },
                                 style: Theme.of(context).textTheme.headline4,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 controller: _verif3,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     FocusScope.of(context).nextFocus();
                                   }else {
                                     FocusScope.of(context).previousFocus();
                                   }
                                 },
                                 style: Theme.of(context).textTheme.headline4,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 controller: _verif4,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     FocusScope.of(context).nextFocus();
                                   }else {
                                     FocusScope.of(context).previousFocus();
                                   }
                                 },
                                 style: Theme.of(context).textTheme.headline4,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 controller: _verif5,
                                 keyboardType: TextInputType.number,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     FocusScope.of(context).nextFocus();
                                   }else {
                                     FocusScope.of(context).previousFocus();
                                   }
                                 },
                                 style: Theme.of(context).textTheme.headline4,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 28,
                               width: 32,
                               child: TextField(
                                 controller: _verif6,
                                 keyboardType: TextInputType.number,
                                 style: Theme.of(context).textTheme.headline3,
                                 onChanged: (value) {
                                   if(value.length == 1) {
                                     proses_login();
                                     //FocusScope.of(context).nextFocus();
                                   } else {
                                     FocusScope.of(context).previousFocus();
                                   }
                                 },
                                 textAlign: TextAlign.center,
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(1),
                                   FilteringTextInputFormatter.digitsOnly
                                 ],
                               ),
                             ),

                           ],
                         )
                     )

                     ,)),

             ],
           ),

         )

     ), onWillPop: onWillPop)
   );

  }

  Future<bool> onWillPop() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
  }
}