import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:media_player/data/controller.dart';
// import 'package:mymusic_app/controller.dart';

class fullscreen extends StatefulWidget {
  const fullscreen({super.key});

  @override
  State<fullscreen> createState() => _fullscreenState();
}

class _fullscreenState extends State<fullscreen> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                child: Icon(Icons.music_note),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(child: Obx(() => Text("${c.song_list.value[c.cur_ind.value].title}")))
            ],
          ),
          Row(
            children: [
            Expanded(child:   Obx(() => Slider(
              min: 0,
              max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
              value: c.duration.value, onChanged: (value) {

            },)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {

                if(c.cur_ind>0)

                  {
                      c.cur_ind--;
                      c.isplay.value=true;
                      controller.player.play(
                          DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                  }

              }, icon: Icon(Icons.skip_previous_outlined)),
              Obx(() => c.isplay.value?IconButton(onPressed: () {
                controller.player.pause();
                c.isplay.value=!c.isplay.value;
              }, icon: Icon(Icons.pause)):IconButton(onPressed: () {
                c.isplay.value=!c.isplay.value;
                controller.player.play(
                    DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
              }, icon: Icon(Icons.play_arrow))),
              IconButton(onPressed: () {

                if(c.cur_ind<c.song_list.length-1)
                  {
                    c.cur_ind++;
                    c.isplay.value=true;
                    controller.player.play(
                        DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                  }

              }, icon: Icon(Icons.skip_next_outlined)),
            ],
          )
        ],
      ),
    );
  }
}
