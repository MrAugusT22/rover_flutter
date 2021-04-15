import 'package:be_extc/models/voice_button.dart';
import 'package:be_extc/screen_pages/joystick.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:be_extc/utilities/dialog_box.dart';

class ChatScreen extends StatefulWidget {
  final Function sendState;
  ChatScreen({@required this.sendState});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController;
  String messageText;

  bool micEnabled = false;
  bool isVoice = false;
  bool isListening = false;
  bool isTextFieldEmpty = true;
  bool isWifiSelected;

  String state = '';

  bool hl;
  bool autoMode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initMessageStream({@required CarData messageStream}) {
    isVoice = messageStream.getVoiceStatus;
    isListening = messageStream.getListenStatus;
    messageText = messageStream.getMessageText;
    _textEditingController = messageStream.textController;
    isTextFieldEmpty = _textEditingController.text.isEmpty;
    isWifiSelected = messageStream.getConnectionStatus;
    hl = messageStream.getHeadlightToggle;
    autoMode = messageStream.getMode;
  }

  void recall(CarData carData) {
    print('recalled');
    List states = carData.getRecallMovementState;
    states.forEach((element) {
      state = element;
      widget.sendState(state);
    });
  }

  void joystick() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.grey[900],
              ),
              child: Joystick(sendState: widget.sendState, recall: recall),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ShowDialogBox(
                context: context,
                actionButtonText: 'EXIT',
                msg: 'Are you sure want to Exit?',
                title: 'EXIT',
                exit: true)
            .showDialogBox();
        return false;
      },
      child: Consumer<CarData>(
        builder: (context, carData, child) {
          initMessageStream(messageStream: carData);
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // MessageStreams
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5);
                    },
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    reverse: true,
                    itemBuilder: (context, index) {
                      final messages = carData.getMessages.reversed.toList();
                      return Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (DismissDirection direction) async {
                          return await ShowDialogBox(
                                  context: context,
                                  actionButtonText: 'DELETE',
                                  msg:
                                      'Are you sure want to delete this message?',
                                  title: 'DELETE',
                                  exit: false)
                              .showDialogBox();
                        },
                        onDismissed: (direction) {
                          setState(() {
                            carData.deleteMessages(index: index);
                          });
                        },
                        child: messages[index],
                      );
                    },
                    itemCount: carData.getMessageCount,
                  ),
                ),
                // TextField and Send Button
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  child: Container(
                    child: Row(
                      children: [
                        // TextField
                        Expanded(
                          child: Material(
                            color: Colors.grey[800],
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      joystick();
                                    },
                                    child: Icon(Icons.gamepad_rounded,
                                        color: Colors.white, size: 30),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      autofocus: false,
                                      style: TextStyle(fontSize: 20),
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: _textEditingController,
                                      maxLines: null,
                                      decoration: kTextMessageInputDecoration,
                                      onChanged: (value) {
                                        carData.updateVoiceStatus(false);
                                        carData.updateMessageText(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Send Button
                        VoiceButton(
                          textEditingController: _textEditingController,
                          sendState: widget.sendState,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
