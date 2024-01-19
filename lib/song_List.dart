import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class one extends StatefulWidget {
  const one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  @override
  Widget build(BuildContext context) {
    controller c = Get.put(controller());

    double Screen_height = MediaQuery.of(context).size.height;
    double Status_bar = MediaQuery.of(context).padding.top;
    double App_bar_height = kToolbarHeight;
    // Color red=  ;
    return Scaffold(
      body: FutureBuilder(
          future: c.get_song(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<SongModel> l = snapshot.data as List<SongModel>;
              return ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, index) {
                  return ListTile(onTap: () {
                    c.get_check();
                    c.isplay.value = true;
                    c.get_duration();
                    print(c.duration.value);

                    if(c.cur_ind.value==index)
                    {

                    }
                    else
                    {
                      c.cur_ind.value=index;
                      controller.player.play(
                          DeviceFileSource(c.song_list.value[c.cur_ind.value].data));

                    }
                  },
                    tileColor: Colors.black,
                    trailing: Wrap(
                      children: [
                        Obx(() => c.cur_ind.value == index && c.isplay.value
                            ? Image.asset(
                          "img/884a408310b28171aa1018f77dee2602.gif",
                          height: 40,
                          width: 40,
                        )
                            : Text(""))
                      ],
                    ),
                    title: Text(l[index].title,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      "${l[index].artist}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
