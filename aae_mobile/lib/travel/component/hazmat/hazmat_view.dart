import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/checkin/checkin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../checkin/widgets/checkin_commit_button.dart';

class HazmatView extends StatelessWidget {
  final CheckInViewModel viewModel;
  final Function onAgreeButtonClicked;

  HazmatView({this.viewModel, this.onAgreeButtonClicked});

  @override
  Widget build(BuildContext context) {
    final String text01 =
        '<p>Federal law forbids the carriage of hazardous materials aboard aircraft in your luggage or on your person. A violation can result in five years imprisonment and penalties of \$250,000 or more (49 U.S.C. 5124). American does not allow hoverboards or other lithium ion battery-powered personal transportation devices in checked or carry-on baggage.</p>'
        '<p>Hazardous materials include explosives, compressed gases, flammable liquids and solids, oxidizers, poisons, corrosive and radioactive materials. Examples: Paints, lighter fluid, fireworks, tear gases, oxygen bottles, and radio-pharmaceuticals. There are special exceptions for small quantities (up to 70 ounces total) of medicinal and toiletry articles carried in your luggage and certain smoking materials carried on your person.</p>'
        '<p><a href="http://www.faa.gov/about/initiatives/hazmat_safety/">Check with the FAA for more info.</a></p>';

    final String paragraph01 =
        'Federal law forbids the carriage of hazardous materials aboard aircraft in your luggage or on your person. A violation can result in five years imprisonment and penalties of \$250,000 or more (49 U.S.C. 5124). American does not allow hoverboards or other lithium ion battery-powered personal transportation devices in checked or carry-on baggage.';
    final String paragraph02 =
        'Hazardous materials include explosives, compressed gases, flammable liquids and solids, oxidizers, poisons, corrosive and radioactive materials. Examples: Paints, lighter fluid, fireworks, tear gases, oxygen bottles, and radio-pharmaceuticals. There are special exceptions for small quantities (up to 70 ounces total) of medicinal and toiletry articles carried in your luggage and certain smoking materials carried on your person.';
    final String link01 =
        '<p><a href="http://www.faa.gov/about/initiatives/hazmat_safety/">Check with the FAA for more info.</a></p>';
    final String text02 =
        'I understand the restrictions on hazardous materials in baggage.';

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(
              top: 28,
              bottom: 12,
              left: 26,
              right: 26,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hazardous materials',
                  style: AaeTextStyles.title20MediumGrayMed,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.clear,
                      size: 24,
                      color: AaeColors.gray,
                    ),
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                    top: 4,
                  ),
                  width: AaeDimens.baseUnit,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
//              height: 23,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: 12,
                    left: 26,
                    right: 26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Text(
                          paragraph01,
                          style: AaeTextStyles.body14Reg143,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Text(
                          paragraph02,
                          style: AaeTextStyles.body14Reg143,
                        ),
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              'Check with the FAA for more info',
                              style: AaeTextStyles.body14RegLink,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:10,left:3,),
                              child: Icon(
                                AmericanIconsv4_6.newPage,
                                size: 12,
                                color: AaeColors.blue,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          const url =
                              'http://www.faa.gov/about/initiatives/hazmat_safety/';
                          launch(url);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 18,
              right: 18,
            ),
            child: Divider(
              color: AaeColors.superUltralightGray,
              thickness: 2,
              height: 12,
            ),
          ),
          Container(
            height: 160,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 14,
                    bottom: 0,
                    left: 26,
                    right: 26,
                  ),
                  child: Text(
                    text02,
                    style: AaeTextStyles.body16Reg133,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 2,
                    left: 18,
                    right: 18,
                  ),
                  child: Container(
                    child: CheckInButton(
                      onClicked: () {
                        print('Check in button on haz mat popup pressed...');
                        viewModel.performCheckIn();

                        Navigator.of(context).pop();
                        if (onAgreeButtonClicked != null)
                          onAgreeButtonClicked();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
