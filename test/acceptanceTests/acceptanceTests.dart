import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/initialSignedIn.dart';
import 'steps/mainBar.dart';
import 'steps/signIn.dart';


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
      SignInPage(),

      CheckAllSignInBoxes(),
      FillEmailBox(),
      FillPasswordBox(),
      ClickSignIn(),
      ExplorePage(),

      CheckAllBarButtons(),
      ExploreTap(),
      goExplorePage()

    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptanceTests/runAcceptanceTests.dart";

  return GherkinRunner().execute(config);
}