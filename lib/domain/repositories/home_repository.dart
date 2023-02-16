import 'package:wisdom/data/model/subscribe_check_model.dart';
import 'package:wisdom/data/model/timeline_model.dart';

abstract class HomeRepository {
  Future<TimelineModel> getRandomWords();

  Future<Ad?> getAd();

  Future<SubscribeCheckModel?> checkSubscription();

  set timeLineModel(TimelineModel model);

  TimelineModel get timelineModel;
}
