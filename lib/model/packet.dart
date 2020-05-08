class Packet {
  final id = DateTime.now().millisecondsSinceEpoch;
  var lambda = "";
  var cost = "";
  Packet(this.lambda, this.cost);
}
