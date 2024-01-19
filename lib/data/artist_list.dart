import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/data/controller.dart';
// import 'package:mymusic_app/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class artist extends StatelessWidget {
  const artist({super.key});

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      body: FutureBuilder(future: c.get_artist(),builder: (context, snapshot) {
         if(snapshot.connectionState==ConnectionState.done){
           
           List<ArtistModel>l=snapshot.data as List<ArtistModel>;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
               return ListTile(
                 title: Text("${l[index].artist}"),
                 subtitle: Text("${l[index].numberOfAlbums}"),
               );
            },);
         }
         else
           {
              return CircularProgressIndicator();
           }
      },),
    );
  }
}
