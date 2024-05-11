import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedTexts {
  final BuildContext context;

  LocalizedTexts(this.context);
  //------------------General: xxxxxGENERALxxxxx
  // String get login => AppLocalizations.of(context)!.login;
  String get placeholder => 'Placeholder TODO';
  //------------------Form: xxxxxFORMxxxxx
  String get confirmPassword => AppLocalizations.of(context)!.confirmPassword;
  String get dontHaveAnAccountSignUp => AppLocalizations.of(context)!.dontHaveAnAccountSignUp;
  String get email => AppLocalizations.of(context)!.email;
  String get enterYourEmail => AppLocalizations.of(context)!.enterYourEmail;
  String get enterYourPassword => AppLocalizations.of(context)!.enterYourPassword;
  String get enterYourUsername => AppLocalizations.of(context)!.enterYourUsername;
  String get goBackToLogin => AppLocalizations.of(context)!.goBackToLogin;
  String get password => AppLocalizations.of(context)!.password;
  String get passwordConfirmation => AppLocalizations.of(context)!.passwordConfirmation;
  String get registerYourAccount => AppLocalizations.of(context)!.registerYourAccount;
  String get username => AppLocalizations.of(context)!.username;
  //------------------Button texts: xxxxxBUTTONxTEXTSxxxxx
  String get logout => AppLocalizations.of(context)!.logout;
  String get register => AppLocalizations.of(context)!.register;
  String get signIn => AppLocalizations.of(context)!.signIn;
  String get testAuthEndpoint => AppLocalizations.of(context)!.testAuthEndpoint;
  //------------------TabNavigation: xxxxxTABxNAVIGATIONxxxxx
  // String get explore => AppLocalizations.of(context)!.explore;
  // String get favorites => AppLocalizations.of(context)!.favorites;
  String get home => AppLocalizations.of(context)!.home;
  String get settings => AppLocalizations.of(context)!.settings;
  // String get updates => AppLocalizations.of(context)!.updates;
  //------------------Errors: xxxxxERRORSxxxxx
  String get unknownError => AppLocalizations.of(context)!.unknownError;
}
