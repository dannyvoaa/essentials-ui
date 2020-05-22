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
