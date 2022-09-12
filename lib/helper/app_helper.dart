




import 'dart:convert';

import 'package:abseno/helper/session.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'app_link.dart';
import 'connection_cek.dart';

class AppHelper{

  static var today = new DateTime.now();
  //var getBulan = new DateFormat.MMMM().format(today);
  //var getTahun = new DateFormat.y().format(today);
  var point_value = "1000";


  String getTahun() {
    return new DateFormat.y().format(today);
  }

  String getTanggal() {
    return new DateFormat.d().format(today);
  }


  String getNamaHari() {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(today.toString());
    var day = DateFormat('EEEE').format(dateTime);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {hari = "Minggu";}
        break;
      case 'Monday':
        {hari = "Senin";}
        break;
      case 'Tuesday':
        {hari = "Selasa";}
        break;
      case 'Wednesday':
        {hari = "Rabu";}
        break;
      case 'Thursday':
        {hari = "Kamis";}
        break;
      case 'Friday':
        {hari = "Jumat";}
        break;
      case 'Saturday':
        {hari = "Sabtu";}
        break;
    }
    return hari;
  }



  String getNamaBulan() {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(today.toString());
    var m = DateFormat('MM').format(dateTime);
    var d = DateFormat('dd').format(dateTime).toString();
    var Y = DateFormat('yyyy').format(dateTime).toString();
    var month = "";
    switch (m) {
      case '01':
        {month = "Januari";}
        break;
      case '02':
        {month = "Februari";}
        break;
      case '03':
        {month = "Maret";}
        break;
      case '04':
        {month = "April";}
        break;
      case '05':
        {month = "Mei";}
        break;
      case '06':
        {month = "Juni";}
        break;
      case '07':
        {month = "Juli";}
        break;
      case '08':
        {month = "Agustus";}
        break;
      case '09':
        {month = "September";}
        break;
      case '10':
        {month = "Oktober";}
        break;
      case '11':
        {month = "November";}
        break;
      case '12':
        {month = "Desember";}
        break;
    }
    return month;
  }


  String getTanggal_withhari() {
    return getNamaHari().toString()+", "+getTanggal().toString()+" "+getNamaBulan().toString()+ " "+getTahun().toString();
  }

  String getTanggal_nohari() {
    return getTanggal().toString()+" "+getNamaBulan().toString()+ " "+getTahun().toString();
  }

  String getTanggal_me(String val_tanggal) {
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(val_tanggal);
    return new DateFormat.y().format(dateTime);
  }



  Future<String> getConnect() async {
    ConnectionCek().check().then((internet){
      if (internet != null && internet) {} else {
        return "ConnInterupted";
      }
    });
  }

  Future<dynamic> getSession () async {
    String getEmail = await Session.getEmail();
    String getUsername = await Session.getUsername();
    String getKaryawanId = await Session.getKaryawanId();
    String getKaryawanNama = await Session.getKaryawanNama();
    String getKaryawanNo = await Session.getKaryawanNo();

    return [
      getEmail, //0,
      getUsername, //1
      getKaryawanId, //2
      getKaryawanNama, //3
      getKaryawanNo, //4
    ];

  }

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


  Future<dynamic> getDetailUser(String getKaryawanNo) async {
    http.Response response = await http.Client().get(
        Uri.parse(applink+"mobile/api_mobile.php?act=getDetailUser&karyawan_no="+getKaryawanNo.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"}).timeout(
        Duration(seconds: 10),onTimeout: (){
      http.Client().close();
      return http.Response('Error',500);
    }
    );
    var data = jsonDecode(response.body);
    return [
      data["karyawan_jabatan"].toString(), //0
    ];
  }


}