import 'package:acost/model/packet.dart';
import 'package:acost/state/price_model.dart';
import 'package:acost/widget/calculate_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:acost/widget/packet_component.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => PriceModel(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _inputOperation(var operation) {
    var priceModel = Provider.of<PriceModel>(context, listen: false);
    priceModel.inputOperation(operation);
  }

  void _addPacket() {
    var priceModel = Provider.of<PriceModel>(context, listen: false);
    priceModel.addPacket(new Packet("12+18+9", "17.5"));
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
                            title: "0", onPressed: () => _inputOperation("0")),
                        CalculateComponent(
                            title: ".", onPressed: () => _inputOperation(".")),
                        CalculateComponent(
                            title: "CE",
                            onPressed: () => _inputOperation("CE")),
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
                              title: "AC",
                              onPressed: () => _inputOperation("AC"))
                        ]))
                  ])),
        ]);

    final bottomBar = BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.teal[300],
      child: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: Row(children: [
          IconButton(
              icon: const Icon(Icons.brightness_2),
              onPressed: () {
                print('Menu button pressed');
              }),
          IconButton(
              icon: Icon(Icons.translate),
              onPressed: () {
                print('Menu button pressed');
              }),
          IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                print('Menu button pressed');
              }),
          IconButton(
              icon: Icon(Icons.error_outline),
              onPressed: () {
                print('Menu button pressed');
              }),
        ]),
      ),
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
                              priceModel.getConsole(),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.teal[300],
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
                itemCount: priceModel.size,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child:
                          new PacketComponent(priceModel.getItem(index), index, priceModel.selectedPosition == index),
                      onTap: () {
                        priceModel.check(index);
                      });
                });
          }),
          flex: 6,
        ),
      ],
    );

    return Scaffold(
        body: new SafeArea(child: mainLayout),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4DB6AC),
          onPressed: _addPacket,
          elevation: 0,
          highlightElevation: 2,
          tooltip: 'Add Packet',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: bottomBar);
  }
}
