import 'package:bloc_login/data/constants/constant.dart';
import 'package:bloc_login/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const email = 'email@shady.com';
const password = 'password';
const newPassword = 'newPassword';
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

      /// fill textfields
      await tester.enterText(find.byKey(kKeyRegisterPublicEmailField), email);
      await tester.enterText(
          find.byKey(kKeyRegisterPublicPasswordField), password);
      await tester.enterText(
          find.byKey(kKeyRegisterPublicConfirmPasswordField), password);

      /// click the register button
      await tester.tap(find.byKey(kKeyRegisterPublicRegisterButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test welcome screen
      expect(find.byKey(kKeyWelcomeScreenLoginButton), findsOneWidget);
      expect(find.byKey(kKeyWelcomeScreenRegisterButton), findsOneWidget);

      /// click the login button
      await tester.tap(find.byKey(kKeyWelcomeScreenLoginButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test the login screen
      expect(find.byKey(kKeyLoginPublicEmailField), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicPasswordField), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicLoginButton), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicForgotPasswordButton), findsOneWidget);

      /// click forgot button
      await tester.tap(find.byKey(kKeyLoginPublicForgotPasswordButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test the forget screen
      expect(find.byKey(kKeyForgotPasswordPublicEmailField), findsOneWidget);
      expect(find.byKey(kKeyForgotPasswordPublicPasswordField), findsOneWidget);
      expect(find.byKey(kKeyForgotPasswordPublicResetButton), findsOneWidget);

      /// fill textfields
      await tester.enterText(
          find.byKey(kKeyForgotPasswordPublicEmailField), email);
      await tester.enterText(
          find.byKey(kKeyForgotPasswordPublicPasswordField), newPassword);

      /// click reset
      await tester.tap(find.byKey(kKeyForgotPasswordPublicResetButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test the login screen
      expect(find.byKey(kKeyLoginPublicEmailField), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicPasswordField), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicLoginButton), findsOneWidget);
      expect(find.byKey(kKeyLoginPublicForgotPasswordButton), findsOneWidget);

      /// fill textfields
      await tester.enterText(find.byKey(kKeyLoginPublicEmailField), email);
      await tester.enterText(
          find.byKey(kKeyLoginPublicPasswordField), newPassword);

      /// click login
      await tester.tap(find.byKey(kKeyLoginPublicLoginButton));

      /// make sure the app is settled
      await tester.pumpAndSettle();

      /// test the home screen
      expect(find.byKey(kKeyHomeScreenTitle), findsOneWidget);
      expect(find.byKey(kKeyHomeScreenLogoutButton), findsOneWidget);
    });
  });
}
