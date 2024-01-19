// import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/controller.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:text_scroll/text_scroll.dart';

void main() {
  runApp(MaterialApp(
    home: full_screen(),
    debugShowCheckedModeBanner: false,
  ));
}

class full_screen extends StatelessWidget {
  // const full_screen({super.key});
  controller c = Get.put(controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.black54),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("", textAlign: TextAlign.center),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 3),

                  Obx(
                    () => Flexible(
                      child: TextScroll(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        '${c.song_list.value[c.cur_ind.value].title} ',
                        intervalSpaces: 50,
                        velocity: Velocity(pixelsPerSecond: Offset(50, 20)),
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  // Expanded(
                  //   child: SizedBox(),
                  // ),
                ],
              ),
              // Text(""),
              // Text(""),
              Image.asset(
                alignment: Alignment.center,
                "img/wave-unscreen.gif",
                height: 450,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Obx(
                () => SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue.shade500,
                      // activeTickMarkColor: Colors.deepOrange,
                      inactiveTrackColor: Colors.grey,
                      trackHeight: 2,

                      // thumbColor:Colors.blue,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 3.0),
                    ),
                    child: Slider(
                      thumbColor: Colors.blue.shade500,

                      // activeColor: Colors.red,
                      // inactiveColor: Colors.white10,
                      min: 0,
                      max: c.song_list.value.length > 0
                          ? c.song_list.value[c.cur_ind.value].duration!
                              .toDouble()
                          : 0,
                      value: c.duration.value,
                      onChanged: (value) {},
                    )),
              ),

              Row(
                children: [
                  Obx(() => c.fav.value
                      ? IconButton(
                          onPressed: () async {
                            bool deleteFromResult =
                                await OnAudioRoom().deleteFrom(
                              RoomType.FAVORITES,
                              c.song_list.value[c.cur_ind.value].id,
                              //playlistKey,
                            );
                            c.get_check();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ))
                      : IconButton(
                          onPressed: () async {
                            int? addToResult = await OnAudioRoom().addTo(
                              RoomType.FAVORITES,
                              c.song_list.value[c.cur_ind.value].getMap
                                  .toFavoritesEntity(),
                            );
                            c.get_check();
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (c.cur_ind > 0) {
                          c.cur_ind--;
                          c.isplay.value = true;
                          controller.player.play(DeviceFileSource(
                              c.song_list.value[c.cur_ind.value].data));
                        }
                      },
                      icon: Icon(
                        Icons.skip_previous_outlined,
                        color: Colors.white,
                      )),
                  Obx(() => c.isplay.value
                      ? IconButton(
                          onPressed: () {
                            controller.player.pause();
                            c.isplay.value = !c.isplay.value;
                          },
                          icon: Icon(
                            Icons.pause,
                            color: Colors.white,
                          ))
                      : IconButton(
                          onPressed: () {
                            c.isplay.value = !c.isplay.value;
                            controller.player.play(DeviceFileSource(
                                c.song_list.value[c.cur_ind.value].data));
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ))),
                  IconButton(
                      onPressed: () {
                        if (c.cur_ind < c.song_list.length - 1) {
                          c.cur_ind++;
                          c.isplay.value = true;
                          controller.player.play(DeviceFileSource(
                              c.song_list.value[c.cur_ind.value].data));
                        }
                      },
                      icon: Icon(
                        Icons.skip_next_outlined,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(20),
          color: Colors.transparent,
        ),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              // Color(0xff680001),
              // Color(0xff2e2321),
              Colors.black,
              Colors.black,
              // Color(0xff2e2321),
              // Colors.black
            ])),
      ),
    );
  }
}

