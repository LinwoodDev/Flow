import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/storage/remote/model.dart';

part 'settings.mapper.dart';

@MappableClass()
final class Alarm with AlarmMappable {
  final DateTime date;
  final String title;
  final String description;
  final bool isActive;

  const Alarm({
    required this.date,
    this.title = '',
    this.description = '',
    this.isActive = true,
  });
}

@MappableEnum()
enum ThemeDensity {
  system,
  maximize,
  desktop,
  compact,
  comfortable,
  standard;

  VisualDensity toFlutter() => switch (this) {
        ThemeDensity.maximize =>
          const VisualDensity(horizontal: -4, vertical: -4),
        ThemeDensity.desktop =>
          const VisualDensity(horizontal: -3, vertical: -3),
        ThemeDensity.compact => VisualDensity.compact,
        ThemeDensity.comfortable => VisualDensity.comfortable,
        ThemeDensity.standard => VisualDensity.standard,
        ThemeDensity.system => VisualDensity.adaptivePlatformDensity,
      };
}

final class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(Object value) {
    return ThemeMode.values.byName(value.toString());
  }

  @override
  String encode(ThemeMode value) {
    return value.name;
  }
}

@MappableClass(includeCustomMappers: [ThemeModeMapper()])
class FlowSettings with FlowSettingsMappable, LeapSettings {
  static const String localeKey = 'locale';
  final String locale;
  static const String themeModeKey = 'themeMode';
  final ThemeMode themeMode;
  static const String nativeTitleBarKey = 'nativeTitleBar';
  @override
  final bool nativeTitleBar;
  static const String designKey = 'design';
  final String design;
  static const String syncModeKey = 'syncMode';
  final SyncMode syncMode;
  static const String remotesKey = 'remotes';
  final List<RemoteStorage> remotes;
  static const String startOfWeekKey = 'startOfWeek';
  final int startOfWeek;
  static const String densityKey = 'density';
  final ThemeDensity density;
  static const String highContrastKey = 'highContrast';
  final bool highContrast;
  static const String alarmsKey = 'alarms';
  final List<Alarm> alarms;

  const FlowSettings({
    this.locale = '',
    this.themeMode = ThemeMode.system,
    this.nativeTitleBar = false,
    this.design = '',
    this.syncMode = SyncMode.noMobile,
    this.remotes = const [],
    this.startOfWeek = 0,
    this.density = ThemeDensity.system,
    this.highContrast = false,
    this.alarms = const [],
  });

  factory FlowSettings.fromPrefs(SharedPreferences prefs) => FlowSettings(
        themeMode:
            ThemeMode.values.byName(prefs.getString(themeModeKey) ?? 'system'),
        design: prefs.getString(designKey) ?? '',
        nativeTitleBar: prefs.getBool(nativeTitleBarKey) ?? false,
        locale: prefs.getString(localeKey) ?? '',
        syncMode:
            SyncMode.values.byName(prefs.getString(syncModeKey) ?? 'noMobile'),
        remotes: prefs
                .getStringList(remotesKey)
                ?.map((e) => RemoteStorageMapper.fromJson(e))
                .toList() ??
            [],
        startOfWeek: prefs.getInt(startOfWeekKey) ?? 0,
        density:
            ThemeDensity.values.byName(prefs.getString(densityKey) ?? 'system'),
        highContrast: prefs.getBool(highContrastKey) ?? false,
        alarms: prefs
                .getStringList(alarmsKey)
                ?.map((e) => AlarmMapper.fromJson(e))
                .toList() ??
            [],
      );
  Future<void> saveThemeMode(SharedPreferences prefs) =>
      prefs.setString(themeModeKey, themeMode.name);
  Future<void> saveDesign(SharedPreferences prefs) =>
      prefs.setString(designKey, design);
  Future<void> saveNativeTitleBar(SharedPreferences prefs) =>
      prefs.setBool(nativeTitleBarKey, nativeTitleBar);
  Future<void> saveLocale(SharedPreferences prefs) =>
      prefs.setString(localeKey, locale);
  Future<void> saveSyncMode(SharedPreferences prefs) =>
      prefs.setString(syncModeKey, syncMode.name);
  Future<void> saveRemotes(SharedPreferences prefs) => prefs.setStringList(
      remotesKey, remotes.map((e) => json.encode(e.toJson())).toList());
  Future<void> saveStartOfWeek(SharedPreferences prefs) =>
      prefs.setInt(startOfWeekKey, startOfWeek);
  Future<void> saveDensity(SharedPreferences prefs) =>
      prefs.setString(densityKey, density.name);
  Future<void> saveHighContrast(SharedPreferences prefs) =>
      prefs.setBool(highContrastKey, highContrast);
  Future<void> saveAlarms(SharedPreferences prefs) =>
      prefs.setStringList(alarmsKey, alarms.map((e) => e.toJson()).toList());

