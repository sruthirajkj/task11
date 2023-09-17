import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  Future<List<dynamic>?> employee() async {
    final url = "https://dummy.restapiexample.com/api/v1/employees";
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(response.body);
      if (bool is List){
      return body;}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: employee(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!["data"].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(snapshot.data!["data"][index]["id"].toString()),
                            subtitle: Column(
                              children: [Text(snapshot.data!["data"][index]["employee_name"].toString()),
                                Text(snapshot.data![index]["data"]["employee_salary"].toString()),
                                Text(snapshot.data![index]["data"]["employee_age"].toString())],
                            ));
                      }),
                );
              } else {
                return Text("");
              }
            }),
      ),
    );
  }
}
