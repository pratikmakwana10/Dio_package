import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      highContrastDarkTheme: ThemeData.dark(),
    );
  }
}

/*class User {
  final int id;
  final int userId;
  final String title;
  final String body;

  User({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
}*/

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  deleteData() async {
    final dio = Dio();
    // var response =
    //     await dio.get(url);
    var res = await dio.delete("${url}users/2");
    //  print("Get API Response = ${response.statusCode}");
    if (kDebugMode) {
      print("Delete API StatusCode = ${res.statusCode}");
    }
  }

  putRequest() async {
    final dio = Dio();
    var response = await dio.put(url, data: {
      'userId': 1,
      'id': 5,
      'title': 'Jack the developer',
      'body': 'Nothing is Accomplished without sacrifice'
    });
    if (kDebugMode) {
      print(response);
    }
  }

  postRequest() async {
    final dio = Dio();

    var response = await dio.post("${url}register",
        data: {"email": "eve.holt@reqres.in", "password": "pistol"});
    if (kDebugMode) {
      print("Response of Post = $response");
    }
  }

  getRequest() async {
    String url = "https://reqres.in/api/users?page=2";
    //String urlc = "https://reqres.in/api/users/2";
    final response = await Dio().get(url);
    // print(response);
    // var responseData = json.decode(response.data.toString());
    // print(responseData);
    var decodedJson = UserListModel.fromJson(response.data);
    if (kDebugMode) {
      print("Response Get URl = ${response.statusCode}");
    }

    List<User> users = [];
    users.addAll(decodedJson.data!);
    // for (User  sUser in decodedJson.data??[]) {
    //   // User user =
    //   // User(
    //   //   id: sUser.id,
    //   //   firstName: sUser.firstName,
    //   //   lastName: sUser.lastName,
    //   //    email: sUser.email,
    //   //   avatar: sUser.avatar
    //   // );
    //   // print(user);
    //   users.add(sUser);
    //   /*UserListModel(
    //       data: sUser["data"],
    //       page: sUser["page"],
    //       perPage: sUser["perPage"],
    //       support: sUser["support"],
    //       total: sUser["total"],
    //       totalPages: sUser["totalPages"]);*/
    //
    //
    //   /*  List<User> users = [];
    // for (var singleUser in response.data) {
    //   User user = User(
    //       id: singleUser["id"],
    //       userId: singleUser["userId"],
    //       title: singleUser["title"],
    //       body: singleUser["body"]);
    //   users.add(user);*/
    //   /* User user = User(
    //       id: singleUser["id"],
    //       userId: singleUser["userId"],
    //       title: singleUser["title"],
    //       body: singleUser["body"]);
    //   users.add(user);*/
    // }
    // print(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: const Text("Dio "),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  getRequest();
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: getRequest(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) => Card(
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.grey.shade600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    snapshot.data[index].avatar,
                                    scale: 1,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      buildText(
                                          snapshot.data[index].id.toString(),
                                          index,
                                          15),
                                      buildText(snapshot.data[index].firstName,
                                          index, 20),
                                      buildText(snapshot.data[index].lastName,
                                          index, 20),
                                      buildText(snapshot.data[index].email,
                                          index, 12),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    postRequest();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 50,
                    width: 50,
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    putRequest();
                  },
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Text("Put",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () => deleteData(),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    height: 50,
                    width: 70,
                    child: const Text("Delete",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Text buildText(String text, int index, double font) {
    return Text(
      text,
      style: TextStyle(
          fontSize: font, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
