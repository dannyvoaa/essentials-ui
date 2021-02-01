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
      child: Html(data: textUpdate, style: {
        "html": Style(
          color: AaeColors.darkGray,
          fontSize: FontSize(18),
          margin: EdgeInsets.only(
            top: 6,
            bottom: 2,
            left: 0,
            right: 0,
          ),
        ),
        //card titles
        "body": Style(
          color: AaeColors.darkGray,
          fontSize: FontSize(18),
          margin: EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ),
      }),
    );
  }

  static Widget _buildShortBody(
      BuildContext context, String body, author, date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0, top: 6.0),
//          child: RichText(text: body),
//          child: Text(summary),
//          child: Html(
//            data: body,
//            defaultTextStyle: AaeTextStyles.smallSummary,
//          ),
          child: Html(
            data: body,
            style: {
              "html": Style(
//                backgroundColor: Colors.black12,
                color: AaeColors.mediumGray,
                fontSize: FontSize(14),
                height: 30,
                padding: EdgeInsets.all(0),
//                margin: EdgeInsets.only(top:0, bottom:2, left:0, right:0,),
              ),
              "body": Style(
//                backgroundColor: Colors.black12,
                color: AaeColors.mediumGray,
                fontSize: FontSize(14),
//                height: 42,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(
                  top: 0,
                  bottom: 2,
                  left: 0,
                  right: 0,
                ),
                alignment: Alignment(0, 0),
                textAlign: TextAlign.start,
                after: '...',
              ),
              "h1, h2, h3, h4, h5": Style(
                color: AaeColors.gray,
                fontSize: FontSize(14),
                fontWeight: FontWeight.w100,
              ),
              "a": Style(
                color: AaeColors.gray,
                textDecoration: TextDecoration.none,
              ),
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:8),
          child: Text(
            author,
//            'September 22, 2020',
            style: TextStyle(
              color: AaeColors.mediumGray,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
