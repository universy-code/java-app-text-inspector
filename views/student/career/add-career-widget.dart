import 'package:flutter/material.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/constants/view-paths.dart';
import 'package:universy_mobile_client/com/universy/model/auth/auth.dart';
import 'package:universy_mobile_client/com/universy/model/institution/institution.dart';
import 'package:universy_mobile_client/com/universy/model/student/student-career.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/views/student/career/add-career-keys.dart';
import 'package:universy_mobile_client/com/universy/widgets/buttons/raised/rounded/circular/circular-rounded-raised-button.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/only/only-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/text/ellipsis/ellipsis-custom-text.dart';
import 'package:universy_mobile_client/com/universy/endpoint/universy/student/career/exceptions/student-career-already-exists.dart';
import 'package:universy_mobile_client/com/universy/endpoint/universy/student/career/exceptions/student-career-not-created.dart';

class AddCareerWidget extends StatefulWidget {
  final Institutions _institutions;

  const AddCareerWidget({Key key, Institutions institutions})
      : this._institutions = institutions,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddCareerWidgetState();
  }
}

class AddCareerWidgetState extends State<AddCareerWidget> {
  static const int FIRST = 0;

  final _formKeyLog = GlobalKey<FormState>();
  String _errorText;
  List<Institution> _institutions;
  Institution _selectedInstitution;
  CareerData _selectedCareer;
  int _selectedYear;

  AddCareerWidgetState();

