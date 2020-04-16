import 'package:american_essentials_web_admin/common/date_utilities.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/local_storage.dart';
import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/controls/drop_down_menu.dart';
import 'package:american_essentials_web_admin/widgets/general/form_row.dart';
import 'package:flutter/material.dart';

class UsersFiltersView extends StatefulWidget {
  @override
  _UsersFiltersViewState createState() => _UsersFiltersViewState();

  // Setup any required variables
  final Function() onApplyAction;

  // Initialize the widget
  UsersFiltersView({@required this.onApplyAction});
}

class _UsersFiltersViewState extends State<UsersFiltersView> {
  // Setup any required variables
  String _stringAaId = '';
  LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    // Initialize local storage
    _localStorage.initialize().then((value) {
      // Retreive the selected filters from local storage
      _stringAaId =
          _localStorage.sharedPreferences.getString('users.filters.aaId');

      // Update the application's state
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Filters',
                style: TextStyles.title1(),
              ),
              SizedBox(
                height: Dimensions.size16px,
              ),
              FormFieldRow(
                boolRightAlign: true,
                stringTitle: 'AA ID',
                widget: TextField(
                  controller: TextEditingController(
                    text: _stringAaId,
                  ),
                  onChanged: (String stringValue) {
                    _stringAaId = stringValue;
                  },
                ),
              ),
              FormFieldRow(
                boolRightAlign: true,
                stringTitle: '',
                widget: Column(
                  children: <Widget>[
                    Text(
                      'Instructions',
                      style: TextStyles.headline(),
                    ),
                    Text(' - Enter a full AA ID'),
                    Text(
                        ' - Or just part of it to return all matching results'),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Row(
                children: <Widget>[
                  RoundedButton(
                    child: Text('Reset'),
                    color: BrandColors.red,
                    onPressed: () {
                      // Reset the users filters to their defaults
                      // - A similar function exists in startup.dart:29
                      _stringAaId = '';

                      // Update the application's state
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  RoundedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      // Pop the view
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: Dimensions.size16px,
                  ),
                  RoundedButton(
                    child: Text('Apply'),
                    onPressed: () {
                      // Set the initial user filters
                      _localStorage.sharedPreferences
                          .setString('users.filters.aaId', _stringAaId);

                      // Execute the apply action
                      widget.onApplyAction();

                      // Pop the view
                      Navigator.pop(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
          constraints: BoxConstraints(
            maxHeight: Dimensions.size512px,
            maxWidth: Dimensions.size512px,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.size8px,
            ),
            color: BrandColors.white,
          ),
          padding: EdgeInsets.all(
            Dimensions.size16px,
          ),
        ),
      ),
      color: CustomColors.transparent,
    );
  }
}
