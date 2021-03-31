import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_game/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Util flameUtil;
GameController gameController;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  SharedPreferences storage = await SharedPreferences.getInstance();
  gameController = GameController(storage);

  runApp(MyApp());
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameController.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF167F67),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Рой игра',
      home: new SpalshScreen(),
    );
  }
}

class SpalshScreen extends StatefulWidget {
  SpalshScreen({Key key}) : super(key: key);
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  var buildVersion;
  @override
  Future<void> initState() {
    super.initState();
    _openPage();
  }

  void _openPage() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => gameController.widget,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      decoration: kBoxDecorationColor,
      child: Column(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Рой игра",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        decorationStyle: TextDecorationStyle.wavy,
                        decorationThickness: 2)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: Text(
              "Группа ПИН-22М \n Махмадкулов Назирджон \n Облокулов Сардор \n Клинзо Стефен",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 2),
            ),
          ),
        )
      ]),
    );
  }
}

final kBoxDecorationColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF02BB9F),
      Color(0xFF167F67),
      Color(0xFF167F67),
    ],
    stops: [0.1, 0.5, 0.7],
  ),
);
