import 'package:flutter/material.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/constants/regex.dart';
import 'package:universy_mobile_client/com/universy/constants/view-paths.dart';
import 'package:universy_mobile_client/com/universy/model/auth/auth.dart';
import 'package:universy_mobile_client/com/universy/services/services-declaration.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/services/universy/login/exceptions/not-authorized.dart';
import 'package:universy_mobile_client/com/universy/views/login/login-keys.dart';
import 'package:universy_mobile_client/com/universy/widgets/buttons/raised/rounded/circular/circular-rounded-raised-button.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/decoration/input-decoration-builder.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/custom-text-form-field.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/validators/text-form-validators-builders.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/only/only-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/snackbar/snack-bar-proxy.dart';
import 'package:universy_mobile_client/com/universy/widgets/text/ellipsis/ellipsis-custom-text.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LogInWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _errorText;
  bool _passwordHidden;

  LoginWidgetState();

  @override
  void initState() {
    _errorText = "";
    _passwordHidden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 25.0,
          child: Column(children: <Widget>[
            OnlyEdgePaddedWidget.top(
                padding: 12.0,
                child: EllipsisCustomText.left(
                    text: AppText.getInstance().get("login.sessionStart"),
                    textStyle: Theme.of(context).primaryTextTheme.subhead)),
            OnlyEdgePaddedWidget.top(
                padding: 8,
                child: EllipsisCustomText.left(
                    key: LOGIN_KEY_ERROR_TEXT,
                    text: _errorText,
                    textStyle: Theme.of(context).primaryTextTheme.body2)),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField.reveal(
                key: LOGIN_KEY_USER_FIELD,
                controller: _userController,
                validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
                    regExp: RegexConstants.MAIL_FORMAT_REGEX,
                    patternMessage:
                        AppText.getInstance().get("login.user.notValid"),
                    emptyMessage:
                        AppText.getInstance().get("login.user.required")),
                decorationBuilder: TextInputDecorationBuilder(
                    AppText.getInstance().get("login.user.inputMessage")),
              ),
            ),
            SymmetricEdgePaddingWidget.vertical(
              paddingValue: 6.0,
              child: CustomTextFormField(
                  key: LOGIN_KEY_PASSWORD_FIELD,
                  controller: _passwordController,
                  validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(
                      AppText.getInstance().get("login.password.required")),
                  decorationBuilder: IconButtonInputDecorationBuilder(
                    labelText: AppText.getInstance()
                        .get("login.password.inputMessage"),
                    icon: Icon(_passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: _changePasswordVisibilityOnPressedAction(),
                  ),
                  obscure: _passwordHidden),
            ),
            SymmetricEdgePaddingWidget.vertical(
                paddingValue: 8.0,
                child: SizedBox(
                    width: double.infinity,
                    child: CircularRoundedRectangleRaisedButton.general(
                        key: LOGIN_KEY_SUBMIT_BUTTON,
                        radius: 10,
                        onPressed: submitButtonOnPressedAction(context),
                        color: Colors.black54,
                        child: Row(
                          children: <Widget>[
                            SymmetricEdgePaddingWidget.horizontal(
                                paddingValue: 10,
                                child: Text(
                                    AppText.getInstance().get("login.submit"),
                                    style: TextStyle(color: Colors.white))),
                            SymmetricEdgePaddingWidget.horizontal(
                                paddingValue: 10,
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.white)),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )))),
            SymmetricEdgePaddingWidget.vertical(
                paddingValue: 8.0,
                child: Row(children: <Widget>[
                  Column(children: <Widget>[
                    EllipsisCustomText.left(
                        text: (AppText.getInstance().get("login.labelLogon")),
                        textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black)),
                  ]),
                  Column(children: <Widget>[
                    new GestureDetector(
                        child: Text(
                            (AppText.getInstance().get("login.register")),
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => _navigateToLogonWidget(context))
                  ])
                ])),
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

  VoidCallback submitButtonOnPressedAction(BuildContext context) {
    return () async {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        SnackBarProxy snackBar = SnackBarProxy(context);
        _showVerifyingMessage(snackBar);
        try {
          await _logIn(context);
          _navigateToHomeScreen(context);
        } on NotAuthorized {
          _errorText = _notAuthorizeMessage();
        } catch (e) {
          _errorText = _unexpectedErrorMessage();
        }
        _showStateChange(snackBar);
      }
    };
  }

  void _showVerifyingMessage(SnackBarProxy snackBar) {
    snackBar.showSnackBar(seconds: 10, text: _verifyingMessage());
  }

  void _showStateChange(SnackBarProxy snackBar) {
    setState(() {
      _passwordController.clear();
      snackBar.hideCurrentSnackBar();
    });
  }

  Future<void> _logIn(BuildContext context) async {
    User user = _getUserFromTextFields();
    await _getLoginService(context).logIn(user);
  }

  User _getUserFromTextFields() {
    return User(_userController.text.trim(), _passwordController.text.trim());
  }

  LogInService _getLoginService(BuildContext context) {
    return Services.of(context).logInService();
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPathsConstants.MAIN);
  }

  void _navigateToLogonWidget(BuildContext context) {
    Navigator.pushNamed(context, ViewPathsConstants.LOGON);
  }

  String _unexpectedErrorMessage() =>
      AppText.getInstance().get("login.error.unexpectedError");

  String _notAuthorizeMessage() =>
      AppText.getInstance().get("login.error.notAuthorized");

  String _verifyingMessage() => AppText.getInstance().get("login.verifying");
}
