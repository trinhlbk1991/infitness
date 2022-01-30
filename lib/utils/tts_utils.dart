import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:infitness/utils/log.dart';

class TtsUtils {
  static const _TAG = 'TtsUtils';

  late FlutterTts _flutterTts;
  late AudioSession _audioSession;

  init() {
    _flutterTts = FlutterTts();
    if (isAndroid) {
      _getDefaultEngine();
    }
    _flutterTts.setErrorHandler((msg) => Log.e(_TAG, 'TTS error: $msg'));
    _setupAudioSession();
  }

  stop() {
    _flutterTts.stop();
  }

  speak(String message) async {
    if (await _audioSession.setActive(true)) {
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.speak(message);
    } else {
      Log.e(_TAG, 'The request was denied and the app should not play audio');
    }
  }

  Future _getDefaultEngine() async {
    var engine = await _flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  void _setupAudioSession() {
    AudioSession.instance.then((value) {
      _audioSession = value;
      _audioSession.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.interruptSpokenAudioAndMixWithOthers,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy:
            AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));
    });
  }

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWeb => kIsWeb;
}
