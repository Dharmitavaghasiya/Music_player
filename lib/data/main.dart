import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'first.dart';

void main()
{
    runApp(MaterialApp(home: splash(),));
}
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    permission();

    Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
           return first();
        },));
    },);
  }
  permission()
  async {


    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child: Text("Music Player",style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
