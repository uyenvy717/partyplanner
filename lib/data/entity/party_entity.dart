import 'package:drift/drift.dart';
import 'package:partyplanflutter/screens/contact_list.dart';

class Party extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get partyName => text().named('party_name')();
  TextColumn get desc => text().named('desc')();
  TextColumn get location => text().named('location')();
  DateTimeColumn get date => dateTime().named('date')();
  List<ContactDetail> get contacts => [];
}
