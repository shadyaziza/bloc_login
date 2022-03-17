import 'package:bloc_login/data/constants/constant.dart';
import 'package:bloc_login/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Register - Forget - Login Test', () {
    testWidgets('Scrips Task', (tester) async {
      /// start the app
      await app.main();

      /// make sure the app is settled
      await tester.pumpAndSettle();

      expect(find.byKey(kKeyWelcomeScreenLoginButton), findsOneWidget);
      expect(find.byKey(kKeyWelcomeScreenRegisterButton), findsOneWidget);
    });
  });
}
