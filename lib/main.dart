import 'package:flutter/material.dart';
import 'package:partyplanflutter/expired_party.dart';
import 'package:partyplanflutter/upcomming_party.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const Rootpage(),
    );
  }
}

class Rootpage extends StatefulWidget {
  const Rootpage({super.key});

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  int currentPage = 0;
  List<Widget> pages = const [UpcommingParty(), ExpiredParty()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PartyPlanner'),
        toolbarHeight: 100,
      ),
      body: pages[currentPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating Action Button');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.access_alarm), label: 'Upcomming'),
          NavigationDestination(icon: Icon(Icons.alarm_off), label: 'Expired')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
