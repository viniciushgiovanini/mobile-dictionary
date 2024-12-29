import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String urlaudio;

  const AudioPlayerScreen(this.urlaudio, {super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  late String audioUrl;

  @override
  void initState() {
    audioUrl = widget.urlaudio;
    super.initState();
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    try {
      if (isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(audioUrl));
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    } catch (e) {
      debugPrint("Erro ao reproduzir o audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 25),
            onPressed: _togglePlayPause,
          ),
          SizedBox(height: 20),
          Text(
            isPlaying ? "Playing..." : "Paused",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
