import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:provider/provider.dart';
import 'package:be_extc/utilities/car_data.dart';

class RecogniseSpeech {
  final BuildContext context;
  RecogniseSpeech({
    @required this.context,
  });

  stt.SpeechToText _speechToText;
  String text;

  void initSpeechRecognition() {
    _speechToText = stt.SpeechToText();
  }

  void listen() async {
    bool isListening =
        Provider.of<CarData>(context, listen: false).getListenStatus;
    if (!isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('$val'),
        onError: (val) => print('$val'),
      );
      if (available) {
        Provider.of<CarData>(context, listen: false)
            .updateListenStatus(status: true);
        _speechToText.listen(onResult: (val) {
          text = val.recognizedWords;
          text = capitalize(text);
          Provider.of<CarData>(context, listen: false).updateMessageText(text);
          Provider.of<CarData>(context, listen: false)
              .updateTextControllerText(text);
          Provider.of<CarData>(context, listen: false).updateVoiceStatus(true);
        });
      }
    } else {
      Provider.of<CarData>(context, listen: false)
          .updateListenStatus(status: false);
      _speechToText.stop();
    }
  }
}
