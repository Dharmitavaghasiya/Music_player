import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/data/controller.dart';
// import 'package:mymusic_app/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class album extends StatefulWidget {
  const album({super.key});

  @override
  State<album> createState() => _albumState();
}

class _albumState extends State<album> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      body: FutureBuilder(future: c.get_album(),builder: (context, snapshot) {
         if(snapshot.connectionState==ConnectionState.done){
           
           List<AlbumModel>l=snapshot.data as List<AlbumModel>;
             return ListView.builder(
               itemCount: l.length,
               itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${l[index].album}"),
                );
             },);
         }
         else{
            return CircularProgressIndicator();
         }
      },),
    );
  }
}
