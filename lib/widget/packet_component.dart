import 'package:acost/common/config.dart';
import 'package:acost/model/packet.dart';
import 'package:flutter/material.dart';

class PacketComponent extends StatefulWidget {
  final Packet packet;
  final index;
  final isCheck;

  PacketComponent(this.packet, this.index, this.isCheck);

  @override
  State<StatefulWidget> createState() {
    return PacketComponentState();
  }
}

class PacketComponentState extends State<PacketComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 20,
                child: Text(
                  widget.index == 0
                      ? Config.chineseMode ? "实付金额" : "Real Cost"
                      : Config.chineseMode
                          ? "${widget.index}号篮子"
                          : "No.${widget.index} Packet",
                  style: TextStyle(
                    color: widget.isCheck
                        ? Config.themeData.primaryTextTheme.bodyText1.color
                        : Config.themeData.accentTextTheme.bodyText1.color,
                    fontSize: Config.chineseMode ? 14 : 16,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.packet.lambda,
                softWrap: true,
                style: TextStyle(
                  color: widget.isCheck
                      ? Config.themeData.primaryTextTheme.bodyText1.color
                      : Config.themeData.accentTextTheme.bodyText1.color,
                  fontSize: 15,
                ),
              ),
            ],
          )),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.packet.cost,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.isCheck
                  ? Config.themeData.primaryTextTheme.bodyText2.color
                  : Config.themeData.accentTextTheme.bodyText2.color,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
