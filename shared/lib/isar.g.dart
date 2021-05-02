// ignore_for_file: unused_import, implementation_imports

import 'dart:ffi';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:isar/src/isar_native.dart';
import 'package:isar/src/query_builder.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'event.dart';
import 'group.dart';
import 'series.dart';
import 'user.dart';
import 'package:shared/event.dart';
import 'package:shared/user.dart';

extension GetCollection on Isar {
  IsarCollection<Event> get events {
    return getCollection('Event');
  }

  IsarCollection<UserGroup> get userGroups {
    return getCollection('UserGroup');
  }

  IsarCollection<Series> get seriess {
    return getCollection('Series');
  }

  IsarCollection<User> get users {
    return getCollection('User');
  }
}

extension EventQueryWhereSort on QueryBuilder<Event, QWhere> {
  QueryBuilder<Event, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension EventQueryWhere on QueryBuilder<Event, QWhereClause> {}

extension UserGroupQueryWhereSort on QueryBuilder<UserGroup, QWhere> {
  QueryBuilder<UserGroup, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension UserGroupQueryWhere on QueryBuilder<UserGroup, QWhereClause> {}

extension SeriesQueryWhereSort on QueryBuilder<Series, QWhere> {
  QueryBuilder<Series, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension SeriesQueryWhere on QueryBuilder<Series, QWhereClause> {}

extension UserQueryWhereSort on QueryBuilder<User, QWhere> {
  QueryBuilder<User, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension UserQueryWhere on QueryBuilder<User, QWhereClause> {}

extension EventQueryFilter on QueryBuilder<Event, QFilterCondition> {
  QueryBuilder<Event, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> idBetween(int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> descriptionEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> descriptionStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> descriptionEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> descriptionContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> descriptionMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> stateEqualTo(EventState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'state',
      value: _EventAdapter._EventStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> stateGreaterThan(
      EventState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'state',
      value: _EventAdapter._EventStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> stateLessThan(EventState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'state',
      value: _EventAdapter._EventStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<Event, QAfterFilterCondition> stateBetween(
      EventState lower, EventState upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'state',
      lower: _EventAdapter._EventStateConverter.toIsar(lower),
      upper: _EventAdapter._EventStateConverter.toIsar(upper),
    ));
  }
}

extension UserGroupQueryFilter on QueryBuilder<UserGroup, QFilterCondition> {
  QueryBuilder<UserGroup, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> idGreaterThan(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> idLessThan(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> idBetween(
      int lower, int upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> nameEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> nameStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> nameEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> descriptionEqualTo(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> descriptionStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> descriptionEndsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> colorIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'color',
      value: null,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> colorEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> colorGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> colorLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<UserGroup, QAfterFilterCondition> colorBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'color',
      lower: lower,
      upper: upper,
    ));
  }
}

extension SeriesQueryFilter on QueryBuilder<Series, QFilterCondition> {
  QueryBuilder<Series, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> idGreaterThan(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> idLessThan(int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> idBetween(int lower, int upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> nameEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> nameStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> nameEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> colorIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'color',
      value: null,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> colorEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> colorGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> colorLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'color',
      value: value,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> colorBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'color',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> descriptionEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> descriptionStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> descriptionEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'description',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> descriptionContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Series, QAfterFilterCondition> descriptionMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension UserQueryFilter on QueryBuilder<User, QFilterCondition> {
  QueryBuilder<User, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> idBetween(int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> nameEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> nameStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> nameEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'name',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'displayName',
      value: null,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameEqualTo(String? value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'displayName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameStartsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'displayName',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameEndsWith(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'displayName',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameContains(String? value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    assert(convertedValue != null, 'Null values are not allowed');
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'displayName',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> displayNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'displayName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> emailEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> emailStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'email',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> emailEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'email',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> emailContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'email',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> emailMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'email',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> passwordEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'password',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> passwordStartsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'password',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> passwordEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'password',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> passwordContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'password',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> passwordMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'password',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> stateEqualTo(UserState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'state',
      value: _UserAdapter._UserStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> stateGreaterThan(UserState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'state',
      value: _UserAdapter._UserStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> stateLessThan(UserState value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'state',
      value: _UserAdapter._UserStateConverter.toIsar(value),
    ));
  }

  QueryBuilder<User, QAfterFilterCondition> stateBetween(
      UserState lower, UserState upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'state',
      lower: _UserAdapter._UserStateConverter.toIsar(lower),
      upper: _UserAdapter._UserStateConverter.toIsar(upper),
    ));
  }
}

extension EventQueryLinks on QueryBuilder<Event, QFilterCondition> {
  QueryBuilder<Event, QAfterFilterCondition> series(FilterQuery<Series> q) {
    return linkInternal(
      isar.seriess,
      q,
      'series',
    );
  }
}

extension UserGroupQueryLinks on QueryBuilder<UserGroup, QFilterCondition> {
  QueryBuilder<UserGroup, QAfterFilterCondition> users(FilterQuery<User> q) {
    return linkInternal(
      isar.users,
      q,
      'users',
    );
  }
}

extension SeriesQueryLinks on QueryBuilder<Series, QFilterCondition> {}

extension UserQueryLinks on QueryBuilder<User, QFilterCondition> {
  QueryBuilder<User, QAfterFilterCondition> group(FilterQuery<UserGroup> q) {
    return linkInternal(
      isar.userGroups,
      q,
      'group',
    );
  }
}

extension EventQueryWhereSortBy on QueryBuilder<Event, QSortBy> {
  QueryBuilder<Event, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Event, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }

  QueryBuilder<Event, QAfterSortBy> sortByState() {
    return addSortByInternal('state', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> sortByStateDesc() {
    return addSortByInternal('state', Sort.Desc);
  }
}

extension EventQueryWhereSortThenBy on QueryBuilder<Event, QSortThenBy> {
  QueryBuilder<Event, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Event, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }

  QueryBuilder<Event, QAfterSortBy> thenByState() {
    return addSortByInternal('state', Sort.Asc);
  }

  QueryBuilder<Event, QAfterSortBy> thenByStateDesc() {
    return addSortByInternal('state', Sort.Desc);
  }
}

extension UserGroupQueryWhereSortBy on QueryBuilder<UserGroup, QSortBy> {
  QueryBuilder<UserGroup, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByColor() {
    return addSortByInternal('color', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> sortByColorDesc() {
    return addSortByInternal('color', Sort.Desc);
  }
}

extension UserGroupQueryWhereSortThenBy
    on QueryBuilder<UserGroup, QSortThenBy> {
  QueryBuilder<UserGroup, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByColor() {
    return addSortByInternal('color', Sort.Asc);
  }

  QueryBuilder<UserGroup, QAfterSortBy> thenByColorDesc() {
    return addSortByInternal('color', Sort.Desc);
  }
}

extension SeriesQueryWhereSortBy on QueryBuilder<Series, QSortBy> {
  QueryBuilder<Series, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByColor() {
    return addSortByInternal('color', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByColorDesc() {
    return addSortByInternal('color', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }
}

extension SeriesQueryWhereSortThenBy on QueryBuilder<Series, QSortThenBy> {
  QueryBuilder<Series, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByColor() {
    return addSortByInternal('color', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByColorDesc() {
    return addSortByInternal('color', Sort.Desc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByDescription() {
    return addSortByInternal('description', Sort.Asc);
  }

  QueryBuilder<Series, QAfterSortBy> thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.Desc);
  }
}

extension UserQueryWhereSortBy on QueryBuilder<User, QSortBy> {
  QueryBuilder<User, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> sortByDisplayName() {
    return addSortByInternal('displayName', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByDisplayNameDesc() {
    return addSortByInternal('displayName', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> sortByEmail() {
    return addSortByInternal('email', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByEmailDesc() {
    return addSortByInternal('email', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> sortByPassword() {
    return addSortByInternal('password', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByPasswordDesc() {
    return addSortByInternal('password', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> sortByState() {
    return addSortByInternal('state', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> sortByStateDesc() {
    return addSortByInternal('state', Sort.Desc);
  }
}

extension UserQueryWhereSortThenBy on QueryBuilder<User, QSortThenBy> {
  QueryBuilder<User, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> thenByDisplayName() {
    return addSortByInternal('displayName', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByDisplayNameDesc() {
    return addSortByInternal('displayName', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> thenByEmail() {
    return addSortByInternal('email', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByEmailDesc() {
    return addSortByInternal('email', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> thenByPassword() {
    return addSortByInternal('password', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByPasswordDesc() {
    return addSortByInternal('password', Sort.Desc);
  }

  QueryBuilder<User, QAfterSortBy> thenByState() {
    return addSortByInternal('state', Sort.Asc);
  }

  QueryBuilder<User, QAfterSortBy> thenByStateDesc() {
    return addSortByInternal('state', Sort.Desc);
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, QDistinct> {
  QueryBuilder<Event, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Event, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<Event, QDistinct> distinctByState() {
    return addDistinctByInternal('state');
  }
}

extension UserGroupQueryWhereDistinct on QueryBuilder<UserGroup, QDistinct> {
  QueryBuilder<UserGroup, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<UserGroup, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<UserGroup, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<UserGroup, QDistinct> distinctByColor() {
    return addDistinctByInternal('color');
  }
}

extension SeriesQueryWhereDistinct on QueryBuilder<Series, QDistinct> {
  QueryBuilder<Series, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Series, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Series, QDistinct> distinctByColor() {
    return addDistinctByInternal('color');
  }

  QueryBuilder<Series, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }
}

extension UserQueryWhereDistinct on QueryBuilder<User, QDistinct> {
  QueryBuilder<User, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<User, QDistinct> distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<User, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('displayName', caseSensitive: caseSensitive);
  }

  QueryBuilder<User, QDistinct> distinctByEmail({bool caseSensitive = true}) {
    return addDistinctByInternal('email', caseSensitive: caseSensitive);
  }

  QueryBuilder<User, QDistinct> distinctByPassword(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('password', caseSensitive: caseSensitive);
  }

  QueryBuilder<User, QDistinct> distinctByState() {
    return addDistinctByInternal('state');
  }
}

extension EventQueryProperty on QueryBuilder<Event, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String, QQueryOperations> descriptionProperty() {
    return addPropertyName('description');
  }

  QueryBuilder<EventState, QQueryOperations> stateProperty() {
    return addPropertyName('state');
  }
}

extension UserGroupQueryProperty on QueryBuilder<UserGroup, QQueryProperty> {
  QueryBuilder<int, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String, QQueryOperations> descriptionProperty() {
    return addPropertyName('description');
  }

  QueryBuilder<int?, QQueryOperations> colorProperty() {
    return addPropertyName('color');
  }
}

extension SeriesQueryProperty on QueryBuilder<Series, QQueryProperty> {
  QueryBuilder<int, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<int?, QQueryOperations> colorProperty() {
    return addPropertyName('color');
  }

  QueryBuilder<String, QQueryOperations> descriptionProperty() {
    return addPropertyName('description');
  }
}

extension UserQueryProperty on QueryBuilder<User, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String, QQueryOperations> nameProperty() {
    return addPropertyName('name');
  }

  QueryBuilder<String?, QQueryOperations> displayNameProperty() {
    return addPropertyName('displayName');
  }

  QueryBuilder<String, QQueryOperations> emailProperty() {
    return addPropertyName('email');
  }

  QueryBuilder<String, QQueryOperations> passwordProperty() {
    return addPropertyName('password');
  }

  QueryBuilder<UserState, QQueryOperations> stateProperty() {
    return addPropertyName('state');
  }
}
