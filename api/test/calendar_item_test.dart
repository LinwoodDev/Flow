import 'package:flow_api/models/event/item/model.dart';
import 'package:test/test.dart';

void main() {
  group('CalendarItem.collidesWith', () {
    test('does not collide when one event ends at the next event start', () {
      final first = FixedCalendarItem(
        start: DateTime(2026, 5, 4, 9),
        end: DateTime(2026, 5, 4, 10),
      );
      final second = FixedCalendarItem(
        start: DateTime(2026, 5, 4, 10),
        end: DateTime(2026, 5, 4, 11),
      );

      expect(first.collidesWith(second), isFalse);
      expect(second.collidesWith(first), isFalse);
    });

    test('treats moments as contained instants', () {
      final appointment = FixedCalendarItem(
        start: DateTime(2026, 5, 4, 9),
        end: DateTime(2026, 5, 4, 10),
      );
      final insideMoment = FixedCalendarItem(
        start: DateTime(2026, 5, 4, 9, 30),
        end: DateTime(2026, 5, 4, 9, 30),
      );
      final boundaryMoment = FixedCalendarItem(
        start: DateTime(2026, 5, 4, 10),
        end: DateTime(2026, 5, 4, 10),
      );

      expect(appointment.collidesWith(insideMoment), isTrue);
      expect(insideMoment.collidesWith(appointment), isTrue);
      expect(appointment.collidesWith(boundaryMoment), isFalse);
      expect(boundaryMoment.collidesWith(appointment), isFalse);
    });
  });
}
