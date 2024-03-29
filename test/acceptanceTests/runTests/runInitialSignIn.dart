import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import '../steps/initialSignedIn.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = const Duration(seconds: 50)
    ..features = [Glob(r"test/acceptanceTests/features/initialSignIn.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [
      CheckSignInButton(),
      ClickToSignIn(),
      SignInPage()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptanceTests/acceptanceTests.dart";

  return GherkinRunner().execute(config);
}