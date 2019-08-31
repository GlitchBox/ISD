import 'package:scoped_model/scoped_model.dart';
import 'package:Dimik/ScopedModel/mergedmodel.dart';
import './smmodel.dart';
import 'package:Dimik/ScopedModel/SMEnglish.dart';

class MainModel extends Model
    with
        MergedModel,
        TaskModel,
        TopicModel,
        TruefalseModel,
        PictureWordModel,
        WordPictureModel,
        ListeningTaskModel,
        SATaskModel,
        QuizModel,
        SMModel,
        SMEnglish,
        JumbledModel {
  MainModel() {
    generateTasks();
  }
}
