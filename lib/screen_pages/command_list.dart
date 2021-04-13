import 'package:be_extc/models/authentication_buttons.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommandList extends StatefulWidget {
  final TabController tabController;
  CommandList({@required this.tabController});

  @override
  _CommandListState createState() => _CommandListState();
}

class _CommandListState extends State<CommandList> {
  TextEditingController _textEditingController = TextEditingController();
  String newCommand;
  bool isTextFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.tabController.animateTo(1);
        return false;
      },
      child: Consumer<CarData>(
        builder: (context, carData, child) {
          String l = carData.getL;
          List<String> list = carData.getCmdList(l);
          Map<String, IconData> icons = {
            'f': Icons.arrow_upward_rounded,
            'b': Icons.arrow_downward_rounded,
            'l': Icons.arrow_back_rounded,
            'r': Icons.arrow_forward_rounded,
            'h1': Icons.flash_on_rounded,
            'h2': Icons.flash_off_rounded,
            'a': Icons.alt_route_rounded,
            'c': Icons.trending_up_rounded,
            's': Icons.stop,
            'u': Icons.refresh_rounded,
            're': Icons.sync_rounded,
            'res': Icons.close_rounded,
          };

          Map<String, String> move = {
            'f': '/Forward',
            'b': '/Backward',
            'l': '/Left',
            'r': '/Right',
            'h1': '/Headlight On',
            'h2': '/Headlight Off',
            'a': '/AutoMode',
            'c': '/ControlMode',
            's': '/Stop',
            'u': '/U Turn',
            're': '/Recall',
            'res': '/Reset',
          };

          Map<String, String> info = {
            'f': 'Moves forward.',
            'b': 'Moves backward.',
            'l': 'Turns left by 30°.',
            'r': 'Turns right by 30°.',
            'h1': 'Turns on Headlights.',
            'h2': 'Turns off Headlights.',
            'a':
                '$kMyProjectName will find a obstacle free path automatically.',
            'c': 'Let\'s you control the $kMyProjectName fully',
            's': 'Stops instantly.',
            'u': 'Makes a U turn.',
            're':
                '$kMyProjectName will return back executing the previous commands.',
            'res':
                'Will delete the enter Movement Stack and $kMyProjectName will stop instantly.',
          };
          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 76, left: 10, right: 10),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: kOnlineUserMessageGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.info_outline_rounded),
                                title: Text(
                                  '${info[l]}',
                                  style: TextStyle(
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: kOnlineUserMessageGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ListTile(
                                leading: Icon(icons[l]),
                                title: Text(
                                  '${list[index - 1]}',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete_rounded),
                                    onPressed: () {
                                      print('del');
                                      carData.delCmd(l, index - 1);
                                    }),
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: list.length + 1,
                    ),
                  ),
                  SizedBox(height: 50),
                  Container()
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: RawMaterialButton(
                  constraints: BoxConstraints(minWidth: 56, minHeight: 56),
                  // fillColor: Colors.blue,
                  elevation: 5,
                  shape: CircleBorder(),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30)),
                                      color: Colors.grey[900]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '${move[l]}',
                                        style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        style: TextStyle(fontSize: 20),
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: _textEditingController,
                                        maxLines: null,
                                        decoration: kTextFieldDecoration
                                            .copyWith(hintText: 'Add Command'),
                                        onChanged: (value) {
                                          newCommand = value;
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      AuthenticationButtons(
                                          gradient: kOfflineGradient,
                                          buttonText: Text(
                                            'Add',
                                            style: kWelcomePageButtonTextStyle,
                                          ),
                                          onPressed: () {
                                            if (_textEditingController
                                                .text.isEmpty) {
                                              return;
                                            } else {
                                              carData.addCmd(
                                                  newCommand.toLowerCase(), l);
                                              Navigator.pop(context);
                                              _textEditingController.clear();
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: Container(
                    constraints: BoxConstraints(minHeight: 56, minWidth: 56),
                    decoration: BoxDecoration(
                      gradient: kOfflineGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add_rounded),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
