import 'package:acost/model/packet.dart';
import 'package:flutter/material.dart';

class PacketComponent extends StatefulWidget {
  final Packet packet;
  final index;

  PacketComponent(this.packet, this.index);

  @override
  State<StatefulWidget> createState() {
    return PacketComponentState();
  }
}

class PacketComponentState extends State<PacketComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white10),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "No.${widget.index} Packet",
                style: TextStyle(
                  color: Colors.teal[300],
                  fontSize: 16,
                ),
              ),
              Text(
                widget.packet.lambda,
                style: TextStyle(
                  color: Colors.teal[300],
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Text(
            widget.packet.cost,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.teal[400],
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
