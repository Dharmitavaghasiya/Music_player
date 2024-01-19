import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/album_page.dart';
import 'package:media_player/controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class album_list extends StatelessWidget {
  const album_list({super.key});

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      body: FutureBuilder(future:c.get_album(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
        {
          List<AlbumModel>l=snapshot.data as List<AlbumModel>;
          return Container(color: Colors.black,
            child: ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
              return ListTile(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return album_page(l[index]);
                },));
              },
                title: Text("${l[index].album}",style: TextStyle(color: Colors.white),),
                subtitle: Text("${l[index].numOfSongs}",style: TextStyle(color: Colors.white)),
                // subtitle: Text("${l[index].numberOfAlbums}"),
              );
            },),
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
