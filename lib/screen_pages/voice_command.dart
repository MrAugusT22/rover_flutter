import 'package:be_extc/utilities/car_data.dart';
import 'package:be_extc/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Commands extends StatefulWidget {
  final TabController tabController;
  Commands({@required this.tabController});

  @override
  _CommandsState createState() => _CommandsState();
}

double v = 5.0;

class _CommandsState extends State<Commands> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.tabController.animateTo(0);
        return false;
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.arrow_upward_rounded,
                    movement: '/Forward',
                    list: 'f',
                  ),
                  SizedBox(width: 10),
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.arrow_downward_rounded,
                    movement: '/Backward',
                    list: 'b',
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.arrow_back_rounded,
                    movement: '/Left',
                    list: 'l',
                  ),
                  SizedBox(width: 10),
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.arrow_forward_rounded,
                    movement: '/Right',
                    list: 'r',
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.alt_route_rounded,
                    movement: '/AutoMode',
                    list: 'a',
                  ),
                  SizedBox(width: 10),
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.trending_up_rounded,
                    movement: '/ControlMode',
                    list: 'c',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.flash_on_rounded,
                    movement: '/Headlight On',
                    list: 'h1',
                  ),
                  SizedBox(width: 10),
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.flash_off_rounded,
                    movement: '/Headlight Off',
                    list: 'h2',
                  )
                ],
              ),
              SizedBox(height: 10),
              //Recall and Reset Card
              Row(
                children: [
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.sync_rounded,
                    movement: '/Recall',
                    list: 're',
                  ),
                  SizedBox(width: 10),
                  CommandCard(
                    tabController: widget.tabController,
                    icon: Icons.close_rounded,
                    movement: '/Reset',
                    list: 'res',
                  )
                ],
              ),
              SizedBox(height: 10),
              CommandCard(
                tabController: widget.tabController,
                icon: Icons.stop,
                movement: '/Stop',
                list: 's',
              ),
              SizedBox(height: 10),
              //Stack Slider
              Material(
                elevation: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      gradient: kOnlineUserMessageGradient,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('/Command Stack Size',
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      SizedBox(height: 10),
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              gradient: kOfflineGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.white60,
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          trackHeight: 4.0,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 12.0),
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.white60,
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                          inactiveTickMarkColor:
                                              Colors.transparent,
                                          valueIndicatorColor: Colors.blue),
                                      child: Slider(
                                        label: '${v.toInt()}',
                                        divisions: 19,
                                        min: 1,
                                        max: 20,
                                        value: v,
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            v = value;
                                            Provider.of<CarData>(context,
                                                    listen: false)
                                                .setNumberMovement(
                                                    value.toInt());
                                            print(
                                                '${Provider.of<CarData>(context, listen: false).getMovementStackSize}');
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '20',
                                        style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Note: Adjust the number of movements to be rolled back once /RECALL is used. Default: 5.',
                                style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white60),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                            ],
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
      ),
    );
  }
}

class CommandCard extends StatelessWidget {
  final String movement;
  final IconData icon;
  final String list;
  final TabController tabController;
  CommandCard(
      {@required this.movement,
      @required this.icon,
      @required this.list,
      @required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarData>(
      builder: (context, carData, child) {
        List l = carData.getCmdList(list);
        return Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            constraints: BoxConstraints(
                minWidth: (MediaQuery.of(context).size.width - 30) / 2),
            decoration: BoxDecoration(
                gradient: kOnlineUserMessageGradient,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              padding: EdgeInsets.all(20),
              onPressed: () {
                tabController.animateTo(tabController.length - 1);
                carData.toggleList(list);
              },
              child: Column(
                children: [
                  Icon(icon, size: 30),
                  SizedBox(height: 10),
                  Text(
                    movement,
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${l.length} ${l.length == 1 ? 'Command' : 'Commands'}',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 10,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
