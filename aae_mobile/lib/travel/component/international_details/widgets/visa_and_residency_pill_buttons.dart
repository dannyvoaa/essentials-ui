import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/international_details/components/residency_card.dart';
import 'package:flutter/material.dart';

class VisaAndResidencyPillButtons extends StatefulWidget {
  final DocumentationType initialSelection;
  final Function onVisaPressed;
  final Function onResidencyPressed;

  VisaAndResidencyPillButtons({
    initialSelection,
    @required this.onVisaPressed,
    @required this.onResidencyPressed,
  }) : this.initialSelection = (initialSelection != null) ? initialSelection : DocumentationType.visa;

  @override
  _VisaAndResidencyPillButtonsState createState() => _VisaAndResidencyPillButtonsState();
}

class _VisaAndResidencyPillButtonsState extends State<VisaAndResidencyPillButtons> {
  DocumentationType _selection;

  @override
  Widget build(BuildContext context) {
    if (_selection == null) _selection = widget.initialSelection;

    return Row(
      children: [
        _buildPillButton(
          label: "US Residency Card",
          onPressed: _selection == DocumentationType.residencyCard ? null : () {
            setState(() {
              _selection = DocumentationType.residencyCard;
            });

            if (widget.onResidencyPressed != null) widget.onResidencyPressed();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: AaeDimens.baseUnit),
          child: _buildPillButton(
            label: "Visa",
            onPressed: _selection == DocumentationType.visa ? null : () {
              setState(() {
                _selection = DocumentationType.visa;
              });

              if (widget.onResidencyPressed != null) widget.onVisaPressed();
            },
          ),
        )
      ],
    );
  }

  Widget _buildPillButton({
    @required String label,
    @required Function onPressed,
  }) {
    return FlatButton(
      child: Text(
        label,
        style: onPressed == null ? AaeTextStyles.body14White : AaeTextStyles.body14DarkBlue,
      ),
      color: AaeColors.ultraLightGray,
      disabledColor: AaeColors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      onPressed: onPressed,
    );
  }
}
