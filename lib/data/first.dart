import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/data/controller.dart';
import 'package:media_player/data/play_list.dart';
import 'package:media_player/data/song_list.dart';
// import 'package:mymusic_app/controller.dart';
// import 'package:mymusic_app/play_list.dart';
// import 'package:mymusic_app/song_list.dart';

import 'album_list.dart';
import 'artist_list.dart';

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return DefaultTabController(length: 4, child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(tabs: [
          Tab(
          child: Text("Songs"),
        ),
          Tab(
            child: Text("Playlist"),
          ),
          Tab(
            child: Text("Aritis"),
          ),
          Tab(
            child: Text("Album"),
          )
        ]),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SliderTheme(data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.yellow,
            // activeTickMarkColor: Colors.deepOrange,
            trackHeight: 2
          ), child: Obx(() => Slider(
            min: 0,
            max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
            value: c.duration.value, onChanged: (value) {

          },))),
          ListTile(
            title: Obx(() => c.song_list.value.isNotEmpty?Text("${c.song_list.value[c.cur_ind.value].title}"):Text("data")),
            trailing: Obx(() => c.isplay.value?IconButton(onPressed: () {
                   controller.player.pause();
                   c.isplay.value=!c.isplay.value;
            }, icon: Icon(Icons.pause)):IconButton(onPressed: () {
              c.isplay.value=!c.isplay.value;
              controller.player.play(
                  DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
            }, icon: Icon(Icons.play_arrow))),
          )
        ],
      ),
      body: TabBarView(children: [
        song_list(),
        play_list(),
        artist(),
        album(),
      ]),
    ));
  }
}
