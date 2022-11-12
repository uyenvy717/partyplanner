import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:partyplanflutter/data/entity/party_entity.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'party.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Party])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //Get the list of party
  Future<List<PartyData>> getParties() async {
    return await select(party).get();
  }

  Future<PartyData> getParty(int id) async {
    return await (select(party)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateParty(PartyCompanion entity) async {
    return await update(party).replace(entity);
  }

  Future<int> insertParty(PartyCompanion entity) async {
    return await into(party).insert(entity);
  }

  Future<int> deleteParty(int id) async {
    return await (delete(party)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Future<List<ContactDetail>> updateGuest(List<ContactDetail> contacts, int id) async {
  //   return await (update(party)..where((tbl) => tbl.id.equals(id))).write(PartyCompanion())
  // }
}

@j.JsonSerializable()
class ContactDetail {
  final String name;
  final String phoneNumber;

  const ContactDetail(this.name, this.phoneNumber);

  factory ContactDetail.fromJson(Map<String, dynamic> json) => _$ContactDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailToJson(this);
}

class ContactConverter extends TypeConverter<ContactDetail, String> {
  const ContactConverter();

  @override
  ContactDetail fromSql(String fromDb) {
    return ContactDetail.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(ContactDetail value){
    return json.encode(value.toJson());
  }
}