import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

const _maxTitleLines = 2;

/// An item to be laid out in a vertical list, consisting of an image and info.
///
/// [infoPanelChildren] are laid out in a vertically-centered column to the
/// right of a thumbnail provided by [image]. Info panel will expand
/// horizontally to fill space.
class ListViewItem extends StatelessWidget {
  /// The image to display.
  final ImageProvider image;

  /// The widgets to display in a [Column] on the info panel.
  final List<Widget> infoPanelChildren;

  /// The callback to invoke when the widget is tapped.
  final GestureTapCallback onTapped;

  ListViewItem({
    @required this.image,
    @required this.infoPanelChildren,
    this.onTapped,
  });

  /// Creates a [ListViewItem] whose info panel consists of the item title and
  /// some metadata.
  ListViewItem.titleAndBody({
    @required ImageProvider image,
    @required String title,
    @required String body,
    @required String author,
    @required String date,
    @required BuildContext context,
    GestureTapCallback onTapped,
  }) : this(
            image: image,
            infoPanelChildren: <Widget>[
              _buildTitle(title),
              _buildShortBody(context, body, author, date),
            ],
            onTapped: onTapped);

  @override
  Widget build(BuildContext context) {
    return Padding(
//      padding: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
//              color: AaeColors.lightGray,
              offset: Offset(0.0, 2.0),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        width: 290,
//        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: MediaQuery(
            data: MediaQueryData(textScaleFactor: 1.0),
            child: GestureDetector(
              child: _buildListItemRow(context),
              onTap: onTapped,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItemRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImage(image),
        _buildInfoPanel(context, infoPanelChildren)
      ],
    );
  }

  Widget _buildImage(ImageProvider image) {
    return Container(
      height: 156,
      child: Image(
        image: image,
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context, List<Widget> children) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: AaeColors.white100,
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  static Widget _buildTitle(String text) {
    final String textUpdate = (text.replaceAll(new RegExp(r'\\'),''));
    return Padding(
      padding: const EdgeInsets.only(
        top: 6.0,
        bottom: 0.0,
      ),
      child: Text(
        textUpdate,
        style: AaeTextStyles.subtitle18Reg135,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static Widget _buildShortBody(
      BuildContext context, String body, author, date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 6.0),
          child: Text(
              body,
              style: AaeTextStyles.body14Reg143,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:8
          ),
          child: Text(
            author,
//            'September 22, 2020',
            style: TextStyle(
              color: AaeColors.mediumGray,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
