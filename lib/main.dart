import 'package:flutter/material.dart';
import 'package:partyplanflutter/route/route_generator.dart';
import 'package:partyplanflutter/screens/expired_party.dart';
import 'package:partyplanflutter/screens/upcomming_party.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add_party');
        },
        icon: const Icon(Icons.add),
        label: const Text(''),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.access_alarm),
            label: 'Upcomming',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm_off),
            label: 'Expired',
          ),
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
