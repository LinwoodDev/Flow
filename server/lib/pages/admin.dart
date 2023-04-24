import 'package:jaspr/html.dart';

part 'admin.g.dart';

@app
class HomePage extends StatefulComponent with _$HomePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield p([
      text('Count: $count'),
    ]);

    yield button(
      events: {
        'click': (_) {
          print('clicked $count');
          setState(() => count++);
        }
      },
      [text('Increment')],
    );
  }
}
