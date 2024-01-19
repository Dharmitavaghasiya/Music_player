import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/controller.dart';
import 'package:media_player/full_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/album_model.dart';
import 'package:text_scroll/text_scroll.dart';

class album_page extends StatelessWidget {

controller c=Get.put(controller());
AlbumModel l;
  album_page(this.l);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
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
      body:FutureBuilder(future: c.getallsong(l.id),builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done)
      {
        List<SongModel> l=snapshot.data as List<SongModel>;
        return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
          return ListTile(onTap: () {
            c.isplay.value=true;

            for(int i=0;i<c.song_list.value.length;i++)
            {
              if(c.song_list.value[i].id==l[index].id)
              {
                  if(i==c.cur_ind.value){

                  }
                  else
                  {
                    c.cur_ind.value=i;
                    controller.player.play(
                        DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                  }
              }

            }
          },title: Text("${l[index].title}",maxLines: 2,style: TextStyle(color: Colors.white),),);
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

