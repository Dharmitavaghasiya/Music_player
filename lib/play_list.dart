// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/controller.dart';
import 'package:media_player/fav_fullscreen.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';

class play_list extends StatelessWidget {
  const play_list({super.key});

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      body: FutureBuilder(future: c.get_fav(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<FavoritesEntity> list=snapshot.data as List<FavoritesEntity>;
            return ListTile(onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return fav_fullscreen();
            },));
            },
              title: Text("song"),
              subtitle: Text("${list.length}"),
            );
          }
        else
          {
            return CircularProgressIndicator();
          }
      },),
    );
  }
}
