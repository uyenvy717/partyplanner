// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PartyData extends DataClass implements Insertable<PartyData> {
  final int id;
  final String partyName;
  final String desc;
  final String location;
  final DateTime date;
  const PartyData(
      {required this.id,
      required this.partyName,
      required this.desc,
      required this.location,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['party_name'] = Variable<String>(partyName);
    map['desc'] = Variable<String>(desc);
    map['location'] = Variable<String>(location);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  PartyCompanion toCompanion(bool nullToAbsent) {
    return PartyCompanion(
      id: Value(id),
      partyName: Value(partyName),
      desc: Value(desc),
      location: Value(location),
      date: Value(date),
    );
  }

  factory PartyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartyData(
      id: serializer.fromJson<int>(json['id']),
      partyName: serializer.fromJson<String>(json['partyName']),
      desc: serializer.fromJson<String>(json['desc']),
      location: serializer.fromJson<String>(json['location']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partyName': serializer.toJson<String>(partyName),
      'desc': serializer.toJson<String>(desc),
      'location': serializer.toJson<String>(location),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  PartyData copyWith(
          {int? id,
          String? partyName,
          String? desc,
          String? location,
          DateTime? date}) =>
      PartyData(
        id: id ?? this.id,
        partyName: partyName ?? this.partyName,
        desc: desc ?? this.desc,
        location: location ?? this.location,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('PartyData(')
          ..write('id: $id, ')
          ..write('partyName: $partyName, ')
          ..write('desc: $desc, ')
          ..write('location: $location, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, partyName, desc, location, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartyData &&
          other.id == this.id &&
          other.partyName == this.partyName &&
          other.desc == this.desc &&
          other.location == this.location &&
          other.date == this.date);
}

class PartyCompanion extends UpdateCompanion<PartyData> {
  final Value<int> id;
  final Value<String> partyName;
  final Value<String> desc;
  final Value<String> location;
  final Value<DateTime> date;
  const PartyCompanion({
    this.id = const Value.absent(),
    this.partyName = const Value.absent(),
    this.desc = const Value.absent(),
    this.location = const Value.absent(),
    this.date = const Value.absent(),
  });
  PartyCompanion.insert({
    this.id = const Value.absent(),
    required String partyName,
    required String desc,
    required String location,
    required DateTime date,
  })  : partyName = Value(partyName),
        desc = Value(desc),
        location = Value(location),
        date = Value(date);
  static Insertable<PartyData> custom({
    Expression<int>? id,
    Expression<String>? partyName,
    Expression<String>? desc,
    Expression<String>? location,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partyName != null) 'party_name': partyName,
      if (desc != null) 'desc': desc,
      if (location != null) 'location': location,
      if (date != null) 'date': date,
    });
  }

  PartyCompanion copyWith(
      {Value<int>? id,
      Value<String>? partyName,
      Value<String>? desc,
      Value<String>? location,
      Value<DateTime>? date}) {
    return PartyCompanion(
      id: id ?? this.id,
      partyName: partyName ?? this.partyName,
      desc: desc ?? this.desc,
      location: location ?? this.location,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partyName.present) {
      map['party_name'] = Variable<String>(partyName.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartyCompanion(')
          ..write('id: $id, ')
          ..write('partyName: $partyName, ')
          ..write('desc: $desc, ')
          ..write('location: $location, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $PartyTable extends Party with TableInfo<$PartyTable, PartyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartyTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _partyNameMeta = const VerificationMeta('partyName');
  @override
  late final GeneratedColumn<String> partyName = GeneratedColumn<String>(
      'party_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
      'desc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, partyName, desc, location, date];
  @override
  String get aliasedName => _alias ?? 'party';
  @override
  String get actualTableName => 'party';
  @override
  VerificationContext validateIntegrity(Insertable<PartyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('party_name')) {
      context.handle(_partyNameMeta,
          partyName.isAcceptableOrUnknown(data['party_name']!, _partyNameMeta));
    } else if (isInserting) {
      context.missing(_partyNameMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartyData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      partyName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}party_name'])!,
      desc: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}desc'])!,
      location: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $PartyTable createAlias(String alias) {
    return $PartyTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $PartyTable party = $PartyTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [party];
}
