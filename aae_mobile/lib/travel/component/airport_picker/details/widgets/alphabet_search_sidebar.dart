import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

import '../airport_picker_view_model.dart';

// ignore: must_be_immutable
class AlphabetSearchSidebar extends StatelessWidget {
  final AirportPickerViewModel viewModel;
  final Function(String) onScrollTo;

  final GlobalKey _alphabetKey = GlobalKey();
  String lastSearchCharacter = 'A';

  AlphabetSearchSidebar({
    @required this.viewModel,
    @required this.onScrollTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 24,
      ),
      child: GestureDetector(
        onVerticalDragStart: _onDrag,
        onVerticalDragUpdate: _onDrag,
        //onVerticalDragEnd: _onDrag,
        key: _alphabetKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ..._buildAlphabetWidgets()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAlphabetWidgets() {
    var characterWidgets = List<Widget>();

    int currCharCode = "A".codeUnitAt(0);
    int z = "Z".codeUnitAt(0);
    while (currCharCode <= z) {
      String currChar = String.fromCharCode(currCharCode);
      bool active = viewModel?.charIndexes
          ?.containsKey(currChar) ?? false;

      characterWidgets.add(
        InkWell(
          onTap: () => onScrollTo(currChar),
          child: Container(
            margin: const EdgeInsets.only(
              top: 2.0,
              left: 16.0,
              right: 16.0,
              bottom: 2.0,
            ),
            padding: const EdgeInsets.all(0),
            child: Text(currChar,
              style: TextStyle(
                color: active ? AaeColors.blue : Color.fromRGBO(157, 166, 171, 1.0),
              ),
            ),
          ),
        ),
      );
      currCharCode++;
    }

    return characterWidgets;
  }

  _onDrag(details) {
    final alphabetContainer =
      _alphabetKey.currentContext.findRenderObject() as RenderBox;

    final letterHeight = alphabetContainer.size.height / 26;
    var index = (details.localPosition.dy / letterHeight).floor();
    if (index < 0) index = 0;
    if (index > 25) index = 25;

    final String char = String.fromCharCode("A".codeUnitAt(0) + index);

    if (lastSearchCharacter == char)
      return;

    lastSearchCharacter = char;
    onScrollTo(char);
  }
}

