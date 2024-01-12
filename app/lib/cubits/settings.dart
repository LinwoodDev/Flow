import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/storage/remote/model.dart';

part 'settings.freezed.dart';

enum ThemeDensity {
  system,
  compact,
  comfortable,
  standard;

  VisualDensity toFlutter() => switch (this) {
        ThemeDensity.comfortable => VisualDensity.comfortable,
        ThemeDensity.compact => VisualDensity.compact,
        ThemeDensity.standard => VisualDensity.standard,
        ThemeDensity.system => VisualDensity.adaptivePlatformDensity,
      };
}

@freezed
class FlowSettings with _$FlowSettings {
  const FlowSettings._();

  const factory FlowSettings({
    @Default('') String locale,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool nativeTitleBar,
    @Default('') String design,
    @Default(SyncMode.noMobile) SyncMode syncMode,
    @Default([]) List<RemoteStorage> remotes,
    @Default(0) int startOfWeek,
    @Default(ThemeDensity.system) ThemeDensity density,
    @Default(false) bool highContrast,
  }) = _FlowSettings;

  factory FlowSettings.fromPrefs(SharedPreferences prefs) => FlowSettings(
        themeMode:
            ThemeMode.values.byName(prefs.getString('themeMode') ?? 'system'),
        design: prefs.getString('design') ?? '',
        nativeTitleBar: prefs.getBool('nativeTitleBar') ?? false,
        locale: prefs.getString('locale') ?? '',
        syncMode:
            SyncMode.values.byName(prefs.getString('syncMode') ?? 'noMobile'),
        remotes: prefs
                .getStringList('remotes')
                ?.map((e) => RemoteStorage.fromJson(json.decode(e)))
                .toList() ??
            [],
        startOfWeek: prefs.getInt('startOfWeek') ?? 0,
        density:
            ThemeDensity.values.byName(prefs.getString('density') ?? 'system'),
        highContrast: prefs.getBool('highContrast') ?? false,
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode.name);
    await prefs.setString('design', design);
    await prefs.setBool('nativeTitleBar', nativeTitleBar);
    await prefs.setString('locale', locale);
    await prefs.setString('syncMode', syncMode.name);
    await prefs.setStringList(
        'remotes', remotes.map((e) => json.encode(e.toJson())).toList());
    await prefs.setInt('startOfWeek', startOfWeek);
    await prefs.setString('density', density.name);
    await prefs.setBool('highContrast', highContrast);
  }
}

enum SyncMode { always, noMobile, manual }

enum SyncStatus { synced, syncing, error }

class SettingsCubit extends Cubit<FlowSettings> {
  SettingsCubit(SharedPreferences prefs) : super(FlowSettings.fromPrefs(prefs));

  Future<void> changeThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    return state.save();
  }

  Future<void> changeDesign(String design) {
    emit(state.copyWith(design: design));
    return state.save();
  }

  Future<void> changeNativeTitleBar(bool nativeTitleBar) {
    emit(state.copyWith(nativeTitleBar: nativeTitleBar));
    return state.save();
  }

  Future<void> changeLocale(String locale) {
    emit(state.copyWith(locale: locale));
    return state.save();
  }

  Future<void> changeSyncMode(SyncMode syncMode) {
    emit(state.copyWith(syncMode: syncMode));
    return state.save();
  }

  Future<void> addStorage(RemoteStorage remoteStorage) {
    emit(state.copyWith(remotes: [...state.remotes, remoteStorage]));
    return state.save();
  }

  RemoteStorage? getStorage(String name) {
    return state.remotes.firstWhereOrNull((e) => e.identifier == name);
  }

  Future<void> removeStorage(String name) {
    emit(state.copyWith(
        remotes: state.remotes.where((e) => e.toFilename() != name).toList()));
    return state.save();
  }

  Future<void> changeStartOfWeek(int startOfWeek) {
    emit(state.copyWith(startOfWeek: startOfWeek));
    return state.save();
  }

  Future<void> changeDensity(ThemeDensity density) {
    emit(state.copyWith(density: density));
    return state.save();
  }

  Future<void> changeHighContrast(bool highContrast) {
    emit(state.copyWith(highContrast: highContrast));
    return state.save();
  }
}
