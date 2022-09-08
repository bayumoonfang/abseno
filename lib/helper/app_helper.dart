




import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHelper{


  showFlushBarsuccess(BuildContext context, String stringme) => Flushbar(
    // title:  "Hey Ninja",
    message:  stringme,
    shouldIconPulse: false,
    duration:  Duration(seconds: 5),
    backgroundColor: Colors.black,
    flushbarPosition: FlushbarPosition.TOP ,
  )..show(context);


  showFlushBarerror(BuildContext context, String stringme) => Flushbar(
    // title:  "Hey Ninja",
    message:  stringme,
    shouldIconPulse: false,
    duration:  Duration(seconds: 5),
    backgroundColor: Colors.red,
    flushbarPosition: FlushbarPosition.TOP ,
  )..show(context);


  showsuccess(String txtError){
    BuildContext context;
    showFlushBarsuccess(context, txtError);
    return;
  }

  showerror(String txtError){
    BuildContext context;
    showFlushBarerror(context, txtError);
    return;
  }




}