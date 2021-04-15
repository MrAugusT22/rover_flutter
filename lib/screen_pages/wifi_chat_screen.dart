import 'package:be_extc/screen_pages/chat_screen.dart';
import 'package:be_extc/screen_pages/voice_command.dart';
import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:be_extc/screen_pages/command_list.dart';
import 'package:flutter_glow/flutter_glow.dart';

class WifiChatScreen extends StatefulWidget {
  static const String id = 'WifiChatScreen';

  @override
  _WifiChatScreenState createState() => _WifiChatScreenState();
}

class _WifiChatScreenState extends State<WifiChatScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  String ip = '192.168.4.1';
  // String state = '';

  var wifiName = 'rov3R';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    getWifiName();
  }

  void getWifiName() async {
    wifiName = await WifiInfo().getWifiName();
  }

  void wifiSendMessage(String state) {
    String url = 'http://$ip/?State=$state';
    http.get(url);
    print(state);
    print('message sent');
  }

  @override
  Widget build(BuildContext context) {
    bool autoMode = Provider.of<CarData>(context).getMode;
    bool hl = Provider.of<CarData>(context).getHeadlightToggle;
    return Scaffold(
      backgroundColor: kMyDarkBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: kMyOfflineColor,
        elevation: 5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: kOfflineGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'logo',
              child: Material(
                elevation: 5,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(kMyImage),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '/$wifiName',
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  '${autoMode ? 'Auto Mode' : 'Control Mode'}',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 10,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              tooltip: 'EXIT',
              onPressed: () {
                ShowDialogBox(
                        context: context,
                        actionButtonText: 'EXIT',
                        msg: 'Are you sure want to Exit?',
                        title: 'EXIT',
                        exit: true)
                    .showDialogBox();
              })
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          tabs: [
            Tab(icon: Icon(Icons.chat_rounded, size: 30)),
            Tab(icon: Icon(Icons.record_voice_over_rounded, size: 30)),
            Tab(icon: Icon(Icons.list_rounded, size: 30)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            child: hl
                ? GlowIcon(
                    Icons.flash_on_rounded,
                    color: Colors.blue,
                    size: 150,
                  )
                : Icon(
                    Icons.flash_off_rounded,
                    color: Colors.grey,
                    size: 150,
                  ),
          ),
          TabBarView(
            controller: _tabController,
            physics: BouncingScrollPhysics(),
            children: [
              ChatScreen(sendState: wifiSendMessage),
              Commands(tabController: _tabController),
              CommandList(tabController: _tabController),
            ],
          ),
        ],
      ),
    );
  }
}
