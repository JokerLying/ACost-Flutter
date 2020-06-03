import 'dart:async';

import 'package:acost/common/config.dart';
import 'package:acost/model/packet.dart';
import 'package:acost/state/price_model.dart';
import 'package:acost/widget/calculate_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:acost/widget/packet_component.dart';
import 'package:vibrate/vibrate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Config.loadConfig().then((success) {
    Config.setTheme();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PriceModel()),
      ],
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = new ScrollController();
  BuildContext _scaffoldContext;

  void _inputOperation(var operation) {
    if (operation == "AC" || operation == "CE") {
      if (Config.vibrateMode) Vibrate.feedback(FeedbackType.medium);
    } else {
      if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
    }
    var priceModel = Provider.of<PriceModel>(context, listen: false);
    priceModel.inputOperation(operation);
  }

  void _addPacket() {
    if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
    var priceModel = Provider.of<PriceModel>(context, listen: false);
    priceModel.addPacket(new Packet("0", "0"));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Timer(
        Duration(milliseconds: 100),
        () => _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: Duration(
                milliseconds: 400,
              ),
              curve: Curves.ease,
            ));
  }

  void _showHelpDialog() {
    showCupertinoDialog(
        context: _scaffoldContext,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(Config.chineseMode ? "帮助" : "Help"),
            content: Text(Config.chineseMode
                ? "\n本程序意在帮助您AA账单\n\nAC = 清除所有\nCE = 清除当前"
                : "\nLet's split the bill.\n\nAC = All Clear\nCE = Clear Entry"),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(_scaffoldContext).pop();
                },
                child: Text(Config.chineseMode ? "知道了" : "Got it"),
              ),
            ],
          );
        });
  }

  void _showAboutDialog() {
    Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
      content: Text("Product with love by GnayUil"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final calculate = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "1", onPressed: () => _inputOperation("1")),
                        CalculateComponent(
                            title: "2", onPressed: () => _inputOperation("2")),
                        CalculateComponent(
                            title: "3", onPressed: () => _inputOperation("3")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "4", onPressed: () => _inputOperation("4")),
                        CalculateComponent(
                            title: "5", onPressed: () => _inputOperation("5")),
                        CalculateComponent(
                            title: "6", onPressed: () => _inputOperation("6")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "7", onPressed: () => _inputOperation("7")),
                        CalculateComponent(
                            title: "8", onPressed: () => _inputOperation("8")),
                        CalculateComponent(
                            title: "9", onPressed: () => _inputOperation("9")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "AC",
                            onPressed: () => _inputOperation("AC")),
                        CalculateComponent(
                            title: "0", onPressed: () => _inputOperation("0")),
                        CalculateComponent(
                            title: ".", onPressed: () => _inputOperation(".")),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Row(children: <Widget>[
                          CalculateComponent(
                              title: "+", onPressed: () => _inputOperation("+"))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(children: <Widget>[
                          CalculateComponent(
                              title: "CE",
                              onPressed: () => _inputOperation("CE"))
                        ]))
                  ])),
        ]);

    final bottomBar = BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(children: [
        IconButton(
            icon: const Icon(Icons.brightness_2),
            onPressed: () {
              setState(() {
                if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
                Config.changeThemeMode();
              });
            }),
        IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {
              setState(() {
                if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
                Config.changeChineseMode();
              });
            }),
        IconButton(
            icon: Icon(Icons.vibration),
            onPressed: () {
              setState(() {
                Config.changeVibrateMode();
                if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
              });
            }),
        IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
              _showHelpDialog();
            }),
        IconButton(
            icon: Icon(Icons.error_outline),
            onPressed: () {
              if (Config.vibrateMode) Vibrate.feedback(FeedbackType.light);
              _showAboutDialog();
            }),
      ]),
    );

    final mainLayout = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Consumer<PriceModel>(
                              builder: (context, priceModel, child) {
                            return Text(
                              priceModel.console,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Config
                                    .themeData.primaryTextTheme.bodyText1.color,
                                fontSize: 25,
                              ),
                            );
                          })
                        ]),
                  ),
                ),
                Expanded(flex: 5, child: calculate)
              ]),
          flex: 4,
        ),
        Expanded(
          child: Consumer<PriceModel>(builder: (context, priceModel, child) {
            return ListView.builder(
                controller: _controller,
                itemCount: priceModel.size,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: new PacketComponent(priceModel.getItem(index),
                          index, priceModel.position == index),
                      onTap: () {
                        if (Config.vibrateMode)
                          Vibrate.feedback(FeedbackType.light);
                        priceModel.check(index);
                      },
                    );
                  } else {
                    return Dismissible(
                      key: Key(priceModel.getItem(index).id.toString()),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: new PacketComponent(priceModel.getItem(index),
                            index, priceModel.position == index),
                        onTap: () {
                          if (Config.vibrateMode)
                            Vibrate.feedback(FeedbackType.light);
                          priceModel.check(index);
                        },
                        onLongPress: () {
                          if (Config.vibrateMode)
                            Vibrate.feedback(FeedbackType.medium);
                          priceModel.copyOne(index);
                          _scrollToBottom();
                        },
                      ),
                      onDismissed: (direction) {
                        priceModel.remove(index);
                      },
                    );
                  }
                });
          }),
          flex: 6,
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Config.themeData,
      home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            _scaffoldContext = context;
            return new SafeArea(child: mainLayout);
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: _addPacket,
            elevation: 0,
            highlightElevation: 2,
            tooltip: 'Add Packet',
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: bottomBar),
    );
  }
}
