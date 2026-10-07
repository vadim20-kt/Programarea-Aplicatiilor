import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app_lab3/main.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = TestHttpOverrides();

  testWidgets('App loads and renders home screen correctly', (WidgetTester tester) async {
    // Încărcăm aplicația
    await tester.pumpWidget(const MyApp());
    
    // Așteptăm finalizarea încărcării asincrone din JSON
    await tester.pumpAndSettle();

    // Verificăm că componentele principale ale ecranului sunt afișate
    expect(find.text("Good Morning"), findsOneWidget);
    expect(find.text("Today's Challenge"), findsOneWidget);
    expect(find.text("Featured Plan"), findsOneWidget);
    expect(find.text("Workout Programs"), findsOneWidget);
  });
}
