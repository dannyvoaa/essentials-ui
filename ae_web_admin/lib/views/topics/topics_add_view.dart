import 'package:american_essentials_web_admin/api/api_topics_add.dart';
import 'package:american_essentials_web_admin/api/api_topics_update.dart';
import 'package:american_essentials_web_admin/common/api_helper.dart';
import 'package:american_essentials_web_admin/common/dimensions.dart';
import 'package:american_essentials_web_admin/common/transitions.dart';
import 'package:american_essentials_web_admin/common/validation.dart';
import 'package:american_essentials_web_admin/models/topics_model.dart';
import 'package:american_essentials_web_admin/theme/text_styles.dart';
import 'package:american_essentials_web_admin/views/topics/topics_view.dart';
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

class TopicsAddView extends StatefulWidget {
  static String routeId = 'TopicsAddView';

  // Setup any required variables
  final Map<String, Object> payload;

  // Initialize the view
  TopicsAddView({this.payload});

  @override
  _TopicsAddViewState createState() => _TopicsAddViewState();
}

class _TopicsAddViewState extends State<TopicsAddView> {
  // Setup any required variables
  GlobalKey<FormState> _formKey;
  TopicsModel _topicsModel = TopicsModel();
  _Mode _mode = _Mode.Add;

  @override
  void initState() {
    super.initState();

    // Check to see if a payload was supplied
    if (widget.payload != null) {
      // Switch the view to update mode
      _mode = _Mode.Update;

      // Save the calendar event model payload to a local variable
      _topicsModel = widget.payload['topicsModel'];
    }

    // Initialize the form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      stringHeaderTitle: _mode == _Mode.Add ? 'Add Topic' : 'Edit Topic',
      widgetBody: Form(
        child: Column(
          children: <Widget>[
            FormFieldTitle(
              stringTitle: 'Topic',
              titleStyle: TitleStyle.Title2,
            ),
            this._topicInformation(),
            SizedBox(
              height: Dimensions.size16px,
            ),
            RoundedButton(
              child:
                  Text(_mode == _Mode.Add ? 'Add Topic' : 'Edit Topic'),
              onPressed: () async {
                // Check to see if the form is valid
                if (_formKey.currentState.validate()) {
                  // Check to see if the view is in add or update mode
                  if (_mode == _Mode.Add) {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to insert the calendar event
                    ApiTopicsAddResult apiTopicsAddResult =
                        await ApiTopicsAdd.sendRequest(
                      topicsModel: _topicsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiTopicsAddResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: TopicsView.routeId,
                        );
                      },
                    );
                  } else {
                    // Show the Processing view
                    Processing.showProcessingView(buildContext: context);

                    // Attempt to update the calendar event
                    ApiTopicsUpdateResult apiTopicsUpdateResult =
                        await ApiTopicsUpdate.sendRequest(
                      topicsModel: _topicsModel,
                    );

                    // Execute the API Helper
                    ApiHelper.execute(
                      buildContext: context,
                      boolDismissProcessingOnError: true,
                      httpStatusCode: apiTopicsUpdateResult.statusCode,
                      onSuccess: () {
                        // Hide the processing view
                        Processing.dismiss(buildContext: context);

                        // Push to a new view with the fade animation
                        Transitions.pushReplacementWithFade(
                          buildContext: context,
                          stringRouteId: TopicsView.routeId,
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
  Widget _topicInformation() {
    return Column(
      children: <Widget>[
        FormFieldRow(
          stringTitle: 'Label',
          widget: Container(
            child: TextFormField(
              controller: TextEditingController(
                text: _topicsModel.label,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _topicsModel.label = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _topicsModel.label,
                  stringError: "Please enter the topic's label name",
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
                text: _topicsModel.value,
              ),
              onChanged: (String stringValue) {
                // Save the selected value to a local variable
                _topicsModel.value = stringValue;
              },
              validator: (String thing) {
                return Validation.notBlank(
                  stringInput: _topicsModel.value,
                  stringError: "Please enter the topic's value",
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