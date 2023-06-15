import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:news/core/constant.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: Color(0xff8a898e)),
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              '${AppConstants.icons}union.svg',
              fit: BoxFit.scaleDown,
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              '${AppConstants.icons}shopping_bag.svg',
              fit: BoxFit.scaleDown,
            ),
            label: 'Покупки',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              '${AppConstants.icons}wallet.svg',
              fit: BoxFit.scaleDown,
            ),
            label: 'Платежи',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              '${AppConstants.icons}chat.svg',
              fit: BoxFit.scaleDown,
            ),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              '${AppConstants.icons}gifts.svg',
              fit: BoxFit.scaleDown,
            ),
            label: 'Бонусы',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: null,
      ),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Профиль'),
        actions: <Widget>[_notification()],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
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
          children: [_content()],
        ),
      ),
    );
  }
}

Widget _notification() {
  return Padding(
    padding: const EdgeInsets.only(right: 24.0),
    child: SvgPicture.asset(
      '${AppConstants.icons}exit.svg',
      fit: BoxFit.scaleDown,
    ),
  );
}

Widget _content() {
  return Padding(
    padding: const EdgeInsets.only(top: 14.0),
    child: Container(
      height: 1000,
      decoration: const BoxDecoration(
        color: Color(0xfff4f5fa),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 27.0, left: 12, right: 12),
        child: Container(
          child: Column(
            children: [_accountInfo(), SizedBox(height: 38,) ,_settingsList()],
          ),
        ),
      ),
    ),
  );
}

Widget _accountInfo() {
  return Column(
    children: [
      CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80,
          child: CircleAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage(
                "https://media.istockphoto.com/id/1322123064/photo/portrait-of-an-adorable-white-cat-in-sunglasses-and-an-shirt-lies-on-a-fabric-hammock.jpg?s=612x612&w=0&k=20&c=-G6l2c4jNI0y4cenh-t3qxvIQzVCOqOYZNvrRA7ZU5o="),
          )),
      SizedBox(
        height: 5,
      ),
      Text(
        'Васельчук Вася Васильевич',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
      ),
      SizedBox(
        height: 3,
      ),
      Text(
        '+7 922 123 45 67',
        style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16,
            color: Color(0xff8a898e)),
      ),
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '1 485,67 ₽ ',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Кошелек ImPay',
                  style: TextStyle(color: Color(0xff8a898e)),
                ),
              ],
            ),
            VerticalDivider(
              color: Color(0xff8a898e),
              thickness: 0.5,
            ),
            Column(
              children: [
                Text(
                  '5 485,67',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Накомленно бонусов',
                  style: TextStyle(color: Color(0xff8a898e)),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  );
}

Widget _settingsList() {
  List<String> title = ['Мои данные', 'Помощь'];
  List<Widget> iconSettings = [
    SvgPicture.asset(
      '${AppConstants.icons}user.svg',
      fit: BoxFit.scaleDown,
    ),
    SvgPicture.asset(
      '${AppConstants.icons}support.svg',
      fit: BoxFit.scaleDown,
    ),
  ];
  return Container(
    height: 200,
    child: ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: title.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),)

                ],
                color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: iconSettings[index]),
          title: Text(title[index]),
          trailing: index == 0 ? SvgPicture.asset(
            '${AppConstants.icons}back.svg',
            fit: BoxFit.scaleDown,
          ) : SizedBox.shrink(),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 24,
        );
      },
    ),
  );
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
