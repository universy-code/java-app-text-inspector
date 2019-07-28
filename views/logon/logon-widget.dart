import 'package:flutter/material.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/constants/regex.dart';
import 'package:universy_mobile_client/com/universy/constants/view-paths.dart';
import 'package:universy_mobile_client/com/universy/model/auth/auth.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/services/services-declaration.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/services/universy/logon/exceptions/credentials-invalid.dart';
import 'package:universy_mobile_client/com/universy/services/universy/logon/exceptions/mail-already-exists.dart';
import 'package:universy_mobile_client/com/universy/views/logon/logon-keys.dart';
import 'package:universy_mobile_client/com/universy/widgets/buttons/raised/rounded/circular/circular-rounded-raised-button.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/decoration/input-decoration-builder.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/custom-text-form-field.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/validators/text-form-validators-builders.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/only/only-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/snackbar/snack-bar-proxy.dart';
import 'package:universy_mobile_client/com/universy/widgets/text/ellipsis/ellipsis-custom-text.dart';

class LogOnWidget extends StatefulWidget {
  const LogOnWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LogOnWidgetState();
  }
}

class LogOnWidgetState extends State<LogOnWidget> {
  final _formKeyLog = GlobalKey<FormState>();
  final TextEditingController _mailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _aliasController = new TextEditingController();
  String _errorText;
  bool _passwordHidden;

  LogOnWidgetState();

