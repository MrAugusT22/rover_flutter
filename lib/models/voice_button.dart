import 'package:be_extc/models/blob.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/models/message_bubble.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:be_extc/services/recognise_speech.dart';
import 'package:be_extc/services/send_message.dart';

class VoiceButton extends StatefulWidget {
  static const String id = 'VoiceButton';

  final Function sendState;
  final TextEditingController textEditingController;

  VoiceButton({@required this.textEditingController, @required this.sendState});

  @override
  _VoiceButtonState createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton>
    with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  AnimationController _rotationController;
  AnimationController _scaleController;

  String messageText;
  RecogniseSpeech _recogniseSpeech;
  SendMessage _sendMessage;

  double _rotation = 0;
  double _scale = 0.25;
  bool isPlaying = false;

  String state = '';

  bool micEnabled = false;
  bool isVoice = false;
  bool isListening = false;

  bool hl;
  bool autoMode;
  String _dist;
  bool _isDist;

  bool tapped = false;

  @override
  void initState() {
    // TODO: implement initState
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration);
    _rotationController.addListener(() {
      setState(() {
        _updateRotation();
      });
    });
    _rotationController.repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration);
    _scaleController.addListener(() {
      setState(() {
        _updateScale();
      });
    });

    _recogniseSpeech = RecogniseSpeech(context: context);
    _recogniseSpeech.initSpeechRecognition();
    _sendMessage = SendMessage(context: context);

    super.initState();
  }

  double pi = 22 / 7;

  void _updateRotation() => _rotation = _rotationController.value * 1.5 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  void animate() {
    _scale = _scale == 1 ? 0.25 : 1;
    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
  }

  void initMessageStream({@required CarData carData}) {
    isVoice = carData.getVoiceStatus;
    isListening = carData.getListenStatus;
    messageText = carData.getMessageText;
    hl = carData.getHeadlightToggle;
    autoMode = carData.getMode;
  }

  void addMessage({@required CarData carData}) {
    hl = carData.getHeadlightToggle;

    Map<String, String> move = {
      'f': 'forward',
      'b': 'backward',
      'l': 'left',
      'r': 'right',
      's': '/Stop',
    };
    String m = carData.getMovement;
    if (m == 'e') {
      carData.addMessage(MessageBubble(
        messageText: '${nonMovement[Random().nextInt(nonMovement.length)]}',
        isVoice: false,
        sender: 'rov3R',
        isMe: false,
        time: formatTimestamp(DateTime.now()),
      ));
    } else {
      if (m == 'h1' || m == 'h2') {
        carData.addMessage(MessageBubble(
          messageText: 'Headlights ${hl ? 'On' : 'Off'}',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 'h') {
        carData.addMessage(MessageBubble(
          messageText: '${move[m]}',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 's') {
        carData.addMessage(MessageBubble(
          messageText: 'Stopped myself',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 'u') {
        carData.addMessage(MessageBubble(
          messageText: 'Turning around',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 're') {
        carData.addMessage(MessageBubble(
          messageText: 'Coming back Chief',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 'res') {
        carData.addMessage(MessageBubble(
          messageText: 'Reset all values Chief',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 'a') {
        carData.addMessage(MessageBubble(
          messageText:
              'Thank you for making me independent. Finding my on way Chief! 😉',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else if (m == 'c') {
        carData.addMessage(MessageBubble(
          messageText: 'Following you Chief since start. 😉',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      } else {
        carData.addMessage(MessageBubble(
          messageText: 'Moving ${move[m]} ${_isDist ? '$_dist units' : ''}',
          isVoice: false,
          sender: 'rov3R',
          isMe: false,
          time: formatTimestamp(DateTime.now()),
        ));
      }
    }
  }

  void sendMessage({@required CarData carData}) {
    setState(() {
      print(carData.getState);
      if (widget.textEditingController.text.isEmpty) {
        animate();
        _recogniseSpeech.listen();
        micEnabled = false;
        tapped = false;
        return;
      } else {
        if (messageText.trim() == '') {
          return;
        }
        isVoice = carData.getListenStatus;
        if (isVoice) {
          animate();
        }
        carData.updateListenStatus(status: false);
        _sendMessage.sendMessage(
            messageText: messageText,
            isVoice: isVoice,
            isOffline: true,
            sender: 'ME');
        carData.updateMessageText('');
        widget.textEditingController.clear();
        if (carData.getMovement != 're') {
          getData(carData);
          addMessage(carData: carData);
        }
        if (carData.getMovement == 're') {
          recall(carData);
          addMessage(carData: carData);
        }
      }
      tapped = false;
    });
  }

  void getData(CarData carData) {
    _isDist = carData.getDistanceToggle;
    _dist = carData.getDistance;
    state = carData.getState;

    if (carData.getMovement != 'e') {
      widget.sendState(state);
      print('message sent');
    }
  }

  void recall(CarData carData) {
    print('recalled');
    List states = carData.getRecallMovementState;
    states.forEach((element) {
      state = element;
      widget.sendState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarData>(
      builder: (context, carData, child) {
        initMessageStream(carData: carData);
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Blob(
                  color: Color(0xff0092ff), scale: _scale, rotation: _rotation),
              Blob(
                  color: Color(0xff4ac7b7),
                  scale: _scale,
                  rotation: _rotation * 2 - 30),
              Blob(
                  color: Color(0xffa4a6f6),
                  scale: _scale,
                  rotation: _rotation * 3 - 45),
              Blob(
                  color: Color(0xffffffff),
                  scale: _scale,
                  rotation: _rotation * 4 - 45),
              Material(
                elevation: 5,
                shape: CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: tapped ? Colors.blue : Colors.transparent,
                        blurRadius: 10,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  constraints: BoxConstraints.tightFor(width: 56, height: 56),
                  child: GestureDetector(
                    onTap: () {
                      tapped = true;
                      sendMessage(carData: carData);
                    },
                    child: widget.textEditingController.text.isEmpty
                        ? Icon(Icons.mic_rounded, color: Colors.white, size: 40)
                        : Icon(Icons.keyboard_arrow_right_rounded,
                            color: Colors.white, size: 40),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
