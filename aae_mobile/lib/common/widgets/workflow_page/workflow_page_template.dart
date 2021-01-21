import 'package:aae/common/widgets/rich_text/aee_tagged_text.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'workflow_footer_button/workflow_footer_button.dart';
import 'workflow_footer_button/workflow_footer_button_component.dart';
import 'workflow_page_image.dart';
import 'workflow_page_large_icon.dart';

var _bodyTextStyle = AaeTextStyles.body16Reg150;

/// A reusable [Widget] that contains a title, body, and a space for a custom
/// [Widget].
///
/// Padding will be added properly around all subviews.

class WorkflowPageTemplate extends StatelessWidget {
  /// The title text to show at the top of the view.
  final String title;

  /// The text alignment to use for the title.
  ///
  /// This is optional, it will default to [TextAlign.center].
  final TextAlign titleTextAlign;

  /// The body text to show underneath the title.
  ///
  /// This is optional, null here will hide the widget.
  /// Exclusive with [bodyTagged]. Setting both will cause an error.
  final String body;

  /// The body text to show underneath the title that has been tagged with
  /// text styling markers, such as the ones in [AaeTextSpanTags].
  ///
  /// This is optional, null here will hide the widget.
  /// /// Exclusive with [body]. Setting both will cause an error.
  final String bodyTagged;

  /// A map of tags to urls.
  ///
  /// Tags should appear in the [taggedText] in the form of
  /// '<tag>textToTag</tag>', just like [boldTag] or [underlineTag].
  ///
  /// Tapping on that tagged text will open a browser pointed at the url it is
  /// mapped to.
  ///
  /// See [AaeTaggedText] for more info.
  final Map<String, String> linkTagsToUrls;

  /// The text alignment to use for the body.
  ///
  /// This is optional, it will default to [TextAlign.center].
  final TextAlign bodyTextAlign;

  /// The non-scrollable child [Widget] to show underneath the title and body.
  ///
  /// This widget is exclusive with [scrollableChild], an error will be thrown
  /// if both are set.
  ///
  /// When using [child], the [title], [body], and [child] will scroll.
  ///
  /// This widget will be wrapped in appropriate horizontal and vertical
  /// padding per, and it won't run into the text above it or buttons
  /// in the footer.
  final Widget child;

  /// The scrollable child [Widget] to show underneath the title and body.
  ///
  /// This widget is exclusive with [child], an error will be thrown if both are
  /// set.
  ///
  /// When using [scrollableChild], the [title] and [body] will not scroll. This
  /// could be added in the future if we move to using [Sliver]s.
  ///
  /// This widget will be wrapped in appropriate horizontal and vertical
  /// padding, and it won't run into the text above it or buttons
  /// in the footer.
  final Widget scrollableChild;

  /// The [ButtonLayout] of the buttons in the footer.
  final ButtonLayout footerButtonLayout;

  /// The text for the primary (right) button.
  ///
  /// This is optional, null here will hide the widget.
  final String primaryButtonText;

  /// If the primary button is enabled or not.
  ///
  /// A disabled button will not fire its onTapped function.
  final bool primaryButtonEnabled;

  /// The callback to invoke when the primary (right) button is tapped.
  final GestureTapCallback onPrimaryButtonTapped;

  /// The text for the secondary (left) button.
  ///
  /// This is optional, null here will hide the widget.
  final String secondaryButtonText;

  /// If the secondary button is enabled or not.
  ///
  /// A disabled button will not fire its onTapped function.
  final bool secondaryButtonEnabled;

  /// The callback to invoke when the secondary (left) button is tapped.
  final GestureTapCallback onSecondaryButtonTapped;

  /// Creates a Workflow Page with an image below the title and body.
  ///
  /// Reference default constructor for default values.
  WorkflowPageTemplate.withImage({
    String title,
    ImageProvider image,
    TextAlign titleTextAlign,
    String body,
    String bodyTagged,
    Map<String, String> linkTagsToUrls,
    TextAlign bodyTextAlign,
    ButtonLayout footerButtonLayout,
    String primaryButtonText,
    bool primaryButtonEnabled,
    GestureTapCallback onPrimaryButtonTapped,
    String secondaryButtonText,
    bool secondaryButtonEnabled,
    GestureTapCallback onSecondaryButtonTapped,
  }) : this(
          title: title,
          titleTextAlign: titleTextAlign,
          body: body,
          bodyTagged: bodyTagged,
          linkTagsToUrls: linkTagsToUrls,
          bodyTextAlign: bodyTextAlign,
          footerButtonLayout: footerButtonLayout,
          primaryButtonText: primaryButtonText,
          primaryButtonEnabled: primaryButtonEnabled,
          onPrimaryButtonTapped: onPrimaryButtonTapped,
          secondaryButtonText: secondaryButtonText,
          secondaryButtonEnabled: secondaryButtonEnabled,
          onSecondaryButtonTapped: onSecondaryButtonTapped,
          // Use a [WorkflowPageImage] as the child.
          child: WorkflowPageImage(image: image),
        );

