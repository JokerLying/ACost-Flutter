import 'dart:collection';
import 'dart:developer';

import 'package:acost/model/packet.dart';
import 'package:flutter/widgets.dart';

class PriceModel extends ChangeNotifier {
  final List<Packet> _list = [];

  var _selected = 0;

  UnmodifiableListView<Packet> get priceList => UnmodifiableListView(_list);

  void addPacket(Packet packet) {
    _list.add(packet);
    notifyListeners();
  }

  void inputOperation(var operation) {
    Packet selectedOne = _list[_selected];
    selectedOne.lambda += operation;
    notifyListeners();
  }

  void check(i) {
    _selected = i;
    notifyListeners();
  }

  get size => _list.length;

  getConsole() {
    if (_list.length == 0) {
      _list.add(new Packet("12+18+9", "17.5"));
    }
    List<String> items = _list[_selected].lambda.split("+");
    return items[items.length - 1];
  }

  getItem(i) => _list[i];

  get selectedPosition => _selected;
}