  @override
  void initState() {
    _institutions = widget._institutions.institutions;
    _selectedInstitution = _institutions[FIRST];
    _selectedCareer = _selectedInstitution.careers[FIRST];
    _selectedYear = DateTime.now().year;
    _errorText = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeyLog,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 25.0,
          child: createStudentCareerFormContent(context),
        ));
  }

  Column createStudentCareerFormContent(BuildContext context) {
    return Column(children: <Widget>[
      OnlyEdgePaddedWidget.top(
          padding: 12.0,
          child: EllipsisCustomText.left(
              text: AppText.getInstance().get("addCareer.title"),
              textStyle: Theme.of(context).primaryTextTheme.subhead)),
      OnlyEdgePaddedWidget.top(
          padding: 8.0,
          child: EllipsisCustomText.left(
              key: ADD_CAREER_KEY_ERROR_TEXT,
              text: _errorText,
              textStyle: Theme.of(context).primaryTextTheme.body2)),
      SymmetricEdgePaddingWidget.vertical(
          paddingValue: 6.0, child: _createInstitutionDropDown()),
      SymmetricEdgePaddingWidget.vertical(
          key: ADD_CAREER_KEY_CAREER_FIELD,
          paddingValue: 6.0,
          child: _createCareersDropDown()),
      SymmetricEdgePaddingWidget.vertical(
          key: ADD_CAREER_KEY_YEAR_FIELD,
          paddingValue: 6.0,
          child: createYearDropDown()),
      SymmetricEdgePaddingWidget.vertical(
          paddingValue: 8.0,
          child: SizedBox(
              width: double.infinity,
              child: CircularRoundedRectangleRaisedButton.general(
                  key: ADD_CAREER_KEY_SUBMIT_BUTTON,
                  radius: 10,
                  onPressed: submitButtonOnPressedAction(context),
                  color: Colors.black54,
                  child: Row(
                    children: <Widget>[
                      SymmetricEdgePaddingWidget.horizontal(
                          paddingValue: 10,
                          child: Text(
                              AppText.getInstance().get("addCareer.submit"),
                              style: TextStyle(color: Colors.white))),
                      SymmetricEdgePaddingWidget.horizontal(
                          paddingValue: 10,
                          child:
                              Icon(Icons.arrow_forward, color: Colors.white)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )))),
    ]);
  }

  VoidCallback submitButtonOnPressedAction(BuildContext context) {
    return () async {
      try {
        Token token = await Services.of(context).tokenService().getToken();
        StudentCareer student = getStudentCareerFromTextFields(token.mail);
        await Services.of(context)
            .studentCareerService()
            .createStudentCareer(student);
        _navigateToMain(context);
      } on StudentCareerNotCreatedEndpointException {
        _errorText = _studentCareerNotCreatedMessage();
      } on StudentCareerAlreadyExistsEndpointException {
        _errorText = _studentCareerAlreadyExistsMessage();
      } catch (e) {
        _errorText =
            AppText.getInstance().get("addCareer.error.unexpectedError");
      }
    };
  }

  String _studentCareerNotCreatedMessage() =>
      AppText.getInstance().get("addCareer.error.studentCareerNotCreated");

  String _studentCareerAlreadyExistsMessage() =>
      AppText.getInstance().get("addCareer.error.studentCareerAlreadyExists");

  void _navigateToMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPathsConstants.MAIN);
  }

  StudentCareer getStudentCareerFromTextFields(String mail) {
    return StudentCareer.creation(mail, _selectedInstitution.institutionKey,
        _selectedCareer.careerCode, _selectedYear);
  }

  Widget _createInstitutionDropDown() {
    return DropdownButton(
      key: ADD_CAREER_KEY_INSTITUTE_FIELD,
      hint: Text(AppText.getInstance().get("addCareer.institute")),
      icon: Icon(Icons.account_balance),
      items: createInstitutionsDropDownItems(_institutions),
      value: _selectedInstitution.institutionKey,
      onChanged: updateSelectedInstitution,
    );
  }

  List<DropdownMenuItem<String>> createInstitutionsDropDownItems(
      List<Institution> institutions) {
    List<DropdownMenuItem<String>> items = new List();
    for (final institution in institutions) {
      items.add(new DropdownMenuItem<String>(
          value: institution.institutionKey,
          child: new SizedBox(width: 260.0, child: Text(institution.name))));
    }
    return items;
  }

  void updateSelectedInstitution(String value) {
    for (final institution in _institutions) {
      if (institution.institutionKey == value) {
        setState(() {
          this._selectedInstitution = institution;
          this._selectedCareer = _selectedInstitution.careers[FIRST];
        });
      }
    }
    throw Exception("No institution found with the key $value");
  }

  Widget _createCareersDropDown() {
    return DropdownButton(
      key: ADD_CAREER_KEY_INSTITUTE_FIELD,
      hint: Text(AppText.getInstance().get("addCareer.institute")),
      icon: Icon(Icons.art_track),
      items: createCareersDropDownItems(_selectedInstitution.careers),
      value: _selectedCareer.careerCode,
      isExpanded: true,
      onChanged: updateSelectedCareer,
    );
  }

  List<DropdownMenuItem<String>> createCareersDropDownItems(
      List<CareerData> careers) {
    List<DropdownMenuItem<String>> items = new List();
    for (final career in careers) {
      items.add(DropdownMenuItem<String>(
          value: career.careerCode,
          child: SizedBox(
              width: 260.0,
              child: Text(career.careerName, overflow: TextOverflow.clip))));
    }
    return items;
  }

  void updateSelectedCareer(Object value) {
    setState(() {
      this._selectedCareer = value;
    });
  }

  Widget createYearDropDown() {
    return DropdownButton(
      hint: Text(AppText.getInstance().get("addCareer.year")),
      icon: Icon(Icons.bookmark_border),
      items: createYearDropDownItems(createListYears()),
      onChanged: updateSelectedYear,
      value: _selectedYear,
    );
  }

  List<DropdownMenuItem<int>> createYearDropDownItems(List<int> years) {
    List<DropdownMenuItem<int>> items = List();
    for (final year in years) {
      items.add(DropdownMenuItem(
          value: year,
          child: SizedBox(width: 100.0, child: Text(year.toString()))));
    }
    return items;
  }

  void updateSelectedYear(int value) {
    setState(() {
      this._selectedYear = value;
    });
  }

  List<int> createListYears() {
    List<int> years = List<int>();
    years = [
      2000,
      2001,
      2002,
      2003,
      2004,
      2005,
      2006,
      2007,
      2008,
      2009,
      2010,
      2011,
      2012,
      2013,
      2014,
      2015,
      2016,
      2017,
      2018,
      2019
    ];
    return years;
  }
}
