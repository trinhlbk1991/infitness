import 'package:assets_audio_player/assets_audio_player.dart';

class AssetAudioUtils {
  final _assetsAudioPlayer = AssetsAudioPlayer();

  open(String path) async {
    _assetsAudioPlayer.open(Audio(path), autoStart: false);
  }

  play() async {
    if (!_assetsAudioPlayer.isPlaying.value) {
      _assetsAudioPlayer.play();
    }
  }

  pause() async {
    if (_assetsAudioPlayer.isPlaying.value) {
      _assetsAudioPlayer.pause();
    }
  }

  stop() async {
    if (_assetsAudioPlayer.isPlaying.value) {
      _assetsAudioPlayer.stop();
    }
  }
}
