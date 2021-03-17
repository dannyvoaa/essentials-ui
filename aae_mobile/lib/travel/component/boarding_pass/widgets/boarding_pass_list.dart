import 'package:aae/model/boarding_pass.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/boarding_pass/boarding_pass_view_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:aae/travel/component/boarding_pass/widgets/boarding_pass_card.dart';

import 'package:logging/logging.dart';

class BoardingPassList extends StatelessWidget {
  const BoardingPassList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final BoardingPassViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final BuiltList<BoardingPass> items = viewModel.boardingPasses;
    final int itemsLength = viewModel.boardingPasses.length;
    final log = Logger('$items');

    return Container(
        width: double.infinity,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 12 / 10,
                viewportFraction: itemsLength == 1 ? .92 : .8,
                initialPage: itemsLength - 1,
                enableInfiniteScroll: false,
                reverse: true,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: items.map((BoardingPass i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: BoardingPassCard(
                        boardingPass: i,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ));
  }
}
