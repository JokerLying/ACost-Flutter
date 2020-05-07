import 'dart:collection';

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

  void check(i) => _selected = i;

  get size => _list.length;

  getItem(i) => _list[i];
}
