import 'package:flutter_test/flutter_test.dart';
import 'package:yatrarakshak/main.dart';

void main() {
  testWidgets('YatraRakshak app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const YatraRakshakApp());

    // Verify that our app starts with the correct title
    expect(find.text('YatraRakshak'), findsAtLeastNWidgets(1));
    
    // Verify that the home screen shows expected elements
    expect(find.text('Your Travel Safety Companion'), findsOneWidget);
    expect(find.text('Emergency SOS'), findsOneWidget);
    expect(find.text('Blockchain Identity'), findsOneWidget);
  });
  
  testWidgets('Navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const YatraRakshakApp());
    
    // Test bottom navigation elements exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Blockchain ID'), findsAtLeastNWidgets(1));
    expect(find.text('SOS'), findsOneWidget);
    expect(find.text('Geo Alerts'), findsOneWidget);
    expect(find.text('AI Assistant'), findsAtLeastNWidgets(1));
    expect(find.text('Contacts'), findsOneWidget);
    
    // Test that main content is visible
    expect(find.text('Your Travel Safety Companion'), findsOneWidget);
  });
}