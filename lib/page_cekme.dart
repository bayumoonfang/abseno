import 'dart:async';

import 'package:abseno/page_home.dart';
import 'package:abseno/page_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'helper/app_helper.dart';
import 'helper/page_route.dart';


class PageCheck extends StatefulWidget{

  @override
  _PageCheck createState() => _PageCheck();
}



class _PageCheck extends State<PageCheck> {

  showsuccess(String txtError){AppHelper().showFlushBarsuccess(context, txtError);
  return;}showerror(String txtError){AppHelper().showFlushBarerror(context, txtError);return;}


  _startingVariable() async {
    await AppHelper().getConnect().then((value){if(value == 'ConnInterupted'){
      showerror("Koneksi terputus..");}});
    await AppHelper().getSession().then((value){
      setState(() {
        if(value[0] == null) {
          Navigator.pushReplacement(context, ExitPage(page: PageLogin()));
        } else {
          Navigator.pushReplacement(context, ExitPage(page: Home()));
        }
      });});
  }


  loadData() async {
    await _startingVariable();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child : Visibility(
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    height: 60.0,
                    width: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text("Menyiapkan Data..."),
                  )

                ],
              )
          )
      ),
    ), onWillPop: onWillPop);
  }


  Future<bool> onWillPop() {

  }
}