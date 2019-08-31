import 'package:Dimik/data/db/mcq.dart';
import 'package:flutter/material.dart';

import '../../data/rest_ds.dart';
import '../../models/token.dart';
import '../../data/rest/login.dart';
import '../../data/rest/topic.dart'; // just for testing
import '../../data/rest/mcq.dart'; // just for testing
import '../../models/topic.dart';
import '../../models/mcq.dart';
import '../../data/db/topic.dart';

class TopicController {
  TopicRest topicRest = new TopicRest();
  TopicDatabaseHelper topicDatabaseHelper = new TopicDatabaseHelper();
  TopicList topicList;
  Future<List<Topic>> getTopicList(String token) async {
    int count = await topicDatabaseHelper.getCount();

    if (count == 0) //table is empty
    {
      topicList =
          await topicRest.getAllTopics(token).catchError((Object onError) {
        print(onError.toString());
        print("Pour some sugar on me");
      });
      await _insertTopicList(topicList);
    }
    List<Topic> result = await topicDatabaseHelper.getTopicList();
    return result;
  }

  Future<void> _insertTopicList(TopicList topicList) async {
    //await topicList.downloadImages(); //downloading of images occurring here
    List<Topic> tList = topicList.topics;
    for (int i = 0; i < tList.length; i++) {
      topicDatabaseHelper.insertTopic(tList[i]);
    }
  }

  Future<int> insertTopic(Topic topic) async {
    return topicDatabaseHelper.insertTopic(topic);
  }

  Future<int> updateTopic(Topic topic) async {
    return topicDatabaseHelper.updateTopic(topic);
  }

  Future<int> deleteTopic(int id) async {
    return topicDatabaseHelper.deleteTopic(id);
  }
}