  @override
  void initState() {
    _errorText = "";
    _passwordHidden = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeyLog,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 25.0,
          child: Column(children: <Widget>[
            OnlyEdgePaddedWidget.top(
                padding: 12.0,
                child: EllipsisCustomText.left(
                    text: AppText.getInstance().get("logon.sessionStart"),
                    textStyle: Theme.of(context).primaryTextTheme.subhead)),
            OnlyEdgePaddedWidget.top(
                padding: 8,
                child: EllipsisCustomText.left(
                    key: LOGON_KEY_ERROR_TEXT,
                    text: _errorText,
                    textStyle: Theme.of(context).primaryTextTheme.body2)),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField.reveal(
                key: LOGON_KEY_USER_FIELD,
                controller: _mailController,
                validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
                    regExp: RegexConstants.MAIL_FORMAT_REGEX,
                    patternMessage:
                        AppText.getInstance().get("logon.user.notValid"),
                    emptyMessage:
                        AppText.getInstance().get("logon.user.required")),
                decorationBuilder: TextInputDecorationBuilder(
                    AppText.getInstance().get("logon.user.inputMessage")),
              ),
            ),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField(
                  key: LOGON_KEY_PASSWORD_FIELD,
                  controller: _passwordController,
                  validatorBuilder:
                      PatternNotEmptyTextFormFieldValidatorBuilder(
                          regExp: RegexConstants.PASSWORD_FORMAT_REGEX,
                          patternMessage: AppText.getInstance()
                              .get("logon.password.notValid"),
                          emptyMessage: AppText.getInstance()
                              .get("logon.password.required")),
                  decorationBuilder: IconButtonInputDecorationBuilder(
                    labelText: AppText.getInstance()
                        .get("logon.password.inputMessage"),
                    icon: Icon(_passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: _changePasswordVisibilityOnPressedAction(),
                  ),
                  obscure: _passwordHidden),
            ),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField.reveal(
                key: LOGON_KEY_USER_FIELD,
                controller: _nameController,
                validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
                    regExp: RegexConstants.NOT_NUM_FORMAT_REGEX,
                    patternMessage:
                        AppText.getInstance().get("logon.name.notValid"),
                    emptyMessage:
                        AppText.getInstance().get("logon.name.required")),
                decorationBuilder: TextInputDecorationBuilder(
                    AppText.getInstance().get("logon.name.inputMessage")),
              ),
            ),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField.reveal(
                key: LOGON_KEY_ALIAS_FIELD,
                controller: _lastNameController,
                validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
                    regExp: RegexConstants.NOT_NUM_FORMAT_REGEX,
                    patternMessage:
                        AppText.getInstance().get("logon.lastName.notValid"),
                    emptyMessage:
                        AppText.getInstance().get("logon.lastName.required")),
                decorationBuilder: TextInputDecorationBuilder(
                    AppText.getInstance().get("logon.lastName.inputMessage")),
              ),
            ),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField.reveal(
                key: LOGON_KEY_USER_FIELD,
                controller: _aliasController,
                validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
                    regExp: RegexConstants.NOT_SYMBOLS_FORMAT_REGEX,
                    patternMessage:
                        AppText.getInstance().get("logon.alias.notValid"),
                    emptyMessage:
                        AppText.getInstance().get("logon.alias.required")),
                decorationBuilder: TextInputDecorationBuilder(
                    AppText.getInstance().get("logon.alias.inputMessage")),
              ),
            ),
            SymmetricEdgePaddingWidget.vertical(
                paddingValue: 8.0,
                child: SizedBox(
                    width: double.infinity,
                    child: CircularRoundedRectangleRaisedButton.general(
                        key: LOGON_KEY_SUBMIT_BUTTON,
                        radius: 10,
                        onPressed: _submitButtonOnPressedAction(context),
                        color: Colors.deepPurple,
                        child: Row(
                          children: <Widget>[
                            SymmetricEdgePaddingWidget.horizontal(
                                paddingValue: 10,
                                child: Text(
                                    AppText.getInstance().get("logon.submit"),
                                    style: TextStyle(color: Colors.white))),
                            SymmetricEdgePaddingWidget.horizontal(
                                paddingValue: 10,
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.white)),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )))),
          ]),
        ));
  }

  VoidCallback _changePasswordVisibilityOnPressedAction() {
    return () {
      setState(() {
        _passwordHidden = !_passwordHidden;
      });
    };
  }

  VoidCallback _submitButtonOnPressedAction(BuildContext context) {
    return () async {
      if (_formKeyLog.currentState.validate()) {
        FocusScope.of(context).unfocus();
        SnackBarProxy snackBar = SnackBarProxy(context);
        _showCreatingAccountMessage(snackBar);
        try {
          await _createAccount(context);
          await _createProfile(context);
          _navigateToHomeScreen(context);
        } on MailAlreadyExist {
          _errorText = _mailAlreadyExistsMessage();
        } on CredentialsInvalid {
          _errorText = _invalidCredentialsMessage();
        } catch (e) {
          _errorText = _unexpectedErrorMessage();
        }
        _showStateChange(snackBar);
      }
    };
  }

  void _showCreatingAccountMessage(SnackBarProxy snackBar) {
    snackBar.showSnackBar(seconds: 10, text: _creatingAccountMessage());
  }

  void _showStateChange(SnackBarProxy snackBar) {
    setState(() {
      _passwordController.clear();
      snackBar.hideCurrentSnackBar();
    });
  }

  Future<void> _createAccount(BuildContext context) async {
    User user = _getUserFromTextFields();
    await _getLogOnService(context).logOn(user);
  }

  User _getUserFromTextFields() {
    return User(_mailController.text.trim(), _passwordController.text.trim());
  }

  LogOnService _getLogOnService(BuildContext context) {
    return Services.of(context).logOnService();
  }

  Future<void> _createProfile(BuildContext context) async {
    Student student = _getStudentProfileFromTextFields();
    await _getProfileService(context).saveStudentProfile(student);
  }

  Student _getStudentProfileFromTextFields() {
    return Student(_nameController.text.trim(), _lastNameController.text.trim(),
        _aliasController.text.trim(), _mailController.text.trim());
  }

  ProfileService _getProfileService(BuildContext context) {
    return Services.of(context).profileService();
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPathsConstants.STUDENT_CAREER);
  }

  String _unexpectedErrorMessage() =>
      AppText.getInstance().get("logon.error.unexpectedError");

  String _invalidCredentialsMessage() =>
      AppText.getInstance().get("logon.error.credentialInvalid");

  String _mailAlreadyExistsMessage() =>
      AppText.getInstance().get("logon.error.mailAlreadyExist");

  String _creatingAccountMessage() =>
      AppText.getInstance().get("logon.creatingAccount");
}
