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

      /// test the login button
      expect(find.byKey(kKeyWelcomeScreenLoginButton), findsOneWidget);

      /// test the register button
      expect(find.byKey(kKeyWelcomeScreenRegisterButton), findsOneWidget);

      /// click the register button
      await tester.tap(find.byKey(kKeyWelcomeScreenRegisterButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test the register screen
      expect(find.byKey(kKeyRegisterPublicEmailField), findsOneWidget);
      expect(find.byKey(kKeyRegisterPublicPasswordField), findsOneWidget);
      expect(
          find.byKey(kKeyRegisterPublicConfirmPasswordField), findsOneWidget);
      expect(find.byKey(kKeyRegisterPublicRegisterButton), findsOneWidget);
      expect(find.byKey(kKeyRegisterPublicLoginButton), findsOneWidget);
    });
  });
}