  Future<void> save(SharedPreferences prefs) async {
    await saveThemeMode(prefs);
    await saveDesign(prefs);
    await saveNativeTitleBar(prefs);
    await saveLocale(prefs);
    await saveSyncMode(prefs);
    await saveRemotes(prefs);
    await saveStartOfWeek(prefs);
    await saveDensity(prefs);
    await saveHighContrast(prefs);
    await saveAlarms(prefs);
  }
}

@MappableEnum()
enum SyncMode { always, noMobile, manual }

enum SyncStatus { synced, syncing, error }

class SettingsCubit extends Cubit<FlowSettings>
    with LeapSettingsBlocBaseMixin<FlowSettings> {
  SettingsCubit(SharedPreferences prefs) : super(FlowSettings.fromPrefs(prefs));

  Future<void> _runSave(
      Future<void> Function(SharedPreferences prefs) save) async {
    final prefs = await SharedPreferences.getInstance();
    await save(prefs);
  }

  Future<void> changeThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    return _runSave(state.saveThemeMode);
  }

  Future<void> changeDesign(String design) {
    final newState = state.copyWith(design: design);
    emit(newState);
    return _runSave(newState.saveDesign);
  }

  Future<void> changeNativeTitleBar(bool nativeTitleBar) {
    final newState = state.copyWith(nativeTitleBar: nativeTitleBar);
    emit(newState);
    return _runSave(newState.saveNativeTitleBar);
  }

  Future<void> changeLocale(String locale) {
    final newState = state.copyWith(locale: locale);
    emit(newState);
    return _runSave(newState.saveLocale);
  }

  Future<void> changeSyncMode(SyncMode syncMode) {
    final newState = state.copyWith(syncMode: syncMode);
    emit(newState);
    return _runSave(newState.saveSyncMode);
  }

  Future<void> addStorage(RemoteStorage remoteStorage) {
    final newState = state.copyWith(remotes: [...state.remotes, remoteStorage]);
    emit(newState);
    return _runSave(newState.saveRemotes);
  }

  RemoteStorage? getStorage(String name) {
    return state.remotes.firstWhereOrNull((e) => e.identifier == name);
  }

  Future<void> removeStorage(String name) {
    final newState = state.copyWith(
        remotes: state.remotes.where((e) => e.toFilename() != name).toList());
    emit(newState);
    return _runSave(newState.saveRemotes);
  }

  Future<void> changeStartOfWeek(int startOfWeek) {
    final newState = state.copyWith(startOfWeek: startOfWeek);
    emit(newState);
    return _runSave(newState.saveStartOfWeek);
  }

  Future<void> changeDensity(ThemeDensity density) {
    final newState = state.copyWith(density: density);
    emit(newState);
    return _runSave(newState.saveDensity);
  }

  Future<void> changeHighContrast(bool highContrast) {
    final newState = state.copyWith(highContrast: highContrast);
    emit(newState);
    return _runSave(newState.saveHighContrast);
  }

  Future<void> addAlarm(Alarm alarm) {
    final newState = state.copyWith(alarms: [...state.alarms, alarm]);
    emit(newState);
    return _runSave(newState.saveAlarms);
  }

  Future<void> removeAlarm(int index) {
    final newState =
        state.copyWith(alarms: List<Alarm>.from(state.alarms)..removeAt(index));
    emit(newState);
    return _runSave(newState.saveAlarms);
  }

  Future<void> changeAlarm(int index, Alarm alarm) {
    final newState = state.copyWith(
        alarms:
            state.alarms.mapIndexed((i, e) => i == index ? alarm : e).toList());
    emit(newState);
    return _runSave(newState.saveAlarms);
  }

  Future<void> importSettings(String data) {
    final settings = FlowSettingsMapper.fromJson(data).copyWith(
      remotes: state.remotes,
    );
    emit(settings);
    return _runSave(settings.save);
  }

  Future<String> exportSettings() async {
    return state.toJson();
  }
}
