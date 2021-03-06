import 'package:acost/common/config.dart';
import 'package:flutter/cupertino.dart';

class CalculateComponent extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  CalculateComponent({@required this.title, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return CalculateComponentState();
  }
}

class CalculateComponentState extends State<CalculateComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.maxFinite,
        child: CupertinoButton(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Config.themeData.primaryTextTheme.bodyText1.color,
              ),
            ),
            onPressed: widget.onPressed),
      ),
    );
  }
}
