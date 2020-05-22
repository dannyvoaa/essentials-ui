import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    GestureTapCallback onTapped,
  }) : this(
            image: image,
            infoPanelChildren: <Widget>[
              _buildTitle(title),
              _buildShortBody(body, author),
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
              offset: Offset(0.0, 0.0),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        width: 290,
//        height: 300,
        child: GestureDetector(
          child: _buildListItemRow(),
          onTap: onTapped,
        ),
      ),
    );
  }

  Widget _buildListItemRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImage(image),
        _buildInfoPanel(infoPanelChildren)
      ],
    );
  }

  Widget _buildImage(ImageProvider image) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 156,
//        maxWidth: 272,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
          image: image,
        ),
      ),
    );
  }

  Widget _buildInfoPanel(List<Widget> children) {
    return Container(
      color: AaeColors.white,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  static Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Html(
        data: text,
        useRichText: false,
        defaultTextStyle: AaeTextStyles.smallHeadline,
      ),
//      child: Text(
//        text,
//        maxLines: 1,
//        overflow: TextOverflow.ellipsis,
//        style: TextStyle(
//            color: AaeColors.black, fontSize: 17, fontWeight: FontWeight.w500),
//      ),
    );
  }

  static Widget _buildShortBody(String body, author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
            child: Html(
              data: body,
//              padding: EdgeInsets.all(8.0),
              defaultTextStyle: AaeTextStyles.smallSummary,
            )
//          child: Text(
//            body,
//            maxLines: _maxTitleLines,
//            overflow: TextOverflow.ellipsis,
//            style: TextStyle(fontSize: 12),
//          ),
            ),
//        Padding(
//          padding: const EdgeInsets.only(top: 8.0, bottom: 3),
//          child: Text(
//            'By $author',
//            style: TextStyle(
//              fontSize: 10,
//            ),
//          ),
//        )
      ],
    );
  }
}
