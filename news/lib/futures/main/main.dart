import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:news/core/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/futures/profile/profile.dart';

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
        title: const Text('Вася'),
        leading:  Padding(
          padding: EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 24,
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/id/1322123064/photo/portrait-of-an-adorable-white-cat-in-sunglasses-and-an-shirt-lies-on-a-fabric-hammock.jpg?s=612x612&w=0&k=20&c=-G6l2c4jNI0y4cenh-t3qxvIQzVCOqOYZNvrRA7ZU5o="),
                )),
          ),
        ),
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
          children: [_balance(), _search(), _content()],
        ),
      ),
    );
  }
}

Widget _notification() {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 0, end: 3),
    badgeAnimation: const badges.BadgeAnimation.slide(
      disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
    ),
    showBadge: true,
    badgeContent: const Text(
      '3',
      style: TextStyle(color: Colors.white),
    ),
    badgeStyle: const badges.BadgeStyle(
      badgeColor: Colors.red,
    ),
    child: IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
  );
}

Widget _balance() {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 12),
    child: Column(
      children: [
        const SizedBox(
          height: 17,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Баланс кошелька ImPay ',
                style: TextStyle(color: Colors.white)),
            const Text(
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
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 12.0),
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
      decoration: const BoxDecoration(
        color: Color(0xfff4f5fa),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 27.0, left: 12, right: 12),
        child: Container(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Избранное'.toUpperCase(),
                    style: const TextStyle(color: Color(0xff8a898e)),
                  )),
              _favoriteView(),
              _newsView()
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _favoriteView() {
  List<String> title = [
    'Мои платежи',
    'Билеты',
    'Карты лояльности',
    'QR - оплата'
  ];
  List<Widget> assets = [
    SvgPicture.asset('${AppConstants.icons}my_payments.svg',
        fit: BoxFit.scaleDown),
    SvgPicture.asset(
      '${AppConstants.icons}coupon.svg',
      fit: BoxFit.scaleDown,
    ),
    SvgPicture.asset(
      '${AppConstants.icons}park_tickets_couple.svg',
      fit: BoxFit.scaleDown,
    ),
    SvgPicture.asset(
      '${AppConstants.icons}qr_menu.svg',
      fit: BoxFit.scaleDown,
    ),
  ];
  return Container(
    height: 130,
    child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: title.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            elevation: 2.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                  width: 84,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(alignment: Alignment.topLeft, child: assets[index]),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(title[index])),
                    ],
                  )),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 16,
        );
      },
    ),
  );
}

Widget _newsView() {
  List<String> urlImg = [
    'https://rtvi.com/wp-content/uploads/2022/04/ecf4cf42984f6a01289206ef6d915adc-1.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8H4C_ReoC7hA7Gfv8T6sj0i6j0eSoZTlJAA&usqp=CAU'
  ];
  List<String> textTitle = [
    'Суперакция от Веккер Закажи окно до конца сентября и получи мегаскидку плюсь бонусы на счёт.',
    'При заказе одной кружки кофе Вы получите 20 бонусов на счет.'
  ];
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Новости'.toUpperCase(),
              style: const TextStyle(color: Color(0xff8a898e))),
          SvgPicture.asset('${AppConstants.icons}back.svg',
              fit: BoxFit.scaleDown),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      SizedBox(
        width: 500,
        height: 180,
        child: Center(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: urlImg.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.blue,
                    child: Container(
                      width: 180,
                      height: 180,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            urlImg[index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Text(
                            textTitle[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 14,
              );
            },
          ),
        ),
      ),
    ],
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
