import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/storage/remote/model.dart';

part 'settings.freezed.dart';

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
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode.name);
    prefs.setString('design', design);
    prefs.setBool('nativeTitleBar', nativeTitleBar);
    prefs.setString('locale', locale);
    prefs.setString('syncMode', syncMode.name);
    prefs.setStringList(
        'remotes', remotes.map((e) => json.encode(e.toJson())).toList());
  }
}

enum SyncMode { always, noMobile, manual }

enum SyncStatus { synced, syncing, error }

class SettingsCubit extends Cubit<FlowSettings> {
  SettingsCubit(SharedPreferences prefs) : super(FlowSettings.fromPrefs(prefs));

  Future<void> setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    return state.save();
  }

  Future<void> setDesign(String design) {
    emit(state.copyWith(design: design));
    return state.save();
  }

  Future<void> setNativeTitleBar(bool nativeTitleBar) {
    emit(state.copyWith(nativeTitleBar: nativeTitleBar));
    return state.save();
  }

  Future<void> setLocale(String locale) {
    emit(state.copyWith(locale: locale));
    return state.save();
  }

  Future<void> setSyncMode(SyncMode syncMode) {
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
}
