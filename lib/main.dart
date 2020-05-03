import 'package:acost/calculate_component.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void inputOperation(var operation) {
    if ("1" == operation) {
      _incrementCounter();
      _incrementCounter();
    }
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
                            title: "1", onPressed: () => inputOperation("1")),
                        CalculateComponent(
                            title: "2", onPressed: () => inputOperation("2")),
                        CalculateComponent(
                            title: "3", onPressed: () => inputOperation("3")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "4", onPressed: () => inputOperation("4")),
                        CalculateComponent(
                            title: "5", onPressed: () => inputOperation("5")),
                        CalculateComponent(
                            title: "6", onPressed: () => inputOperation("6")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "7", onPressed: () => inputOperation("7")),
                        CalculateComponent(
                            title: "8", onPressed: () => inputOperation("8")),
                        CalculateComponent(
                            title: "9", onPressed: () => inputOperation("9")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalculateComponent(
                            title: "0", onPressed: () => inputOperation("0")),
                        CalculateComponent(
                            title: ".", onPressed: () => inputOperation(".")),
                        CalculateComponent(
                            title: "CE", onPressed: () => inputOperation("CE")),
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
                              title: "+", onPressed: () => inputOperation("+"))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Row(children: <Widget>[
                          CalculateComponent(
                              title: "AC",
                              onPressed: () => inputOperation("AC"))
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "data" * 20,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.teal[300],
                              fontSize: 25,
                            ),
                          )
                        ]),
                  ),
                ),
                Expanded(flex: 5, child: calculate)
              ]),
          flex: 4,
        ),
        Expanded(
          child: Center(child: Text('$_counter')),
          flex: 6,
        ),
      ],
    );

    return Scaffold(
        body: new SafeArea(child: mainLayout),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4DB6AC),
          onPressed: _incrementCounter,
          elevation: 0,
          highlightElevation: 2,
          tooltip: 'Add Packet',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: bottomBar);
  }
}
