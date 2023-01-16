import 'package:wisdom/data/model/timeline_model.dart';

abstract class HomeRepository {
  Future<TimelineModel> getRandomWords();

  TimelineModel get timelineModel;
  set timeLineModel(TimelineModel model);
}
