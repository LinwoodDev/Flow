import 'package:jaspr/jaspr.dart';

part 'app.g.dart';

@client
class App extends StatelessComponent with _$App {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield const DomComponent(
      tag: 'p',
      child: Text('Hello World from Jaspr'),
    );
  }
}
