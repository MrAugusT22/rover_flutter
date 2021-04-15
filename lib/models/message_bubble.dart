import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:be_extc/utilities/constants.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String sender;
  final time;
  final bool isMe;
  final bool isVoice;
  final bool isOffline;
  final bool error;

  MessageBubble({
    this.messageText,
    this.sender,
    this.isMe,
    this.time,
    this.isVoice,
    this.isOffline,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Bubble(
      isMe: isMe,
      isVoice: isVoice,
      sender: sender,
      messageText: messageText,
      time: time,
      error: error,
    );
  }
}

class Bubble extends StatelessWidget {
  const Bubble({
    Key key,
    @required this.isMe,
    @required this.isVoice,
    @required this.sender,
    @required this.messageText,
    @required this.time,
    @required this.error,
  }) : super(key: key);

  final bool isMe;
  final bool isVoice;
  final String sender;
  final String messageText;
  final time;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMe ? EdgeInsets.symmetric(vertical: 5) : EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: isVoice
                    ? BorderRadius.circular(20)
                    : BorderRadius.only(
                        topLeft:
                            isMe ? Radius.circular(20) : Radius.circular(0),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(20),
                      ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: isVoice
                      ? BorderRadius.circular(20)
                      : BorderRadius.only(
                          topLeft:
                              isMe ? Radius.circular(20) : Radius.circular(0),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(20),
                        ),
                  gradient:
                      isMe ? kOfflineGradient : kOnlineUserMessageGradient,
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isVoice ? Icon(Icons.mic_rounded) : Container(),
                        isVoice ? SizedBox(width: 10) : Container(),
                        Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            isMe
                                ? Container()
                                : Text(sender,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'RobotoMono',
                                        color: Colors.white60)),
                            isMe ? Container() : SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                error
                                    ? Icon(Icons.error_outline_rounded)
                                    : Container(),
                                error ? SizedBox(width: 10) : Container(),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5),
                                  child: Text(messageText,
                                      style: TextStyle(fontSize: 17)),
                                ),
                                SizedBox(width: 55),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        '$time',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 10,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
