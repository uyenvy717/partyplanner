import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyplanflutter/main.dart';
import 'package:partyplanflutter/upcomming_party.dart';
import 'package:partyplanflutter/widgets/events_edit_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const UpcommingParty());
      case '/add_party':
        return MaterialPageRoute(builder: (_) => const EventsEdit());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Route'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Sorry no route was found!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}
