import 'dart:math';

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

class Strings {
  static String randomString(int length) {
    final random = Random.secure();
    return List.generate(
        length, (index) => _chars[random.nextInt(_chars.length)]).join();
  }
}

extension StringHelper on String {
  String toDisplayString() {
    if (isEmpty) return '';
    return this[0].toUpperCase() +
        substring(1).replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => ' ${match.group(1)?.toLowerCase()}');
  }
}
