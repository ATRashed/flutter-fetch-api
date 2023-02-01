import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var users = [];
  getData() async {
    var url = Uri.parse('https://randomuser.me/api/?results=20');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        users = data['results'];
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Demo App'),
        ),
        body: getBody(),
        drawer: Drawer(),
      ),
    );
  }

  Widget getBody() {
    List nums = [1, 2, 3];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        var user = users[index];
        var name = user["name"]['title'] +
            ' ' +
            user["name"]['first'] +
            ' ' +
            user["name"]['last'];
        return Card(
          child: ListTile(
            title: Text(name),
          ),
        );
      },
    );
  }
}
