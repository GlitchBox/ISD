import 'package:Dimik/ScopedModel/mergedmodel.dart';
import 'package:Dimik/ui/task/TrueFalse/true_false_task.dart';
import 'package:Dimik/ui/homePage/home.dart';
import 'package:Dimik/ui/gameover/gameover_view.dart';
import 'package:Dimik/ui/login/login_page.dart';
import 'package:Dimik/ui/task/kids_box/kids_box_intro.dart';
import 'package:Dimik/ui/task/kids_box/kids_box_task.dart';
import 'package:Dimik/ui/task/listening_game/listening_task.dart';
import 'package:Dimik/ui/task/pictureWord/picture_word_task.dart';
import 'package:Dimik/ui/profile/editprofile.dart';
import 'package:Dimik/ui/profile/profile_view.dart';
import 'package:Dimik/ui/task/synonym_antonym_matching/sa_task.dart';
import 'package:Dimik/ui/task/wordPicture/word_picture_task.dart';
import 'package:Dimik/ui/task/sentence_matching_task/SentenceMatchingView.dart';
import 'package:Dimik/ui/task/sentence_matching_task_eng/SentenceMatchingView.dart';
import 'package:Dimik/ui/task/jumble_Sentence/jumble_Sentence_view.dart';
import 'package:flutter/material.dart';
import 'package:Dimik/ui/task/Fill_in_the_gaps/Fill_in_the_gaps_view.dart';
import 'package:Dimik/ui/task/mcq_task/mcq_task_view.dart';


final routes = {
  '/gameover': (BuildContext context) => new GameOver(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LogInPage(),
  '/wordpicture': (BuildContext context) => WordPictureTask(),
  '/pictureword': (BuildContext context) => new PictureWordTask(),
  '/truefalse': (BuildContext context) => TrueFalseTask(),
  '/profile': (BuildContext context) => ProfilePage(),
  '/editprofile': (BuildContext context) => EditProfile(),
  '/kbintro': (BuildContext context) => KidsBoxIntro(),
  '/kbtask': (BuildContext context) => KidsBox(),
  '/lwtask': (BuildContext context) => ListeningTask(),
  '/satask': (BuildContext context) => new SATask(),
  '/sm' : (BuildContext context) => new SentenceMatchingView(),
  '/sme' : (BuildContext context) => new SentenceMatchingViewEng(),
  '/jumbled': (BuildContext context) => new jumbleSentenceView(),
  '/fillTheGaps': (BuildContext context) => new FillTheGapsView(),
  "/mcqTask": (BuildContext context) => new MCQView(),

};
