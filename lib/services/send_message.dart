import 'package:be_extc/models/message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:be_extc/services/recognise_message.dart';

class SendMessage {
  final BuildContext context;
  SendMessage({@required this.context});

  RecogniseMessage _recogniseMessage;

  void sendMessage(
      {@required String messageText,
      @required bool isVoice,
      @required bool isOffline,
      @required String sender}) {
    _recogniseMessage = RecogniseMessage(context: context);

    Provider.of<CarData>(context, listen: false).addMessage(
      MessageBubble(
        isOffline: true,
        messageText: messageText,
        sender: 'ME',
        isMe: true,
        isVoice: isVoice,
        time: formatTimestamp(DateTime.now()),
      ),
    );
    _recogniseMessage.recogniseMessage(input: messageText.toLowerCase());
  }
}
