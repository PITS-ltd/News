import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.red,
    //   // decoration: const BoxDecoration(
    //   //     gradient: LinearGradient(
    //   //       begin: Alignment.topCenter,
    //   //       end: Alignment(1, 0.001),
    //   //       colors: <Color>[
    //   //         Color(0xff009df5),
    //   //         Color(0xff027fc6),
    //   //       ],
    //   //       // Gradient from https://learnui.design/tools/gradient-generator.html
    //   //       // tileMode: TileMode.mirror,
    //   //     )),
    //   child: Scaffold(

    //       body: _body()),
    // );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Вася'),
        leading: const Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              child: CircleAvatar(
                radius: 24.0,
                backgroundImage: NetworkImage(
                    "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
              )),
        ),
        actions: <Widget>[_shoppingCartBadge()],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff009df5),
              Color(0xff027fc6),
              Color(0xff027fc6),
            ],
          ),
        ),
        child: ListView(
          children: [
            _balance(), _search(), _content()
          ],
        ),
      ),
    );
  }
}

Widget _shoppingCartBadge() {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 0, end: 3),
    badgeAnimation: badges.BadgeAnimation.slide(
      disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
    ),
    showBadge: true,
    badgeContent: Text(
      '3',
      style: TextStyle(color: Colors.white),
    ),
    badgeStyle: badges.BadgeStyle(
      badgeColor: Colors.red,
    ),
    child: IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
  );
}



Widget _balance() {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 12),
    child: Column(
      children: [
        SizedBox(
          height: 17,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Баланс кошелька ImPay ',
                style: TextStyle(color: Colors.white)),
            Text(
              '5 485,67 ₽',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ],
    ),
  );
}

Widget _search() {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white12,
            suffixIcon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            hintText: 'Поиск',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}

Widget _content() {
  return Padding(
    padding: const EdgeInsets.only(top: 14.0),
    child: Container(
      height: 700,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text('wdvd'),
    ),
  );
}
