import 'package:aae/common/commands/aae_command.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:built_value/built_value.dart';

part 'news_feed_list_item_view_model.g.dart';

/// View model for the the [NewsFeedListItem] widget.
abstract class NewsFeedListItemViewModel implements Built<NewsFeedListItemViewModel, NewsFeedListItemViewModelBuilder> {
  ///The title to display in the list item.
  String get displayName;

  ///The short body to display in the list item.
  String get shortBody;

  /// The image to display in the list item.
  Uri get image;

  String get author;

  /// The command to execute when the list item is tapped.
  @nullable
  AaeContextCommand get onTapped;

  NewsFeedListItemViewModel._();

  factory NewsFeedListItemViewModel([updates(NewsFeedListItemViewModelBuilder b)]) = _$NewsFeedListItemViewModel;

  static AaeContextCommand createNavigateToFullArticleCommand(String article) => navigateFromRootCommand(routes.buildArticlePageRoute(article: article));
}
