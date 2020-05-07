import 'dart:collection';

import 'package:acost/model/packet.dart';
import 'package:flutter/widgets.dart';

class PriceModel extends ChangeNotifier {
  final List<Packet> _list = [];

  var _selected = 0;

  UnmodifiableListView<Packet> get priceList => UnmodifiableListView(_list);

  void addPacket(Packet packet) {
    _list.add(packet);
    _selected = _list.length - 1;
    notifyListeners();
  }

  void inputOperation(var operation) {
    if ("1234567890".contains(operation)) {
      inputNum(operation);
    }
    if ("." == operation) {
      inputDot();
    }
    if ("+" == operation) {
      inputPlus();
    }
    if ("CE" == operation) {
      inputCE();
    }
    if ("AC" == operation) {
      inputAC();
    }
    calculateCost();
    notifyListeners();
  }

  void calculateCost() {
    List<String> realCostItems = _list[0].lambda.split("+");
    var realCost = 0.0;
    for (var item in realCostItems) {
      realCost += double.parse(item);
    }
    _list[0].cost = realCost.toStringAsFixed(2);

    var originalCost = 0.0;
    for (var i = 1; i < _list.length; i++) {
      List<String> packetItems = _list[i].lambda.split("+");
      for (var item in packetItems) {
        originalCost += double.parse(item);
      }
    }
    for (var i = 1; i < _list.length; i++) {
      List<String> packetItems = _list[i].lambda.split("+");
      var itemCost = 0.0;
      for (var item in packetItems) {
        itemCost += double.parse(item);
      }
      if (itemCost != 0) {
        _list[i].cost = (itemCost / originalCost * realCost).toStringAsFixed(2);
      }
    }
  }

  void inputNum(var numeral) {
    List<String> items = _list[_selected].lambda.split("+");
    String lastItem = items[items.length - 1];
    if (lastItem == "0") {
      Packet selectedOne = _list[_selected];
      selectedOne.lambda =
          selectedOne.lambda.substring(0, selectedOne.lambda.length - 1);
      selectedOne.lambda += numeral;
    } else {
      Packet selectedOne = _list[_selected];
      selectedOne.lambda += numeral;
    }
  }

  void inputDot() {
    List<String> items = _list[_selected].lambda.split("+");
    String lastItem = items[items.length - 1];
    if (!lastItem.endsWith(".") && !lastItem.contains(".")) {
      Packet selectedOne = _list[_selected];
      selectedOne.lambda += ".";
    }
  }

  void inputPlus() {
    Packet selectedOne = _list[_selected];
    selectedOne.lambda += "+0";
  }

  void inputCE() {
    List<String> items = _list[_selected].lambda.split("+");
    String lastItem = items[items.length - 1];
    if (lastItem == "0") {
      if (items.length > 1) {
        Packet selectedOne = _list[_selected];
        selectedOne.lambda =
            selectedOne.lambda.substring(0, selectedOne.lambda.length - 2);
      } else {
        Packet selectedOne = _list[_selected];
        selectedOne.lambda = "0";
      }
    } else {
      if (items.length > 1) {
        Packet selectedOne = _list[_selected];
        selectedOne.lambda = selectedOne.lambda
            .substring(0, selectedOne.lambda.length - lastItem.length);
        selectedOne.lambda += "0";
      } else {
        Packet selectedOne = _list[_selected];
        selectedOne.lambda = "0";
      }
    }
  }

  void inputAC() {
    _list.clear();
    _list.add(new Packet("0", "0.00"));
    _list.add(new Packet("0", "0.00"));
  }

  void check(i) {
    _selected = i;
    notifyListeners();
  }

  get size => _list.length;

  getConsole() {
    if (_list.length == 0) {
      _list.add(new Packet("0", "0.00"));
      _list.add(new Packet("0", "0.00"));
    }
    List<String> items = _list[_selected].lambda.split("+");
    return items[items.length - 1];
  }

  getItem(i) => _list[i];

  get selectedPosition => _selected;
}
