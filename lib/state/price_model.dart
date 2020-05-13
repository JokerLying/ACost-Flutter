import 'dart:collection';

import 'package:acost/model/packet.dart';
import 'package:flutter/widgets.dart';

class PriceModel extends ChangeNotifier {
  final List<Packet> _list = [];

  var _selected = 0;

  UnmodifiableListView<Packet> get priceList => UnmodifiableListView(_list);

  get size => _list.length;

  get position => _selected;

  String get console {
    if (_list.length == 0) {
      _list.add(new Packet("0", "0"));
      _list.add(new Packet("0", "0"));
    }
    List<String> items = _list[_selected].lambda.split("+");
    return items[items.length - 1];
  }

  addPacket(Packet packet) {
    _list.add(packet);
    _selected = _list.length - 1;
    notifyListeners();
  }

  inputOperation(var operation) {
    if ("1234567890".contains(operation)) {
      _inputNum(operation);
    }
    if ("." == operation) {
      _inputDot();
    }
    if ("+" == operation) {
      _inputPlus();
    }
    if ("CE" == operation) {
      _inputCE();
    }
    if ("AC" == operation) {
      _inputAC();
    }
    _calculateCost();
    notifyListeners();
  }

  _calculateCost() {
    List<String> realCostItems = _list[0].lambda.split("+");
    var realCost = 0.0;
    for (var item in realCostItems) {
      realCost += double.parse(item);
    }
    _list[0].cost = _updateCost(realCost.toStringAsFixed(2));

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
        _list[i].cost = _updateCost(
            (itemCost / originalCost * realCost).toStringAsFixed(2));
      }
    }
  }

  String _updateCost(String cost) {
    if (cost.endsWith(".00")) {
      return cost.substring(0, cost.length - 3);
    }
    if (cost.endsWith("0")) {
      return cost.substring(0, cost.length - 1);
    }
    return cost;
  }

  _inputNum(var numeral) {
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

  _inputDot() {
    List<String> items = _list[_selected].lambda.split("+");
    String lastItem = items[items.length - 1];
    if (!lastItem.endsWith(".") && !lastItem.contains(".")) {
      Packet selectedOne = _list[_selected];
      selectedOne.lambda += ".";
    }
  }

  _inputPlus() {
    Packet selectedOne = _list[_selected];
    selectedOne.lambda += "+0";
  }

  _inputCE() {
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

  _inputAC() {
    _list.clear();
    _selected = 0;
    _list.add(new Packet("0", "0"));
    _list.add(new Packet("0", "0"));
  }

  check(i) {
    _selected = i;
    notifyListeners();
  }

  copyOne(i) {
    _selected = i;
    Packet one = new Packet(_list[i].lambda, _list[i].cost);
    _list.add(one);
    _calculateCost();
    notifyListeners();
  }

  Packet getItem(i) => _list[i];

  remove(i) {
    if (i <= _selected) {
      _selected--;
    }
    _list.removeAt(i);
    _calculateCost();
    notifyListeners();
  }
}
