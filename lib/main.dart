import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 64, 67, 6)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tern = 0;
  int my_life = 20;
  int enemy_life = 20;
  int pp = 0;
  int ep = 3;

  void incrementCounter() {
    setState(() {
      if (pp < 10) {
        pp++;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (pp > 0) {
        pp--;
      }
    });
  }

  void incrementEp() {
    setState(() {
      if (ep < 3) {
        ep++;
      }
    });
  }

  void decrementEp() {
    setState(() {
      if (ep > 0) {
        ep--;
      }
    });
  }

  Widget buildLifeContainer(int life, Color color, Function() incrementLife,
      Function() decrementLife) {
    return Expanded(
      child: Container(
        color: color,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: decrementLife,
                child: Icon(Icons.remove_circle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                ),
              ),
              Text(
                life.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: incrementLife,
                child: Icon(Icons.add_circle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Row(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    // PPポイント
                    ElevatedButton(
                      onPressed: incrementCounter,
                      child: Icon(Icons.add),
                    ),
                    for (var i
                        in List.generate(10, (index) => index + 1).reversed)
                      Text(
                        '$i',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: i <= pp
                                ? Color.fromARGB(255, 16, 167, 11)
                                : Colors.black,
                            fontWeight:
                                i <= pp ? FontWeight.bold : FontWeight.w100),
                      ),
                    ElevatedButton(
                      onPressed: decrementCounter,
                      child: Icon(Icons.remove),
                    ),
                    // EPポイント
                    ElevatedButton(
                      onPressed: incrementEp,
                      child: Icon(Icons.add),
                    ),
                    for (var i
                        in List.generate(3, (index) => index + 1).reversed)
                      Icon(
                        Icons.stars,
                        size: 40,
                        color: i <= ep
                            ? Colors.orange
                            : Colors
                                .black, // Replace yourCondition with your actual condition
                      ),
                    ElevatedButton(
                      onPressed: decrementEp,
                      child: Icon(Icons.remove),
                    )
                  ])),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("TERN ${tern}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text("ENEMY",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold)),
                buildLifeContainer(enemy_life, Color.fromARGB(255, 24, 41, 151),
                    () {
                  setState(() {
                    enemy_life++;
                  });
                }, () {
                  setState(() {
                    enemy_life--;
                  });
                }),
                Text("YOU",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold)),
                buildLifeContainer(my_life, Color.fromARGB(255, 151, 24, 24),
                    () {
                  setState(() {
                    my_life++;
                  });
                }, () {
                  setState(() {
                    my_life--;
                  });
                }),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            tern++;
                            if (tern >= 10) {
                              pp = 10;
                            } else {
                              pp = tern;
                            }
                          });
                        },
                        child: Text("ターン開始"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showLoadingDialog(context: context);
                          });
                        },
                        child: Icon(Icons.casino),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            my_life = 20;
                            enemy_life = 20;
                            pp = 0;
                            ep = 3;
                            tern = 0;
                          });
                        },
                        child: Icon(Icons.restart_alt),
                      )
                    ]),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showLoadingDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(Random().nextInt(100).toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text("もう一回"),
                  onPressed: () {
                    Navigator.pop(context);
                    showLoadingDialog(context: context);
                  },
                )
              ]),
        ]),
      );
    },
  );
}
