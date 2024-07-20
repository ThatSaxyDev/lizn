// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({
    super.key,
    required this.path,
  });

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.path);
  }

  Future<void> playPause() async {
    if (!playerController.playerState.isPlaying) {
      await playerController.startPlayer(
        finishMode: FinishMode.stop,
      );
    } else {
      await playerController.pausePlayer();
    }

    setState(() {});
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playPause,
          icon: Icon(
            playerController.playerState.isPlaying
                ? PhosphorIconsBold.pause
                : PhosphorIconsBold.play,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: Size(double.infinity, 100.h),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.gradient2,
              spacing: 7,
              // showSeekLine: false,
            ),
          ),
        ),
      ],
    );
  }
}
