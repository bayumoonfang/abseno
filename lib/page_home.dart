



import 'dart:ui';

import 'package:abseno/page_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/app_helper.dart';
import 'helper/page_route.dart';

class Home extends StatefulWidget{

  @override
  _Home createState() => _Home();
}


class _Home extends State<Home> {
  bool _isVisible = false;
  showsuccess(String txtError){AppHelper().showFlushBarsuccess(context, txtError);
  return;}showerror(String txtError){AppHelper().showFlushBarerror(context, txtError);return;}


  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("email", null);
      preferences.setString("username", null);
      preferences.setString("karyawan_id", null);
      preferences.setString("karyawan_nama", null);
      preferences.setString("karyawan_no", null);
      preferences.commit();
      Navigator.pushReplacement(context, ExitPage(page: PageLogin()));
    });
  }



  String getKaryawanNama = "...";
  String getKaryawanJabatan = "...";
  String getKaryawanNo;
  _startingVariable() async {
    await AppHelper().getConnect().then((value){if(value == 'ConnInterupted'){
      showerror("Koneksi terputus..");}});
    await AppHelper().getSession().then((value){
      setState(() {
        if(value[0] == "" || value[0] == null) {
           Navigator.pushReplacement(context, ExitPage(page: PageLogin()));} else {
          getKaryawanNama = value[3];
          getKaryawanNo = value[4];
        }
      });});
    await AppHelper().getDetailUser(getKaryawanNo.toString()).then((value){
      setState(() {
        getKaryawanJabatan = value[0];
      });
    });
    EasyLoading.dismiss();
  }


  loadData() async {await _startingVariable();}


  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Loading...");
    loadData();
  }


  @override
  Widget build(BuildContext context) {
      return WillPopScope(child: Scaffold(
        appBar: new AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/doodleme30.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: HexColor("#3aa13d"),
          automaticallyImplyLeading: false,
          actions: [
            Padding(padding: const EdgeInsets.only(top: 19,right: 25), child :
            InkWell(
              hoverColor: Colors.transparent,
              child : FaIcon(FontAwesomeIcons.cog, size: 20,color: Colors.white,),
              onTap: () {
                _logout();
                //Navigator.push(context, ExitPage(page: SettingHome(getEmail, getLegalCode)));
              },
            )
            ),
          ],
          title:
              Container(
                padding: const EdgeInsets.only(left: 0),
                height: 150,
                width: 120,
                child : Image.asset('assets/logo.png',height: 180,fit: BoxFit.cover,),
              ),
          elevation: 0,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color:  HexColor("#3aa13d"),
                image: DecorationImage(
                  image: AssetImage("assets/doodleme30.png"),
                  fit: BoxFit.cover,
                ),
              ),
                width: double.infinity,
                  height: 155,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 15),
                            child:  Align(
                              alignment: Alignment.bottomLeft,
                              child:  Text("Halo,", style: TextStyle(color: Colors.white,
                                  fontFamily: 'VarelaRound', fontSize: 12,
                                  fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 5),
                            child:  Align(
                              alignment: Alignment.bottomLeft,
                              child:  Container(
                                  padding: const EdgeInsets.only(top: 2),
                                  height: 33,
                                  width: double.infinity,
                                  child:Text(
                                    getKaryawanNama.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'VarelaRound',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),)
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 1),
                            child:  Align(
                                alignment: Alignment.bottomLeft,
                                child:  Opacity(
                                  opacity: 0.7,
                                  child: Text(getKaryawanJabatan.toString(), style: TextStyle(color: Colors.white,
                                      fontFamily: 'VarelaRound', fontSize: 11,
                                      fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                )
                            )
                        ),

                      ],
                    ),

                  ],
                ),
            ),
            Padding(padding: const EdgeInsets.only(top: 95,left: 25,right: 25),
              child : Container(
                height: 212,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child:  Padding(padding: const EdgeInsets.only(top: 12,left: 25,right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Center(
                              child: Text(
                                DateFormat('HH:mm').format(DateTime.now()),
                                style: GoogleFonts.lato(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      Padding(padding: const EdgeInsets.only(top: 8,left: 25,right: 25),
                        child: Text(
                          AppHelper().getTanggal_withhari().toString(),
                            style: GoogleFonts.nunito(fontSize: 13)
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(top: 8,left: 25,right: 25),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                              crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,

                            children: [
                              Text(
                                  "08.00",
                                  style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold)
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:      Text(
                                    "-",
                                    style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:      Text(
                                    "17.00",
                                    style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold)
                                ),
                              )
                            ],
                          ),
                        )
                      ),

                      Padding(padding: const EdgeInsets.only(top: 13,left: 25,right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.mapMarker,size: 12,color: Colors.blue,),
                            Padding(padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                "Miracle Thamrin",
                                style: GoogleFonts.nunito(fontSize: 17,color: Colors.blue)
                            ),)
                          ],
                        )
                      ),

                      Padding(padding: const EdgeInsets.only(top: 20,left: 25,right: 25),
                        child: Wrap(
                          spacing: 30,
                          children: [
                          Container(
                            width: 100,
                            child: RaisedButton(child : Text("Clock In",style: TextStyle(color:Colors.white),),
                              color: HexColor("#3aa13d"),
                              elevation: 0,
                              shape: RoundedRectangleBorder(side: BorderSide(
                                  color: Colors.white,
                                  width: 0.1,
                                  style: BorderStyle.solid
                              ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),onPressed: (){

                              },),
                          ),
                            Container(
                              width: 100,
                              child: RaisedButton(child : Text("Clock Out",style: TextStyle(color:Colors.white),),
                                elevation: 0,
                                color: HexColor("#3aa13d"),
                                shape: RoundedRectangleBorder(side: BorderSide(
                                    color: Colors.white,
                                    width: 0.1,
                                    style: BorderStyle.solid
                                ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),onPressed: (){

                                },),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              )
            ),

            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 355,left: 25,right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    children: [
                      InkWell(
                        onTap: (){
                          // Navigator.push(context, ExitPage(page: PageRedeemPoint())).then(onGoBack);
                        },
                        child:Column(
                          children: [
                            Container(
                                height: 55, width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: HexColor("#eef9ff"),
                                  border: Border.all(
                                    color: HexColor("#36bbf6"),
                                    width: 0.5,
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.calendarAlt, color: HexColor("#36bbf6"), size: 24,),
                                )
                            ),
                            Padding(padding: const EdgeInsets.only(top:8),
                              child: Text("Time Off", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          // Navigator.push(context, ExitPage(page: PageRedeemPoint())).then(onGoBack);
                        },
                        child:Column(
                          children: [
                            Container(
                                height: 55, width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: HexColor("#f7faff"),
                                  border: Border.all(
                                    color: HexColor("#1c6bea"),
                                    width: 0.5,
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.bell, color: HexColor("#1c6bea"), size: 24,),
                                )
                            ),
                            Padding(padding: const EdgeInsets.only(top:8),
                              child: Text("Request", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          // Navigator.push(context, ExitPage(page: PageRedeemPoint())).then(onGoBack);
                        },
                        child:Column(
                          children: [
                            Container(
                                height: 55, width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: HexColor("#fff4f0"),
                                  border: Border.all(
                                    color: HexColor("#ff8556"),
                                    width: 0.5,
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.clipboard, color: HexColor("#ff8556"), size: 24,),
                                )
                            ),
                            Padding(padding: const EdgeInsets.only(top:8),
                              child: Text("Reimbursment", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                          ],
                        ),
                      ),

                    ],
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Opacity(opacity: 0.5, child: Container(height: 4, width: double.infinity, color: HexColor("#DDDDDD"),),)),


                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child :
                    Text("Kehadiran",style: GoogleFonts.varela(fontWeight: FontWeight.bold,fontSize: 16),)
                  ),
                ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child:
                        Table(
                          border: TableBorder.all(
                              color: HexColor("#DDDDDD"),
                              style: BorderStyle.solid,
                              width: 1),
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0))
                                ),
                                children: [
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child :  Align(
                                    alignment : Alignment.centerLeft,
                                    child: Text('Hari ini, ('+ AppHelper().getTanggal_nohari().toString()+')' , style:
                                    GoogleFonts.nunitoSans(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
                                  )
                              )
                            ]),
                            TableRow( children: [
                              Column(children:[
                                Padding(padding: const EdgeInsets.only(top: 10,right: 25,left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                   Container(
                                     height: 70,
                                     width: 150,
                                     child:    ListTile(
                                         dense: true,
                                       leading: FaIcon(FontAwesomeIcons.clock, color: HexColor("#1c6bea"), size: 38,),
                                       title: Column(
                                         children: [
                                           Align(alignment: Alignment.centerLeft,child:Padding(padding: const EdgeInsets.only(top: 11,
                                           left: 2),
                                             child: Opacity(
                                               opacity: 0.6,
                                               child: Text("Jam Masuk",style: GoogleFonts.lato(fontSize: 11,color: Colors.black,
                                                   fontWeight: FontWeight.bold)),
                                             ),),),
                                           Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(top: 5),
                                             child: Text("12:00",style: GoogleFonts.lato(fontSize: 22,color: Colors.black,
                                                 fontWeight: FontWeight.bold)),),)
                                         ],
                                       )
                                     ),
                                   ),


                                      Container(
                                        height: 70,
                                        width: 150,
                                        child:    ListTile(
                                            dense: true,
                                            leading: FaIcon(FontAwesomeIcons.clock, color: HexColor("#1c6bea"), size: 38,),
                                            title: Column(
                                              children: [
                                                Align(alignment: Alignment.centerLeft,child:Padding(padding: const EdgeInsets.only(top: 11,
                                                    left: 2),
                                                  child: Opacity(
                                                    opacity: 0.6,
                                                    child: Text("Jam Keluar",style: GoogleFonts.lato(fontSize: 11,color: Colors.black,
                                                        fontWeight: FontWeight.bold)),
                                                  ),),),
                                                Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(top: 5),
                                                  child: Text("17:50",style: GoogleFonts.lato(fontSize: 22,color: Colors.black,
                                                      fontWeight: FontWeight.bold)),),)
                                              ],
                                            )
                                        ),
                                      ),

                                    ],
                                  ),),
                              ]),
                            ]),
                          ],
                        )
                  ),



                ],
              )
            ),





          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Beranda'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Inbox'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_center),
              title: Text('Bantuan'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Akun'),
            ),
          ],
          // currentIndex: _selectedNavbar,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          //onTap: _changeSelectedNavBar,
        ),
      ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
  }
}