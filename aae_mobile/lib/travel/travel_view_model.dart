/// Generates the view model that would be needed for your new component:
/// TODO (rpaglinawan): 
/* ° add fields to it as needed
*  ° read the README.md and run instructions under the Building header
*  ° add documentation to this file
*/

import 'package:built_value/built_value.dart';

part 'travel_view_model.g.dart';

/// View model representing a [TravelTravelView].
abstract class TravelTravelViewModel
    implements Built<TravelTravelViewModel, TravelTravelViewModelBuilder> {
 
 /* Finish body functions
 *
 */

  TravelTravelViewModel._();
  factory TravelTravelViewModel([updates(TravelTravelViewModelBuilder b)]) =
      _$TravelTravelViewModel;
}
