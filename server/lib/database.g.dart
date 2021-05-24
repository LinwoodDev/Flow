// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> color;
  const BadgesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  });
  BadgesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Badge> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int?>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
    });
  }

  BadgesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? color}) {
    return BadgesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<int?>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BadgesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedIntColumn color = _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, description, color];
  @override
  $BadgesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'badges';
  @override
  final String actualTableName = 'badges';
  @override
  VerificationContext validateIntegrity(Insertable<Badge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Badge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Badge(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(_db, alias);
  }
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> series;
  final Value<EventState> state;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.series = const Value.absent(),
    this.state = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.series = const Value.absent(),
    required EventState state,
  })  : name = Value(name),
        state = Value(state);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int?>? series,
    Expression<EventState>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (series != null) 'series': series,
      if (state != null) 'state': state,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? series,
      Value<EventState>? state}) {
    return EventsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      series: series ?? this.series,
      state: state ?? this.state,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (series.present) {
      map['series'] = Variable<int?>(series.value);
    }
    if (state.present) {
      final converter = $EventsTable.$converter0;
      map['state'] = Variable<int>(converter.mapToSql(state.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('series: $series, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedIntColumn series = _constructSeries();
  GeneratedIntColumn _constructSeries() {
    return GeneratedIntColumn(
      'series',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedIntColumn state = _constructState();
  GeneratedIntColumn _constructState() {
    return GeneratedIntColumn(
      'state',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, description, series, state];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series']!, _seriesMeta));
    }
    context.handle(_stateMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      series: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}series']),
      state: $EventsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}state']))!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }

  static TypeConverter<EventState, int> $converter0 = EventStateConverter();
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Place> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  PlacesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? description}) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PlacesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: const Constant(''));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  $PlacesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'places';
  @override
  final String actualTableName = 'places';
  @override
  VerificationContext validateIntegrity(Insertable<Place> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Place(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(_db, alias);
  }
}

class SeriesCollectionCompanion extends UpdateCompanion<Series> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> color;
  const SeriesCollectionCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  });
  SeriesCollectionCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Series> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int?>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
    });
  }

  SeriesCollectionCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? color}) {
    return SeriesCollectionCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<int?>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesCollectionCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $SeriesCollectionTable extends SeriesCollection
    with TableInfo<$SeriesCollectionTable, Series> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SeriesCollectionTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedIntColumn color = _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, description, color];
  @override
  $SeriesCollectionTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'series_collection';
  @override
  final String actualTableName = 'series_collection';
  @override
  VerificationContext validateIntegrity(Insertable<Series> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Series map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Series(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }

  @override
  $SeriesCollectionTable createAlias(String alias) {
    return $SeriesCollectionTable(_db, alias);
  }
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> color;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.color = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int?>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
    });
  }

  TeamsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? color}) {
    return TeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<int?>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TeamsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedIntColumn color = _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, description, color];
  @override
  $TeamsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'teams';
  @override
  final String actualTableName = 'teams';
  @override
  VerificationContext validateIntegrity(Insertable<Team> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color']),
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(_db, alias);
  }
}

class TeamUser extends DataClass implements Insertable<TeamUser> {
  final int user;
  TeamUser({required this.user});
  factory TeamUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TeamUser(
      user: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user'] = Variable<int>(user);
    return map;
  }

  TeamUsersCompanion toCompanion(bool nullToAbsent) {
    return TeamUsersCompanion(
      user: Value(user),
    );
  }

  factory TeamUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TeamUser(
      user: serializer.fromJson<int>(json['user']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user': serializer.toJson<int>(user),
    };
  }

  TeamUser copyWith({int? user}) => TeamUser(
        user: user ?? this.user,
      );
  @override
  String toString() {
    return (StringBuffer('TeamUser(')..write('user: $user')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(user.hashCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TeamUser && other.user == this.user);
}

class TeamUsersCompanion extends UpdateCompanion<TeamUser> {
  final Value<int> user;
  const TeamUsersCompanion({
    this.user = const Value.absent(),
  });
  TeamUsersCompanion.insert({
    required int user,
  }) : user = Value(user);
  static Insertable<TeamUser> custom({
    Expression<int>? user,
  }) {
    return RawValuesInsertable({
      if (user != null) 'user': user,
    });
  }

  TeamUsersCompanion copyWith({Value<int>? user}) {
    return TeamUsersCompanion(
      user: user ?? this.user,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (user.present) {
      map['user'] = Variable<int>(user.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamUsersCompanion(')
          ..write('user: $user')
          ..write(')'))
        .toString();
  }
}

class $TeamUsersTable extends TeamUsers
    with TableInfo<$TeamUsersTable, TeamUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TeamUsersTable(this._db, [this._alias]);
  final VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedIntColumn user = _constructUser();
  GeneratedIntColumn _constructUser() {
    return GeneratedIntColumn(
      'user',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [user];
  @override
  $TeamUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'team_users';
  @override
  final String actualTableName = 'team_users';
  @override
  VerificationContext validateIntegrity(Insertable<TeamUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  TeamUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TeamUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TeamUsersTable createAlias(String alias) {
    return $TeamUsersTable(_db, alias);
  }
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> displayName;
  final Value<String> bio;
  final Value<String> email;
  final Value<String> password;
  final Value<int?> series;
  final Value<UserState> state;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.displayName = const Value.absent(),
    this.bio = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.series = const Value.absent(),
    this.state = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.displayName = const Value.absent(),
    this.bio = const Value.absent(),
    required String email,
    required String password,
    this.series = const Value.absent(),
    required UserState state,
  })  : name = Value(name),
        email = Value(email),
        password = Value(password),
        state = Value(state);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String?>? displayName,
    Expression<String>? bio,
    Expression<String>? email,
    Expression<String>? password,
    Expression<int?>? series,
    Expression<UserState>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (displayName != null) 'display_name': displayName,
      if (bio != null) 'bio': bio,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (series != null) 'series': series,
      if (state != null) 'state': state,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? displayName,
      Value<String>? bio,
      Value<String>? email,
      Value<String>? password,
      Value<int?>? series,
      Value<UserState>? state}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      password: password ?? this.password,
      series: series ?? this.series,
      state: state ?? this.state,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String?>(displayName.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (series.present) {
      map['series'] = Variable<int?>(series.value);
    }
    if (state.present) {
      final converter = $UsersTable.$converter0;
      map['state'] = Variable<int>(converter.mapToSql(state.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('displayName: $displayName, ')
          ..write('bio: $bio, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('series: $series, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedTextColumn displayName = _constructDisplayName();
  GeneratedTextColumn _constructDisplayName() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedTextColumn bio = _constructBio();
  GeneratedTextColumn _constructBio() {
    return GeneratedTextColumn('bio', $tableName, false,
        defaultValue: const Constant(''));
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedTextColumn email = _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedTextColumn password = _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      false,
    );
  }

  final VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedIntColumn series = _constructSeries();
  GeneratedIntColumn _constructSeries() {
    return GeneratedIntColumn(
      'series',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedIntColumn state = _constructState();
  GeneratedIntColumn _constructState() {
    return GeneratedIntColumn(
      'state',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, displayName, bio, email, password, series, state];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series']!, _seriesMeta));
    }
    context.handle(_stateMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      displayName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      bio: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bio'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      state: $UsersTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}state']))!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }

  static TypeConverter<UserState, int> $converter0 = UserStateConverter();
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $BadgesTable badges = $BadgesTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $SeriesCollectionTable seriesCollection =
      $SeriesCollectionTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $TeamUsersTable teamUsers = $TeamUsersTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [badges, events, places, seriesCollection, teams, teamUsers, users];
}
