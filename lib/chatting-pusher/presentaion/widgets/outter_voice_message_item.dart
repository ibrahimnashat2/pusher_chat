import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pusher_chat/core/widget.dart';
import 'package:pusher_chat/core/widget/context.dart';
import 'package:pusher_chat/core/widget/padding.dart';

import '../../../core/colors.dart';
import '../../../core/widget/text.dart';
import 'inner_voice_message_item.dart';

class OutterVoiceMessageItem extends StatefulWidget {
  final String url;
  final String time;
  const OutterVoiceMessageItem({
    super.key,
    required this.url,
    required this.time,
  });

  @override
  State<OutterVoiceMessageItem> createState() => _OutterVoiceMessageItemState();
}

class _OutterVoiceMessageItemState extends State<OutterVoiceMessageItem> {
  @override
  void initState() {
    super.initState();
    init();
  }

  late StreamSubscription bufferedPositionStream;

  final _player = AudioPlayer();

  Future<void> init() async {
    await _player.setUrl(widget.url);
    bufferedPositionStream = _player.bufferedPositionStream.listen((event) {
      if (event.inSeconds == _player.duration!.inSeconds) {
        _player.pause();
        _player.seek(Duration.zero);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: context.w * 0.4,
              maxWidth: context.w * 0.65,
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsetsDirectional.only(bottom: 3.0),
            decoration: const BoxDecoration(
              color: Coolors.textFieldHintColor,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15.0),
                bottomEnd: Radius.circular(15.0),
                topStart: Radius.circular(15.0),
              ),
            ),
            child: Row(
              children: [
                StreamBuilder(
                  initialData: false,
                  stream: _player.playingStream,
                  builder: (context, state) {
                    return Icon(
                      state.data! ? Icons.pause : Icons.play_arrow,
                      color: Coolors.blackColor,
                      size: 25.0,
                    );
                  },
                ).addAction(onTap: playOrPause),
                Expanded(
                  child: StreamBuilder(
                    stream: _player.positionStream,
                    builder: (context, state) {
                      return LinearPercentIndicator(
                        isRTL: true,
                        barRadius: const Radius.circular(25),
                        percent: progress(state.data),
                        progressColor: Coolors.blackColor,
                      );
                    },
                  ),
                ),
                StreamBuilder(
                  initialData: Duration.zero,
                  stream: _player.durationStream,
                  builder: (context, state) {
                    return MText(
                      text: timeFormat(state.data),
                      fontSize: 10.0,
                      fontColor: Coolors.blackColor,
                    );
                  },
                ).addPadding(end: 12.0),
              ],
            ),
          ),
          MText(
            text: widget.time,
            fontColor: Coolors.blackColor,
            fontSize: 8.0,
          ).addPadding(bottom: 5.0)
        ],
      ),
    );
  }

  void playOrPause() {
    if (currentPlayer != null) {
      currentPlayer!.pause();
    }
    _startPlayOrPause();
  }

  void _startPlayOrPause() {
    if (_player.playing) {
      _player.pause();
      currentPlayer = null;
    } else {
      _player.play();
      currentPlayer = _player;
    }
  }

  int convert(int? value) => value ?? 0;

  double progress(Duration? data) {
    try {
      return convert(data?.inSeconds) / _player.duration!.inSeconds;
    } catch (e) {
      return 0;
    }
  }

  String timeFormat(Duration? data) {
    String format = '';
    dynamic sec = convert(data!.inSeconds).toDouble();
    dynamic min = sec / 60;
    sec = ((min - min.toInt()) * 60).toInt();
    min = min.toInt();
    //min
    if (min == 0) {
      format += '00:';
    } else if (min < 9) {
      format += '0$min:';
    } else {
      format += '$min:';
    }
    //sec
    if (sec == 0) {
      format += '00';
    } else if (sec < 9) {
      format += '0$sec';
    } else {
      format += '$sec:';
    }

    return format;
  }

  @override
  void dispose() {
    _player.dispose();
    bufferedPositionStream.cancel();
    super.dispose();
  }
}
