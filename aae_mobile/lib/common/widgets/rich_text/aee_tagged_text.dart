import 'package:aae/common/url_launcher/url_launcher.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:quiver/core.dart';

/// A quality of life wrapper around [TaggedText] to make it easy to create
/// text views that have links, bolding, underlining, etc in them.
///

/// The String to use in a tagged text to make the text bold.
const boldTag = 'bold-tag';

/// The String to use in a tagged text to make the text underlined.
const underlineTag = 'underline-tag';

/// The String to use in a tagged text to make the text appear like a link,
/// by default.
///
/// If there are more than one link destination URLs in a String, this should
/// be avoided and custom tags should be used instead. Otherwise, the
/// [GestureRecognizer] won't know how to behave.

const linkTag = 'link-tag';

class AaeTaggedText extends StatelessWidget {
  /// The "tagged" text to render.
  ///
  /// See [boldTag], [underlineTag], and [linkTag] as examples for how to
  /// tag text for unique rendering.
  final String taggedText;

  /// A map of tags to urls.
  ///
  /// Tags should appear in the [taggedText] in the form of
  /// '<tag>textToTag</tag>', just like [boldTag] or [underlineTag].
  ///
  /// Tapping on that tagged text will open a browser pointed at the url it is
  /// mapped to.
  final Map<String, String> linkTagsToUrls;

  /// The text alignment to use for the tagged text.
  ///
  /// This is optional, it will default to [TextAlign.start].
  final TextAlign textAlign;
  final UrlLauncher urlLauncher;
  final TextStyle baseTextStyle;

  /// Creates a [AaeTaggedText] widget that handles text with a single
  /// [linkTag]'d text
  /// automatically.
  ///
  /// The String given to [taggedText] should have contain [linkTag]s in the
  /// proper format (ex: '<link-tag>linked text</link-tag>'). When the text
  /// within the [linkTag]s is tapped, a browser pointed to the [url] will open.
  ///
  /// If there are more than one link destination URLs in a String, this should
  /// be avoided and custom tags should be used instead. Otherwise, the
  /// [GestureRecognizer] won't know how to behave.
  AaeTaggedText.withUrl({
    Key key,
    @required String taggedText,
    @required String url,
    TextAlign textAlign,
    UrlLauncher urlLauncher,
    TextStyle baseTextStyle,
  }) : this(
          key: key,
          taggedText: taggedText,
          linkTagsToUrls: {linkTag: url},
          urlLauncher: urlLauncher,
          baseTextStyle: baseTextStyle,
        );

  // Defaults are set in the initializer list so that named constructors don't
  // bypass them.
  AaeTaggedText({
    Key key,
    @required this.taggedText,
    Map<String, String> linkTagsToUrls,
    TextAlign textAlign,
    UrlLauncher urlLauncher,
    TextStyle baseTextStyle,
  })  : textAlign = textAlign ?? TextAlign.start,
        linkTagsToUrls = linkTagsToUrls ?? {},
        urlLauncher = urlLauncher ?? UrlLauncher(),
        baseTextStyle = baseTextStyle ?? AaeTextStyles.b2SingleLine,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaggedText(
      content: taggedText,
      style: baseTextStyle,
      tagToTextSpanBuilder: _textSpanTags(),
      textAlign: textAlign,
    );
  }

  Map<String, TextSpanBuilder> _textSpanTags() {
    return <String, TextSpanBuilder>{}
      ..addAll({
        boldTag: (text) => TextSpan(
              text: text,
              style: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
        underlineTag: (text) => TextSpan(
              text: text,
              style:
                  baseTextStyle.copyWith(decoration: TextDecoration.underline),
            ),
      })
      ..addAll(
        linkTagsToUrls.map(
          (tag, url) => MapEntry(
            tag,
            (text) => TextSpan(
              text: text,
              style: baseTextStyle.copyWith(color: AaeColors.linkText),
              recognizer: _urlTapRecognizer(url),
            ),
          ),
        ),
      );
  }

  /// Builds a [TapGestureRecognizer] appropriate for the given [Optional].
  ///
  /// Throws an [ArgumentError] if [urlToLaunch] is null.
  TapGestureRecognizer _urlTapRecognizer(String urlToLaunch) {
    if (urlToLaunch == null) {
      throw ArgumentError('Tried to create a link span with no url.');
    }

    return TapGestureRecognizer()
      ..onTap = () => urlLauncher.launch(urlToLaunch);
  }
}
