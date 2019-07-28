import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/constants/regex.dart';
import 'package:universy_mobile_client/com/universy/endpoint/universy/student/profile/exceptions/student-not-saved.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/initials-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/services/services-declaration.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-events.dart';
import 'package:universy_mobile_client/com/universy/views/profile/student-profile-edit-keys.dart';
import 'package:universy_mobile_client/com/universy/widgets/buttons/raised/rounded/circular/circular-rounded-raised-button.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/decoration/input-decoration-builder.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/custom-text-form-field.dart';
import 'package:universy_mobile_client/com/universy/widgets/formfield/text/validators/text-form-validators-builders.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/only/only-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/scrollable/listview/scrollable-list-view.dart';
import 'package:universy_mobile_client/com/universy/widgets/snackbar/snack-bar-proxy.dart';
import 'package:universy_mobile_client/com/universy/widgets/text/ellipsis/ellipsis-custom-text.dart';

class StudentProfileEditWidget extends StatefulWidget {
  final Student _student;

  const StudentProfileEditWidget({Key key, @required Student student})
      : this._student = student,
        super(key: key);

  @override
  _StudentProfileEditState createState() => _StudentProfileEditState();
}

class _StudentProfileEditState extends State<StudentProfileEditWidget> {
  Student _student;
  String _errorText;
  final _formKeyLog = GlobalKey<FormState>();
  final TextEditingController _aliasController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();

  @override
  void initState() {
    _errorText = '';
    _student = widget._student;
    _nameController.text = _student.name;
    _lastNameController.text = _student.lastName;
    _aliasController.text = _student.alias;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScrollableListView(
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.topCenter,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 75,
            child: Form(
              key: _formKeyLog,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildCircleAvatar(),
                  _buildNameInput(),
                  _buildLastNameInput(),
                  _buildAliasInput(),
                  _buildErrorText(context),
                  _buildSaveButton(context),
                  _buildCancelButton(context)
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  OnlyEdgePaddedWidget _buildErrorText(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
        padding: 3.0,
        child: EllipsisCustomText.left(
            key: STUDENT_PROFILE_KEY_ERROR_TEXT,
            text: _errorText,
            textStyle: Theme.of(context).primaryTextTheme.body2));
  }

  Widget _buildCircleAvatar() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: CircleAvatar(
        child: Text(
          InitialsFormatter(_student).format(),
          style: TextStyle(fontSize: 40.0),
        ),
        minRadius: 55,
      ),
    );
  }

  Widget _buildNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField.reveal(
        key: STUDENT_PROFILE_KEY_NAME_FIELD,
        controller: _nameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
            regExp: RegexConstants.NOT_NUM_FORMAT_REGEX,
            patternMessage:
                AppText.getInstance().get("student.profile.name.notValid"),
            emptyMessage:
                AppText.getInstance().get("student.profile.name.required")),
        decorationBuilder: TextInputDecorationBuilder(
            AppText.getInstance().get("student.profile.name.inputMessage")),
      ),
    );
  }

  Widget _buildLastNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField.reveal(
        key: STUDENT_PROFILE_KEY_NAME_FIELD,
        controller: _lastNameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
            regExp: RegexConstants.NOT_NUM_FORMAT_REGEX,
            patternMessage:
                AppText.getInstance().get("student.profile.lastName.notValid"),
            emptyMessage:
                AppText.getInstance().get("student.profile.lastName.required")),
        decorationBuilder: TextInputDecorationBuilder(
            AppText.getInstance().get("student.profile.lastName.inputMessage")),
      ),
    );
  }

  Widget _buildAliasInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField.reveal(
        key: STUDENT_PROFILE_KEY_NAME_FIELD,
        controller: _aliasController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
            regExp: RegexConstants.NOT_NUM_FORMAT_REGEX,
            patternMessage:
                AppText.getInstance().get("student.profile.alias.notValid"),
            emptyMessage:
                AppText.getInstance().get("student.profile.alias.required")),
        decorationBuilder: TextInputDecorationBuilder(
            AppText.getInstance().get("student.profile.alias.inputMessage")),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CircularRoundedRectangleRaisedButton.general(
          key: STUDENT_PROFILE_KEY_CANCEL_BUTTON,
          radius: 10,
          onPressed: () => _navigateToProfileInfo(context),
          color: Colors.black26,
          child: SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 10,
              child: Text(
                  AppText.getInstance()
                      .get("student.profile.action.cancelButton"),
                  style: TextStyle(color: Colors.white))),
        ));
  }

  Widget _buildSaveButton(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5.0,
        child: SizedBox(
            width: double.infinity,
            child: CircularRoundedRectangleRaisedButton.general(
              key: STUDENT_PROFILE_KEY_SAVE_BUTTON,
              radius: 10,
              onPressed: _pressSaveProfileButton(context),
              color: Colors.deepPurple,
              child: SymmetricEdgePaddingWidget.horizontal(
                  paddingValue: 10,
                  child: Text(
                      AppText.getInstance()
                          .get("student.profile.action.saveButton"),
                      style: TextStyle(color: Colors.white))),
            )));
  }

  VoidCallback _pressSaveProfileButton(BuildContext context) {
    return () async {
      if (_formKeyLog.currentState.validate()) {
        SnackBarProxy snackBar = SnackBarProxy(context);
        _showSavingAccountMessage(snackBar);
        try {
          await _saveProfile(context);
          _navigateToProfileInfo(context);
        } on StudentNotSavedEndpointException {
          _errorText = _studentNotSavedMessage();
        } catch (e) {
          _errorText = _unexpectedErrorMessage();
        }
        _clearScreen(snackBar);
      }
    };
  }

  void _navigateToProfileInfo(BuildContext context) {
    final profileBloc = BlocProvider.of<StudentProfileBloc>(context);
    profileBloc.dispatch(InfoStudentProfileEvent(_student));
  }

  void _clearScreen(SnackBarProxy snackBar) {
    setState(() {
      _errorText = "";
      snackBar.hideCurrentSnackBar();
    });
  }

  void _showSavingAccountMessage(SnackBarProxy snackBar) {
    String savingProfileMessage = _savingMessage();
    snackBar.showSnackBar(seconds: 2, text: savingProfileMessage);
  }

  Future<void> _saveProfile(BuildContext context) async {
    Student student = _getStudentProfileFromTextFields();
    _student = student;
    await _getProfileService(context).saveStudentProfile(student);
  }

  ProfileService _getProfileService(BuildContext context) {
    return Services.of(context).profileService();
  }

  Student _getStudentProfileFromTextFields() {
    return Student(
        _nameController.text.trim(),
        _lastNameController.text.trim(),
        _aliasController.text.trim(),
        _student.mail,
        currentCareerKey: _student.currentCareerKey);
  }

  String _unexpectedErrorMessage() =>
      AppText.getInstance().get("student.profile.error.unexpectedError");

  String _savingMessage() =>
      AppText.getInstance().get("student.profile.action.saving");

  String _studentNotSavedMessage() =>
      AppText.getInstance().get("student.profile.error.studentNotSaved");
}
