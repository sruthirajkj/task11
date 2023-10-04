import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display_imk_shrdprf.dart';

class impk_shrdpf extends StatefulWidget {
  const impk_shrdpf({Key? key}) : super(key: key);

  @override
  State<impk_shrdpf> createState() => _impk_shrdpfState();
}

class _impk_shrdpfState extends State<impk_shrdpf> {
  var img;

  File? pick;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
          child: ElevatedButton(
            onPressed: () async {
              ImagePicker pickimage = await ImagePicker();
              XFile? picked =
                  await pickimage.pickImage(source: ImageSource.camera);
              if (picked != null) {
                SharedPreferences sharedprf =
                    await SharedPreferences.getInstance();
                img = sharedprf.setString("image", picked.path);
                print(img);
              } else {
                print("not selected");
              }
            },
            child: Text("click"),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return displa_imksrdprf();
              }));
            },
            child: Text("ok"))
      ]),
    );
  }
}
