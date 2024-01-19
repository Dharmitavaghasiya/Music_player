import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class controller extends GetxController
{
    RxList<SongModel> song_list=RxList();
    RxList<ArtistModel>artist_list=RxList();
    RxList<AlbumModel>album_list=RxList();
    RxList<SongModel>getallalbum=RxList();
    RxList<FavoritesEntity> fav_list=RxList();

    static OnAudioQuery _audioQuery = OnAudioQuery();
    static AudioPlayer player=AudioPlayer();

    RxBool isplay=false.obs;
    RxBool fav= false.obs;
    RxInt cur_ind=0.obs;
    RxDouble duration=0.0.obs;
    RxDouble current=0.0.obs;



    get_song()
    async {
        song_list.value=await _audioQuery.querySongs();
        return song_list;
        // get_duration();
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
    getallsong(int albumid)
    async {
        getallalbum.value=await _audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumid);
        return getallalbum;
    }

    get_duration()
    {
        player.onPositionChanged.listen((Duration d) {
            duration.value=d.inMilliseconds.toDouble();
        });
    }

    get_fav()
    async {
        fav_list.value=await OnAudioRoom().queryFavorites();
        return fav_list;
    }

    get_check()
    async {
        fav.value=await OnAudioRoom().checkIn(RoomType.FAVORITES, song_list.value[cur_ind.value].id);
    }



    get_current()
    {
        player.onPositionChanged.listen((Duration  p){
            current.value= p.inMilliseconds.toDouble(); //get the current position of playing audio
        });


    }


}