import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_demo/main.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';
void main() {
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final listFinder = find.byType(ListView);

      await binding.traceAction(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });
  });
}


Future<void> Main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(
            data['scrolling_summary'] as Map<String, dynamic>);

        final summary = driver.TimelineSummary.summarize(timeline);

        await summary.writeTimelineToFile(
          'scrolling_summary',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}