 import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class controller extends GetxController{

  RxList<SongModel>song_list=RxList();
  RxList<ArtistModel>artist_list=RxList();
  RxList<AlbumModel>album_list=RxList();
  static OnAudioQuery _audioQuery = OnAudioQuery();
  static AudioPlayer player=AudioPlayer();
  RxBool isplay=false.obs;
  RxDouble duration=0.0.obs;


  RxInt cur_ind=0.obs;

    get_song()
    async {

           song_list.value= await _audioQuery.querySongs();
           print(song_list);
           return song_list;
    }
  get_artist()
  async {

    artist_list.value= await _audioQuery.queryArtists();
    print(song_list);
    return artist_list;
  }
  get_album()
  async {

    album_list.value= await _audioQuery.queryAlbums();
    print(song_list);
    return album_list;
  }

    get_duration()
    {
          player.onPositionChanged.listen((Duration d) {
              duration.value=d.inMilliseconds.toDouble();
          });
    }





}