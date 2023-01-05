import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';

@freezed
class FlowSettings with _$FlowSettings {
  const FlowSettings._();

  const factory FlowSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool nativeTitleBar,
    @Default('') String design,
  }) = _FlowSettings;

  factory FlowSettings.fromPrefs(SharedPreferences prefs) => FlowSettings(
        themeMode:
            ThemeMode.values.byName(prefs.getString('themeMode') ?? 'system'),
        design: prefs.getString('design') ?? '',
        nativeTitleBar: prefs.getBool('nativeTitleBar') ?? false,
      );

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode.name);
    prefs.setString('design', design);
    prefs.setBool('nativeTitleBar', nativeTitleBar);
  }
}

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
}
