import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QuranAudio extends StatefulWidget {
  final List<NetworkImage> surahPages;
  final audioUrllink;
  const QuranAudio(
      {super.key, required this.audioUrllink, required this.surahPages});

  @override
  State<QuranAudio> createState() => _QuranAudioState();
}

class _QuranAudioState extends State<QuranAudio> {
  final player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  PlayerState audioStatus = PlayerState.paused;
  late PageController _pageController;
  Future<void> preloadImages() async {
    if (mounted) {
      for (var image in widget.surahPages) {
        try {
          await precacheImage(image, context);
        } catch (e) {
          return;
        }
      }
    }
  }

  Future setAudio() async {
    if (!mounted) return;
    player.setSourceUrl(widget.audioUrllink);

    playAudio();
  }

  Future<void> playAudio() async {
    if (!mounted) return;

    if (audioStatus == PlayerState.paused) {
      await player.play(UrlSource(widget.audioUrllink));
    } else if (audioStatus == PlayerState.playing) {
      player.pause();
    }
  }

  void pauseAudio() {
    if (!mounted) return;

    if (audioStatus == PlayerState.playing) {
      player.pause();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    preloadImages();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _pageController = PageController(initialPage: 0);
    });

    if (mounted) {
      player.onPlayerComplete.listen((event) {
        setState(() {
          position = Duration.zero;
          pauseAudio();
        });
      });
    }

    if (mounted) {
      player.onPlayerStateChanged.listen((state) {
        audioStatus = state;
      });
    }
    if (mounted) {
      player.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });
    }
    if (mounted) {
      player.onPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/bcgimg.png"),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: PageView.builder(
                reverse: true,
                controller: _pageController,
                itemBuilder: ((context, index) {
                  return Image(
                    image: widget.surahPages[index],
                  );
                }),
                itemCount: widget.surahPages.length,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                children: [
                  Slider(
                      activeColor: Colors.brown,
                      inactiveColor: Colors.brown[200],
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        if (mounted) {
                          final position = Duration(seconds: value.toInt());

                          await player.seek(position);

                          await player.resume();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          format(duration),
                          style: TextStyle(color: Colors.brown[700]),
                        ),
                        Text(
                          format((duration - position)),
                          style: TextStyle(color: Colors.brown[700]),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    radius: 35,
                    child: IconButton(
                      icon: Icon(
                        audioStatus == PlayerState.paused
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                      onPressed: () {
                        playAudio();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
