// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class home extends StatefulWidget {
//   const home({Key? key}) : super(key: key);
//
//   @override
//   State<home> createState() => _homeState();
// }
//
// class _homeState extends State<home> {
//   Future<dynamic> homeget() async {
//     final url =
//         "https://www.petroinfotech.com/PetroHSE/api/Dashboard/GetHomePage?companyCode=1 &userId=610";
//     var response = await get(Uri.parse(url));
//     // headers - {
//     //   "Authorization":"Bearer ""+ attach token get from validate login api",
//     //   "CompanyCode":1,
//     //   "UserId": id get from Validate Login api ,
//     //   "appType":"MOB",
//     //   "content-type":"application/json",
//     //   "accept" : "application/json",
//     // }
//     if (response.statusCode == 200) {
//       var body = jsonDecode(response.body);
//       print(body);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//             future: homeget(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasData) {
//                 return Expanded(
//                   child: ListView.builder(itemCount: snapshot.data!["dtContent"].length,
//                       itemBuilder: (context, index) {
//                     return Column(children: [
//                       Text(snapshot.data!["dtContent"][index]["Category"].toString()),
//                       Text(snapshot.data!["dtContent"][index]["ContentType"].toString()),
//                       Text(snapshot.data!["dtContent"][index]["ContentId"].toString()),
//                       // Text(snapshot.data!["dtContent"][index]["ContentId"].toString()),
//                       // Text(snapshot.data!["dtContent"][index]["ContentId"].toString()),
//                       // Text(snapshot.data!["dtContent"][index]["ContentId"].toString()),
//
//                     ]);
//                   }),
//                 );
//               } else
//                 return Text("no data");
//             }),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }
 // String ?authToken ;
  int companyCode = 1;
  int userId = 610;



  Future<Map<String, dynamic>> fetchData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    final String?authToken= sharedPrefs.getString('auth_token');
    if (authToken == null) {
      // Handle the case where the token is null, e.g., show an error message or navigate to login.
      return <String, dynamic>{};
    }
    final apiUrl = Uri.parse('https://www.petroinfotech.com/PetroHSE/api/Dashboard/GetHomePage?companyCode=$companyCode&userId=$userId');
    final headers = {
      'Authorization': 'Bearer $authToken',
      'CompanyCode': companyCode.toString(),
      'UserId': userId.toString(),
      'appType': 'MOB',
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final response = await http.get(
      apiUrl,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return data;

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  appBar: AppBar(
      title: Text('Home Page'),
    ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(), // Call the function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<dynamic> dtContent = snapshot.data!['dtContent'];

            return ListView.builder(
              itemCount: dtContent.length,
              itemBuilder: (context, index) {
                final item = dtContent[index];
                return ListTile(
                  title: Text(item["Category"].toString()),
                  subtitle: Text(item["ContentType"].toString()),
                  // You can add more data fields to display
                );
              },
            );

          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
