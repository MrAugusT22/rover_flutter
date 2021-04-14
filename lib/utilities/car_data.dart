import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

class CarData extends ChangeNotifier {
  bool _isWifiSelected;

  int _fb = 0;
  int _lr = 0;
  String _dist = '0';
  bool _isDist = false;

  bool _isHeadlightOn = false;
  bool _isAutoMode = false;

  bool _isListening = false;
  bool _isVoice = false;
  String _messageText;

  String _list = 'f';
  String _movement = 'f';

  int _movementStackSize = 5;

  String _state;

  String get getState {
    _state =
        '$_fb,$_lr,$_dist,${_isHeadlightOn ? '1' : '0'},${_isAutoMode ? '1' : '0'}';
    return _state;
  }

  bool get getMode {
    return _isAutoMode;
  }

  int get getMovementStackSize {
    return _movementStackSize;
  }

  void setNumberMovement(int d) {
    _movementStackSize = d;
    notifyListeners();
  }

  String get getL {
    return _list;
  }

  void toggleList(String l) {
    _list = l;
    print(_list + 'Updated');
    notifyListeners();
  }

  String get getMovement {
    return _movement;
  }

  void toggleMovement(String m) {
    _movement = m;
    notifyListeners();
  }

  final textController = TextEditingController();

  List<Widget> _messages = [];

  List<String> _fCmds = ['forward', 'forth', 'accelerate', 'ahead', 'front'];
  List<String> _bCmds = ['backward', 'reverse', 'back', 'pullover'];
  List<String> _lCmds = ['left'];
  List<String> _rCmds = ['right'];
  List<String> _stopCmds = ['stop', 'brakes', 'brake', 'halt'];
  List<String> _recallCmds = ['return'];
  List<String> _headlightsOn = [
    'lights on',
    'headlights on',
    'switch on lamps',
    'switch on headlights',
    'headlights',
    'headlights on',
    'switch on lamps',
    'switch on headlights',
    'headlights',
    'lamps'
  ];
  List<String> _headlightsOff = [
    'lights off',
    'headlights off',
    'switch off lamps',
    'switch off headlights',
    'lamps off',
    'headlights off',
    'switch off lamps',
    'switch off headlights',
  ];
  List<String> _autoMode = [
    'auto mode on',
    'toggle auto mode',
    'automate',
    'self navigate',
    'self navigation on',
    'control mode off',
    'find your way',
  ];
  List<String> _controlMode = [
    'control mode on',
    'auto mode off',
    'automate off',
    'toggle control mode',
    'listen to me',
    'self navigation off',
    'self navigate off',
  ];
  List<String> _resetCmds = ['reset', 'clear'];

  void addCmd(String value, String l) {
    switch (l) {
      case 'f':
        _fCmds.add(value);
        break;
      case 'b':
        _bCmds.add(value);
        break;
      case 'l':
        _lCmds.add(value);
        break;
      case 'r':
        _rCmds.add(value);
        break;
      case 'h1':
        _headlightsOn.add(value);
        break;
      case 'h2':
        _headlightsOff.add(value);
        break;
      case 'a':
        _autoMode.add(value);
        break;
      case 'c':
        _controlMode.add(value);
        break;
      case 's':
        _stopCmds.add(value);
        break;
      case 're':
        _recallCmds.add(value);
        break;
      case 'res':
        _resetCmds.add(value);
        break;
    }
    notifyListeners();
  }

  void delCmd(String l, int index) {
    switch (l) {
      case 'f':
        _fCmds.removeAt(index);
        break;
      case 'b':
        _bCmds.removeAt(index);
        break;
      case 'l':
        _lCmds.removeAt(index);
        break;
      case 'r':
        _rCmds.removeAt(index);
        break;
      case 'h1':
        _headlightsOn.removeAt(index);
        break;
      case 'h2':
        _headlightsOff.removeAt(index);
        break;
      case 'a':
        _autoMode.removeAt(index);
        break;
      case 'c':
        _controlMode.removeAt(index);
        break;
      case 's':
        _stopCmds.removeAt(index);
        break;
      case 're':
        _recallCmds.removeAt(index);
        break;
      case 'res':
        _resetCmds.removeAt(index);
        break;
    }
    notifyListeners();
  }

