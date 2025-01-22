import 'package:dart_mappable/dart_mappable.dart';
import 'package:flow_api/helpers/mapper.dart';

void setupAPI() {
  MapperContainer.globals
      .useAll([SecondsDateTimeMapper(), Uint8ListConverter()]);
}
