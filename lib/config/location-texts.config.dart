import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedTexts {
  final BuildContext context;

  LocalizedTexts(this.context);

  String get password => AppLocalizations.of(context)!.password;
  String get register => AppLocalizations.of(context)!.register;
  String get enter => AppLocalizations.of(context)!.enter;
  String get registerYourAccount => AppLocalizations.of(context)!.registerYourAccount;
  String get username => AppLocalizations.of(context)!.username;
  String get email => AppLocalizations.of(context)!.email;
  String get login => AppLocalizations.of(context)!.login;
  String get confirmPassword => AppLocalizations.of(context)!.confirmPassword;
  String get passwordConfirmation => AppLocalizations.of(context)!.passwordConfirmation;
  String get enterYourPassword => AppLocalizations.of(context)!.enterYourPassword;
  String get enterYourEmail => AppLocalizations.of(context)!.enterYourEmail;
  String get enterYourUsername => AppLocalizations.of(context)!.enterYourUsername;
  String get alreadyAUserLogin => AppLocalizations.of(context)!.alreadyAUserLogin;
  String get logout => AppLocalizations.of(context)!.logout;
  String get home => AppLocalizations.of(context)!.home;
  String get explore => AppLocalizations.of(context)!.explore;
  String get favorites => AppLocalizations.of(context)!.favorites;
  String get updates => AppLocalizations.of(context)!.updates;
  String get settings => AppLocalizations.of(context)!.settings;
  //------------------Errors
  String get unknownError => AppLocalizations.of(context)!.unknownError;
}