  /// Creates a Workflow Page with a large icon below the title and body.
  ///
  /// Reference default constructor for default values.
  WorkflowPageTemplate.withLargeIcon({
    String title,
    IconData icon,
    TextAlign titleTextAlign,
    String body,
    String bodyTagged,
    Map<String, String> linkTagsToUrls,
    TextAlign bodyTextAlign,
    ButtonLayout footerButtonLayout,
    String primaryButtonText,
    bool primaryButtonEnabled,
    GestureTapCallback onPrimaryButtonTapped,
    String secondaryButtonText,
    bool secondaryButtonEnabled,
    GestureTapCallback onSecondaryButtonTapped,
  }) : this(
          title: title,
          titleTextAlign: titleTextAlign,
          body: body,
          bodyTagged: bodyTagged,
          linkTagsToUrls: linkTagsToUrls,
          bodyTextAlign: bodyTextAlign,
          footerButtonLayout: footerButtonLayout,
          primaryButtonText: primaryButtonText,
          primaryButtonEnabled: primaryButtonEnabled,
          onPrimaryButtonTapped: onPrimaryButtonTapped,
          secondaryButtonText: secondaryButtonText,
          secondaryButtonEnabled: secondaryButtonEnabled,
          onSecondaryButtonTapped: onSecondaryButtonTapped,
          // Use a [WorkflowPageLargeIcon] as the child.
          child: WorkflowPageLargeIcon(icon: icon),
        );

  // Defaults are set in the initializer list so that named constructors don't
  // bypass them.
  WorkflowPageTemplate({
    this.title,
    TextAlign titleTextAlign,
    this.body,
    this.bodyTagged,
    Map<String, String> linkTagsToUrls,
    TextAlign bodyTextAlign,
    this.child,
    this.scrollableChild,
    ButtonLayout footerButtonLayout,
    this.primaryButtonText,
    bool primaryButtonEnabled,
    this.onPrimaryButtonTapped,
    this.secondaryButtonText,
    bool secondaryButtonEnabled,
    this.onSecondaryButtonTapped,
  })  : titleTextAlign = titleTextAlign ?? TextAlign.center,
        linkTagsToUrls = linkTagsToUrls ?? {},
        bodyTextAlign = bodyTextAlign ?? TextAlign.center,
        footerButtonLayout = footerButtonLayout ?? ButtonLayout.horizontal,
        primaryButtonEnabled = primaryButtonEnabled ?? true,
        secondaryButtonEnabled = secondaryButtonEnabled ?? true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AaeDimens.workflowContentSideMargin,
              ),
              child: _contentWidget(),
            ),
          ),
          WorkflowFooterButtonComponent(
            buttonLayout: footerButtonLayout,
            primaryButtonText: primaryButtonText,
            primaryButtonEnabled: primaryButtonEnabled,
            onPrimaryButtonTapped: onPrimaryButtonTapped,
            secondaryButtonText: secondaryButtonText,
            secondaryButtonEnabled: secondaryButtonEnabled,
            onSecondaryButtonTapped: onSecondaryButtonTapped,
          ),
        ],
      ),
    );
  }

  /// The entire contents of the workflow page, minus the buttons in the footer.
  Widget _contentWidget() {
    assert(!(child != null && scrollableChild != null),
        'Both child and scrollableChild provided, please choose one.');

    return scrollableChild != null
        ? _scrollableChildContents()
        : _fixedChildContents();
  }

  /// The entire contents of the workflow page, contained in a
  /// [Column].
  ///
  /// The [scrollableChild] is a ScrollView itself, which we want to take up the
  /// remaining space leftover from the title and body.
  Widget _scrollableChildContents() {
    final bodyWidget = _bodyWidget();
    // Container just for maximum content width.
    return Container(
      constraints: BoxConstraints(maxWidth: AaeDimens.contentMaxWidth),
      child: Column(
        children: [
          if (title != null) _titleWidget(),
          if (bodyWidget != null) bodyWidget,
          Expanded(child: scrollableChild),
        ],
      ),
    );
  }

  /// The entire contents of the workflow page, contained in a
  /// [SingleChildScrollView].
  ///
  /// The [child] cannot be a ScrollView itself if we're using this composition
  /// of Widgets. See the [_scrollableChildContents] method for more details.
  Widget _fixedChildContents() {
    final bodyWidget = _bodyWidget();
    return SingleChildScrollView(
      // Container just for maximum content width.
      child: Container(
        constraints: BoxConstraints(maxWidth: AaeDimens.contentMaxWidth),
        child: Column(
          children: <Widget>[
            if (title != null) _titleWidget(),
            if (bodyWidget != null) bodyWidget,
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  /// Title has padding on all 4 sides.
  ///
  /// Horizontal padding is applied in the parent widget.
  Widget _titleWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 10,
      ),
      child: Text(
        title,
        textAlign: titleTextAlign,
        style: AaeTextStyles.title24Med110,
      ),
    );
  }

  /// Body has padding on the bottom, left, and right.
  ///
  /// Horizontal padding is applied in the parent widget.
  /// This is done so that if the body isn't there, all of the padding is still
  /// correct for the child custom widget.
  Widget _bodyWidget() {
    assert(!(body != null && bodyTagged != null),
        'Both body and bodyTagged provided, please choose one.');

    Widget child;
    if (body != null && body.isNotEmpty) {
      child = Text(
        body,
        textAlign: bodyTextAlign,
        style: _bodyTextStyle,
      );
    } else if (bodyTagged != null && bodyTagged.isNotEmpty) {
      child = AaeTaggedText(
        taggedText: bodyTagged,
        linkTagsToUrls: linkTagsToUrls,
        textAlign: bodyTextAlign,
        baseTextStyle: _bodyTextStyle,
      );
    } else {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(
        top:10,
        bottom: AaeDimens.workflowBodyBottomMargin,
      ),
      child: child,
    );
  }
}
