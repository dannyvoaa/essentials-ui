import 'package:american_essentials_web_admin/api/api_workgroups_add.dart';
import 'package:american_essentials_web_admin/api/api_workgroups_update.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/common/validation.dart';
import 'package:american_essentials_web_admin/models/workgroups_model.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/workgroups/workgroups_view.dart';
import 'package:american_essentials_web_admin/widgets/buttons/rounded_button.dart';
import 'package:american_essentials_web_admin/widgets/general/form_row.dart';
import 'package:american_essentials_web_admin/widgets/general/form_title.dart';
import 'package:american_essentials_web_admin/widgets/page_frame.dart';
import 'package:american_essentials_web_admin/widgets/processing.dart';
import 'package:flutter/material.dart';

enum _Mode {
  Add,
  Update,
}

class WorkgroupsAddView extends StatefulWidget {
  static String routeId = 'WorkgroupsAddView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  WorkgroupsAddView({this.payload});

  @override
  _WorkgroupsAddViewState createState() => _WorkgroupsAddViewState();
}

class _WorkgroupsAddViewState extends State<WorkgroupsAddView> {
  // Setup any required variables
  GlobalKey<FormState> _formKey;
  WorkgroupsModel _workgroupsModel = WorkgroupsModel();
  _Mode _mode = _Mode.Add;

  @override
  void initState() {
    super.initState();

    // Check to see if a payload was supplied
    if (widget.payload != null) {
      // Switch the view to update mode
      _mode = _Mode.Update;

      // Save the model payload to a local variable
      _workgroupsModel = widget.payload['workgroupsModel'];
    }

    // Initialize the form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      stringHeaderTitle: _mode == _Mode.Add ? 'Add Workgroup' : 'Edit Workgroup',
      widgetBody: Form(
        child: Column(
          children: <Widget>[
            FormFieldTitle(
              stringTitle: 'Workgroup',
              titleStyle: TitleStyle.Title2,
            ),
            this._workgroupInformation(),
            SizedBox(
              height: Dimensions.size16px,
            ),
            RoundedButton(
              child:
                  Text(_mode == _Mode.Add ? 'Add Workgroup' : 'Edit Workgroup'),
              onPressed: () async {
                // Check to see if the form is valid
                if (_formKey.currentState.validate()) {
                  // Check to see if the view is in add or update mode
                  if (_mode == _Mode.Add) {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to insert the calendar event
                    ApiWorkgroupsAddResult apiWorkgroupsAddResult =
                        await ApiWorkgroupsAdd.sendRequest(
                      workgroupsModel: _workgroupsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiWorkgroupsAddResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: WorkgroupsView.routeId,
                        );
                      },
                    );
                  } else {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to update the calendar event
                    ApiWorkgroupsUpdateResult apiWorkgroupsUpdateResult =
                        await ApiWorkgroupsUpdate.sendRequest(
                      workgroupsModel: _workgroupsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiWorkgroupsUpdateResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: WorkgroupsView.routeId,
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        key: this._formKey,
      ),
    );
  }

  // MARK: - Widgets

  /// Information regarding the item to be added
  Widget _workgroupInformation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Label',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _workgroupsModel.label,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _workgroupsModel.label = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _workgroupsModel.label,
                  stringError: "Please enter the workgroup's label name",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        ),
        FormFieldRow(
          stringTitle: 'Value',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _workgroupsModel.value,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _workgroupsModel.value = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _workgroupsModel.value,
                  stringError: "Please enter the workgroup's value",
                );
              },
            ),
            constraints: BoxConstraints(
              maxWidth: Dimensions.textFieldCommon,
              minWidth: Dimensions.textFieldCommon,
            ),
          ),
        )
      ],
    );
  }
}