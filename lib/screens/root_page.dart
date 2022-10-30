import 'package:flutter/material.dart';
import 'package:partyplanflutter/screens/expired_party.dart';
import 'package:partyplanflutter/screens/upcomming_party.dart';

class Rootpage extends StatefulWidget {
  const Rootpage({super.key});

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  int currentPage = 0;
  List<Widget> pages = const [UpcommingParty(), ExpiredParty()];

  void _onItemTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add_party');
          },
          icon: const Icon(Icons.add),
          label: const Text(''),
          isExtended: false,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: currentPage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: const Color(0xFF526480),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                activeIcon: Icon(Icons.access_time_filled),
                label: "Upcomming"),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_off_outlined),
                activeIcon: Icon(Icons.timer_off),
                label: "Expired"),
          ],
        ));
  }
}
