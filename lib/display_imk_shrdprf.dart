//import 'dart:html';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class displa_imksrdprf extends StatefulWidget {
  const displa_imksrdprf({Key? key}) : super(key: key);

  @override
  State<displa_imksrdprf> createState() => _displa_imksrdprfState();
}

class _displa_imksrdprfState extends State<displa_imksrdprf> {
  String? imagedata;

  void initState() {
    super.initState();
    displaydata();
  }

  displaydata() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String? data = await share.getString("image");
    setState(() {
      imagedata = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("images"),
      ),
      body: Center(
          child: Container(
        decoration: BoxDecoration(color: Colors.red,
            image: imagedata != null
                ? DecorationImage(image:  FileImage(File(imagedata!),),fit:BoxFit.cover)
                : null),
      )),
    );
  }
}