  List<String> getCmdList(String l) {
    switch (l) {
      case 'f':
        return _fCmds;
        break;
      case 'b':
        return _bCmds;
        break;
      case 'l':
        return _lCmds;
        break;
      case 'r':
        return _rCmds;
        break;
      case 'h1':
        return _headlightsOn;
        break;
      case 'h2':
        return _headlightsOff;
        break;
      case 'a':
        return _autoMode;
        break;
      case 'c':
        return _controlMode;
        break;
      case 's':
        return _stopCmds;
        break;
      case 're':
        return _recallCmds;
        break;
      case 'res':
        return _resetCmds;
        break;
    }
  }

  List<List> _movementStack = [];
  List<List> l = [];

  void addMovement(List value) {
    _movementStack.add(value);
  }

  void recall() {
    l = _movementStack.reversed.take(_movementStackSize).toList();
    l.forEach((element) {
      if (element[0] != 0) {
        element[0] = element[0] * (-1);
      }
      if (element[1] != 0) {
        element[1] = element[1] * (-1);
      }
    });
  }

  List get getRecallMovementState {
    recall();
    List states = [];
    l.forEach((element) {
      states.add(
          '${element[0]},${element[1]},${element[2]},${_isHeadlightOn ? '1' : '0'},${_isAutoMode ? '1' : '0'}');
    });
    return states;
  }

  void toggleHeadLight(bool h) {
    _isHeadlightOn = h;
    notifyListeners();
  }

  void toggleAutoMode(bool b) {
    _isAutoMode = b;
    notifyListeners();
  }

  void reset() {
    _fb = 0;
    _lr = 0;
    _dist = '0';
    _list = 'f';
    _movementStackSize = 5;
    _movementStack = [];
    _isHeadlightOn = false;
    _isAutoMode = false;
  }

  void move({int fb, int lr, String dist, bool move}) {
    _fb = fb;
    _lr = lr;
    _dist = dist;
    // fb != 0 || lr != 0 || dist != '0' || (fb != -2 && lr != -2)
    if (move) {
      addMovement([fb, lr, dist]);
    }
  }

  String get getDistance {
    return _dist;
  }

  void toggleDistance(bool d) {
    _isDist = d;
  }

  bool get getDistanceToggle {
    return _isDist;
  }

  bool get getHeadlightToggle {
    return _isHeadlightOn;
  }

  bool get getHonkingToggle {
    return _isAutoMode;
  }

  void addMessage(Widget widget) {
    _messages.add(widget);
    notifyListeners();
  }

  UnmodifiableListView get getMessages {
    return UnmodifiableListView(_messages);
  }

  void deleteMessages({int index}) {
    if (index == -1) {
      _messages = [];
    } else {
      _messages = _messages.reversed.toList();
      _messages.removeAt(index);
      _messages = _messages.reversed.toList();
    }
    notifyListeners();
  }

  int get getMessageCount {
    return _messages.length;
  }

  bool get getListenStatus {
    return _isListening;
  }

  void updateListenStatus({bool status}) {
    _isListening = status;
    notifyListeners();
  }

  void updateVoiceStatus(bool status) {
    _isVoice = status;
    notifyListeners();
  }

  bool get getVoiceStatus {
    return _isVoice;
  }

  void updateMessageText(String message) {
    _messageText = message;
    notifyListeners();
  }

  void updateTextControllerText(String text) {
    textController.text = text;
    notifyListeners();
  }

  String get getMessageText {
    return _messageText;
  }

  void updateConnectivity(bool status) {
    _isWifiSelected = status;
    notifyListeners();
  }

  bool get getConnectionStatus {
    return _isWifiSelected;
  }
}
