import 'package:flutter/material.dart';

/// Wrapper for all view dimensions we use in AAE.
/// This class only exists for easy importing!

class AaeDimens {
  // Returns the Safe Area inset for the device
  static EdgeInsets safeArea({@required BuildContext buildContext}) {
    return MediaQuery.of(buildContext).padding;
  }

  /// Returns a value of 16px by default
  static sizeDynamic_16px(
      {bool boolCompact = false, bool boolKeyboardVisible = false}) {
    // Check to see if an alternate dimension should be returned
    if (boolCompact && boolKeyboardVisible) {
      return 16.0;
    } else if (boolCompact) {
      return 16.0;
    } else if (boolKeyboardVisible) {
      return 16.0;
    } else {
      return 16.0;
    }
  }

  /// Returns a value of 32px by default
  static sizeDynamic_32px(
      {bool boolCompact = false, bool boolKeyboardVisible = false}) {
    // Check to see if an alternate dimension should be returned
    if (boolCompact && boolKeyboardVisible) {
      return sizeDynamic_16px();
    } else if (boolCompact) {
      return 16.0;
    } else if (boolKeyboardVisible) {
      return 16.0;
    } else {
      return 32.0;
    }
  }

  /// Returns a value of 96px by default
  static sizeDynamic_96px(
      {bool boolCompact = false, bool boolKeyboardVisible = false}) {
    // Check to see if an alternate dimension should be returned
    if (boolCompact && boolKeyboardVisible) {
      return sizeDynamic_16px();
    } else if (boolCompact) {
      return 48.0;
    } else if (boolKeyboardVisible) {
      return 16.0;
    } else {
      return 96.0;
    }
  }

  /// Returns a value of 48px by default
  static sizeDynamic_48px(
      {bool boolCompact = false, bool boolKeyboardVisible = false}) {
    // Check to see if an alternate dimension should be returned
    if (boolCompact && boolKeyboardVisible) {
      return sizeDynamic_16px();
    } else if (boolCompact) {
      return 24.0;
    } else if (boolKeyboardVisible) {
      return 16.0;
    } else {
      return 48.0;
    }
  }

  /// Returns a value of 128px by default
  static sizeDynamic_128px(
      {bool boolCompact = false, bool boolKeyboardVisible = false}) {
    // Check to see if an alternate dimension should be returned
    if (boolCompact && boolKeyboardVisible) {
      return sizeDynamic_16px();
    } else if (boolCompact) {
      return 64.0;
    } else if (boolKeyboardVisible) {
      return 16.0;
    } else {
      return 128.0;
    }
  }

  /// Check to see if the device is of a compact height.
  /// Any device smaller than an iPhone 7 will be considered compact
  static bool compactHeight({@required BuildContext buildContext}) {
    return MediaQuery.of(buildContext).size.height < 667;
  }

  static const sizeTableViewCell = 44.0;
  static const roundedCorner = 20.0;
  static const buttonContentPadding = 15.0;

  static const pageMarginLarge = EdgeInsets.fromLTRB(44.0, 0.0, 44.0, 0.0);

  static const noElevation = 0.0;

  static const baseUnit = 16.0;
  static const baseUnit3_4x = 0.75 * baseUnit;
  static const baseUnit2x = 2 * baseUnit;
  static const baseUnit3x = 3 * baseUnit;
  static const baseUnit4x = 4 * baseUnit;
  static const contentMargin = 12.0;
  static const contentWidth = 364.0;

  static const smallCardVerticalContentPadding = baseUnit3_4x;

  // List view item dimensions
  static const listViewItemHeight = 96.0;
  static const listViewThumbnailWidth = listViewItemHeight;
  static const listViewCornerRadius = 4.0;
  static const tallListViewThumbnailWidthHeight = 64.0;
  static const tallListViewThumbnailPaddingRight = 18.0;
  static const tallListViewPadding = 16.0;

  // Max content width
  static const contentMaxWidth = 460.0;

  static const regularButtonHeight = 48.0;
  static const regularButtonIconSize = 24.0;
  static const regularButtonHorizontalPadding = 16.0;
  static const regularButtonCornerRadius = 4.0;
  static const smallButtonHeight = 32.0;
  static const smallButtonIconSize = 20.0;
  static const smallButtonHorizontalPadding = 16.0;
  static const smallButtonCornerRadius = 4.0;

  // Workflow Page Template dimensions
  static const workflowTitleTopMargin = contentMargin;
  static const workflowTitleBottomMargin = baseUnit2x;
  static const workflowBodyBottomMargin = baseUnit2x;
  static const workflowContentSideMargin = contentMargin;
  static const workflowImageMaxHeight = 240.0;
  static const workflowImageBottomMargin = baseUnit2x;
  static const workflowButtonHorizontalFooterButtonSpacing = contentMargin;
  static const workflowButtonHorizontalFooterTopMargin = contentMargin;
  static const workflowButtonHorizontalFooterSideMargin = baseUnit2x;
  static const workflowButtonHorizontalFooterBottomMargin = baseUnit2x;
  static const workflowButtonVerticalFooterButtonSpacing = baseUnit;
  static const workflowButtonVerticalFooterTopMargin = baseUnit2x;
  static const workflowButtonVerticalFooterSideMargin = baseUnit2x;
  static const workflowButtonVerticalFooterBottomMargin = baseUnit2x;
  static const workflowLargeIconSize = 230.0;

  // Topics Page dimensions
  static const topicsIconSize = 176.0;
  static const topicsIconSpacing = contentMargin;
  static const topicsIconSelectionBorderSize = 4.0;
  static const topicsIconRadius = 24.0;

  // Workgroup selection page dimensions
  static const workgroupsButtonWidth = 180.0;
  static const workgroupsButtonHeight = 40.0;

  static const workgroupsLoadingSpinnerSize = 18.0;

  static const loginPageIconSize = 40.0;
  static const signInFailureIconSize = 72.0;

  // Recognition Page
  static const currentBalanceCardRadius = 19.0;
  static const currentBalanceCardHeight = 142.0;
  static const currentBalanceCardSpacing = 14.0;
  static const currentBalanceCardTopMargin = 20.0;

  // Drawer dimensions
  static const drawerHeight = 24.0;
  static const sizeDivider = 0.33;
  static const drawerButtonHeight = 40.0;
}
