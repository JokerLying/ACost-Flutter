import 'dart:collection';

import 'package:acost/model/packet.dart';
import 'package:flutter/widgets.dart';

class PriceModel extends ChangeNotifier {
  final List<Packet> _list = [];

  UnmodifiableListView<Packet> get priceList => UnmodifiableListView(_list);

  void addPacket(Packet packet) {
    _list.add(packet);
    notifyListeners();
  }
}
