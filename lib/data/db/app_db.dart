import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:partyplanflutter/data/entity/party_entity.dart';
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
}
