import 'package:flutter/material.dart';
import 'package:partyplanflutter/data/db/app_db.dart';
import 'package:partyplanflutter/screens/contact_list.dart';
import 'package:partyplanflutter/screens/events_add_widget.dart';
import 'package:partyplanflutter/screens/events_detail.dart';
import 'package:partyplanflutter/screens/events_edit_widget.dart';
import 'package:partyplanflutter/screens/expired_party.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const ExpiredParty());
      case '/party_detail':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EventsDetail(
              id: args,
            ),
          );
        }
        return _errorRoute();
      case '/add_party':
        return MaterialPageRoute(builder: (_) => const EventsAdd());
      case '/edit_party':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => EventsEdit(
              id: args,
            ),
          );
        }
        return _errorRoute();
      case '/contact_list':
        final contactArgs = settings.arguments as ContactArguments;
        return MaterialPageRoute(
            builder: (_) => ContactList(
                  args: contactArgs,
                ));
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

class ContactArguments {
  late final List<ContactDetail> contacts;
  final int id;
  ValueNotifier<bool> notifier;

  ContactArguments(this.contacts, this.id, this.notifier);
}
