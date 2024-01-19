import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_player/alrtist_page.dart';
import 'package:media_player/controller.dart';
import 'package:media_player/song_List.dart';
// import 'package:media_player/data/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class artist_list extends StatelessWidget {
  const artist_list({super.key});

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(backgroundColor: Colors.black,
      body: FutureBuilder(future:c.get_artist(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<ArtistModel> l=snapshot.data as List<ArtistModel>;
            return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
              return ListTile(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return one();
                },));
              },tileColor: Colors.black,
                title: Text("${l[index].artist}",style: TextStyle(color: Colors.white),),
                subtitle: Text("${l[index].numberOfTracks}",style: TextStyle(color: Colors.white)),
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
