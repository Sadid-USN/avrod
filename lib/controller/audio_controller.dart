import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../screens/text_screen.dart';

class AudioController extends GetxController with GetTickerProviderStateMixin {
  int selectedIndex = 0;

  // AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  final AnimateIconController copyController = AnimateIconController();
  final AnimateIconController controller = AnimateIconController();
  final AnimateIconController buttonController = AnimateIconController();
  final AnimateIconController refreshController = AnimateIconController();

  late final List<AudioPlayer> _audioPlayers;


  

  getAudioPlayers(int trackCount) {
    _audioPlayers = List.generate(trackCount, (_) => AudioPlayer());
  }

  bool isPlaying = false;
  String? currentUrl;

  late final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  List<AudioPlayer> get audioPlayers => _audioPlayers;

  int randomNumber = Random().nextInt(114) + 1;

  void onTapBar(int index) {
    selectedIndex = index;
    _audioPlayer.stop();

    update();
  }

  Stream<PositioneData> get positioneDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositioneData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (positione, bufferedPosition, duration) => PositioneData(
                positione,
                bufferedPosition,
                duration ?? Duration.zero,
              ));

  void playAudio({
    required String url,
    required String id,
    required String album,
    required String title,
    required imgUrl,
  }) {
    _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: id,
          album: album,
          title: title,
          artUri: Uri.parse(imgUrl),
        ),
      ),
    );
      
    _audioPlayer.play();

    update();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();

    super.dispose();
  }

  List<InfoData> listInfo = [
    InfoData(
      id: "1",
      audioUrl: 'https://s5.radio.co/sdaff9bd16/listen',
      image: 'assets/icons/iconavrod.png',
      name: 'furqan-radio',
      subtitle: '24/7',
    ),
    InfoData(
        id: "2",
        audioUrl:
            'https://download.quranicaudio.com/qdc/siddiq_minshawi/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/7/mohamed-siddiq-el-minshawi-profile.jpeg?v=1',
        name: 'Mohamed Siddiq',
        subtitle: 'al-Minshawi'),
    InfoData(
        id: "3",
        audioUrl:
            'https://download.quranicaudio.com/qdc/khalil_al_husary/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/5/mahmoud-khalil-al-hussary-profile.png?v=1',
        name: 'Mahmoud Khalil',
        subtitle: 'Al-Husary'),
    InfoData(
        id: "4",
        audioUrl:
            'https://download.quranicaudio.com/qdc/abdul_baset/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/1/abdelbasset-profile.jpeg?v=1',
        name: 'AbdulBaset',
        subtitle: 'AbdulSamad'),
    InfoData(
        id: "5",
        audioUrl:
            'https://download.quranicaudio.com/qdc/mishari_al_afasy/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/6/mishary-rashid-alafasy-profile.jpeg?v=1',
        name: 'Mishari Rashid',
        subtitle: 'al-`Afasy'),
    InfoData(
        id: "6",
        audioUrl:
            'https://download.quranicaudio.com/qdc/abu_bakr_shatri/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/3/abu-bakr-al-shatri-pofile.jpeg?v=1',
        name: 'Abu Bakr',
        subtitle: 'al-Shatri'),
    InfoData(
        id: "7",
        audioUrl:
            'https://download.quranicaudio.com/qdc/khalifah_taniji/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/11/khalifa-al-tunaiji-profile.jpeg?v=1',
        name: ' Khalifa Musabah',
        subtitle: 'Al-Tunaiji'),
    InfoData(
        id: "8",
        audioUrl:
            'https://download.quranicaudio.com/qdc/hani_ar_rifai/murattal/${Random().nextInt(114) + 1}.mp3',
        image: 'https://static.qurancdn.com/images/reciters/4/hani-ar-rifai-profile.jpeg?v=1',
        name: 'Sheikh Hani',
        subtitle: 'ar-Rifai'),
  ];
  bool onRefresh = false;
  void refreshAudioUrls() {
    for (int i = 0; i < listInfo.length; i++) {
      if (i != 0) {
        listInfo[i].audioUrl =
            'https://download.quranicaudio.com/qdc/siddiq_minshawi/murattal/${Random().nextInt(114) + 1}.mp3';
      }
    }

    onRefresh = true;
    update();
  }
}

class InfoData {
  String id;
  String image;
  String audioUrl;
  String name;
  String subtitle;
  InfoData(
      {required this.id,
      required this.image,
      required this.name,
      required this.subtitle,
      required this.audioUrl});
}
