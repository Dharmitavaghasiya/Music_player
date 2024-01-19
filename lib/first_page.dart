import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/album_list.dart';
import 'package:media_player/artist_list.dart';
import 'package:media_player/controller.dart';
import 'package:media_player/full_screen.dart';
import 'package:media_player/play_list.dart';
import 'package:media_player/song_List.dart';
import 'package:text_scroll/text_scroll.dart';

void main() {
  runApp(MaterialApp(
    home: music_list(),
    debugShowCheckedModeBanner: false,
  ));
}

class music_list extends StatelessWidget {
  // TabController? tabController;
  controller c = Get.put(controller());

  // const music_list({super.key});
  List str = ["Find local songs", "Sort by", "Manage songs", "Settings"];
  static List str1 = ["one", "two", "three", "four", "five"];

  @override
  Widget build(BuildContext context) {
    c.get_check();
    return DefaultTabController(
      animationDuration: Duration(seconds: 1),
      initialIndex: 0,
      length: 4,
      child: SafeArea(
        minimum: EdgeInsets.only(top: 10),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: AppBar(
              flexibleSpace: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "MUSIC",
                      style:
                          TextStyle(fontSize: 40, color: Colors.red.shade900),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                print("search");
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.red.shade900,
                              )),
                          PopupMenuButton(
                            color: Colors.grey.shade800,
                            icon: Icon(
                              Icons.more_vert_outlined,
                              color: Colors.red.shade900,
                            ),
                            itemBuilder: (context) => str.map((e) {
                              int ind = str.indexOf(e);
                              return PopupMenuItem(
                                  value: ind,
                                  onTap: () {},
                                  child: Text(
                                    "${str[ind]}",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                  indicatorColor: Colors.red.shade900,
                  dividerColor: Colors.black,
                  // indicator: BoxDecoration(
                  //     // color: Colors.teal.shade200,
                  //     borderRadius: BorderRadius.circular(10)),
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.red.shade900,
                  tabs: [
                    Tab(
                      text: "Songs",
                    ),
                    Tab(
                      text: "Artists",
                    ),
                    Tab(
                      text: "Albums",
                    ),
                    Tab(
                      text: "Playlists",
                    ),
                  ]),
            ),
          ),
          // bottomNavigationBar: Column(children: [
          //
          //
          // ],),
          bottomNavigationBar:
              // Column(mainAxisSize: MainAxisSize.min,children: [
              //   BottomAppBar(color: Colors.black,child: Column(children: [
              //
              //   ]),),
              //
              // ],),

              Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomAppBar(
                color: Colors.black,
                child: Column(
                  children: [
                    SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red,
                          // activeTickMarkColor: Colors.deepOrange,
                          inactiveTrackColor: Colors.white10,
                          trackHeight: 1,

                          // thumbColor:Colors.blue,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0.0),
                        ),
                        child: Obx(() => Slider(
                              thumbColor: Colors.red,

                              // activeColor: Colors.red,
                              // inactiveColor: Colors.white10,
                              min: 0,
                              max: c.song_list.value.length > 0
                                  ? c.song_list.value[c.cur_ind.value].duration!
                                      .toDouble()
                                  : 0,
                              value: c.duration.value,
                              onChanged: (value) {},
                            ))),
                    ListTile(
                      onTap: () {
                        c.get_duration();
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return full_screen();
                        },));
                      },
                      leading: Image.network(
                        'https://t4.ftcdn.net/jpg/01/06/47/61/360_F_106476142_zMZkkTkhMeq0DIjV20oJI00e3QXLYIGN.jpg',
                        fit: BoxFit.fill,
                      ),
                      title: Obx(() => c.song_list.value.isNotEmpty
                          ? TextScroll(
                              "${c.song_list.value[c.cur_ind.value].title}",
                              intervalSpaces: 50,
                              velocity:
                                  Velocity(pixelsPerSecond: Offset(20, 20)),
                              style: TextStyle(color: Colors.white),
                            )
                          : Text("data")),
                      trailing: Obx(() => c.isplay.value
                          ? IconButton(
                              onPressed: () {
                                controller.player.pause();
                                c.isplay.value = !c.isplay.value;
                              },
                              icon: Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 30,
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
                                size: 30,
                              ))),
                    )
                  ],
                ),
              )
            ],
          ),

          body: TabBarView(children: [
            Center(child: one()),
            Center(child: artist_list()),
            Center(child: album_list()),
            Center(child: play_list())
          ]),
        ),
      ),
    );
  }
}
