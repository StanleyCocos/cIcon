import 'package:cicon/cicon.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [

            Padding(padding: EdgeInsets.only(top: 20)),

            GestureDetector(
              onTap: (){
                Cicon.setIcon(name: "icon2");
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("icon2"),
              ),
            ),


            Padding(padding: EdgeInsets.only(top: 20)),

            GestureDetector(
              onTap: (){
                Cicon.setIcon(name: "icon3");
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("icon3"),
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 20)),

            GestureDetector(
              onTap: (){
                Cicon.restoreIcon();
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("恢复成默认图标"),
              ),
            ),


            Padding(padding: EdgeInsets.only(top: 20)),
            GestureDetector(
              onTap: () async{
                var name = await Cicon.currentIcon;
                print(name);
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                color: Colors.red,
                child: Text("获取当前图标"),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
