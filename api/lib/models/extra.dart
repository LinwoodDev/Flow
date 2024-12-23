import 'package:dart_mappable/dart_mappable.dart';

part 'extra.mapper.dart';

@MappableClass()
sealed class ExtraProperties with ExtraPropertiesMappable {
  const ExtraProperties();
}

@MappableClass()
final class CalDavExtraProperties extends ExtraProperties
    with CalDavExtraPropertiesMappable {
  final String etag, path;

  const CalDavExtraProperties({
    required this.etag,
    required this.path,
  });
}
