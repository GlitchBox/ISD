import 'dart:ui';

import 'package:Dimik/utils/downloader.dart';

class MGList {
  List<MG> _sms;

  MGList._({List<MG> sms}) : _sms = sms;

  factory MGList.fromJson(List<dynamic> parsedJson) {
    List<MG> sms = new List<MG>();
    sms = parsedJson.map((i) => MG.fromJson(i)).toList();

    return new MGList._(sms: sms);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < _sms.length; i++) {
      _sms[i].topicId = topicId;
    }
  }

  void downloadImages() async {
    for (int i = 0; i < _sms.length; i++) {
      //it may be possible to further optimize this
      String name='PW-Topic'+'-'+_sms[i].topicId.toString()+(i+1).toString();
      await _sms[i].downloadImage(name);
    }
  }

  List<MG> get sms => _sms;
}

class MG {
  int _id;
  String _imageLink;
  List<String> _options;
  List<String> _correctAnswers;
  String _explanation;
  int _topicId;

  MG(
      {int id,
      String imageLink,
      List<String> options,
      List<String> correctAnswers})
      : _id = id,
        _imageLink = imageLink,
        _options = options,
        _correctAnswers = correctAnswers;

  MG._(
      {int id,
      String imageLink,
      List<String> options,
      List<String> correctAnswers})
      : _id = id,
        _imageLink = imageLink,
        _options = options,
        _correctAnswers = correctAnswers;

  factory MG.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    return new MG._(
      //id: g,
      imageLink: json['Image_link'],
      options: json['Options'],
      correctAnswers: json['Correct_answers'],
    );
  }

  //getter
  int get topicId => _topicId;
  int get id => _id;
  List<String> get options => _options;
  List<String> get correctAnswers => _correctAnswers;
  String get imageLink => _imageLink;
  String get explanation => _explanation;

  //setter
  set id(int smId) {
    this._id = smId;
  }

  set options(List<String> options) {
    this._options = options;
  }

  set imageLink(String imageLink) {
    this._imageLink = imageLink;
  }

  set banglaSentence(List<String> correctAnswers) {
    this._correctAnswers = correctAnswers;
  }

  set explanation(String explanation) {
    this._explanation = explanation;
  }

  set topicId(int topicId) {
    this._topicId = topicId;
  }

  String _concatenateListElements(List<String> list) {
    if (list == null) return '';
    String res = '';
    for (int i = 0; i < list.length; i++) {
      if (i != list.length - 1)
        res = res + list[i] + '#';
      else
        res = res + list[i];
    }
    return res;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = id;
    }
    map['ImageLink'] = _imageLink;
    map['Options'] = _concatenateListElements(_options);
    map['CorrectAnswers'] = _concatenateListElements(_correctAnswers);
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;
    map['Topic_Id'] = _topicId;

    return map;
  }

  void downloadImage(String name) async {
    Downloader downloader = new Downloader();
    String filename = name + '.jpg'; //extension may change
    print(_imageLink);
    _imageLink = await downloader.downloadImg(_imageLink, filename);
    print(_imageLink);
  }

  MG.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    this._imageLink = map['ImageLink'];
    this._options = map['Options'].split('#');
    this._correctAnswers = map['CorrectAnswers'].split('#');
    //this._explanation = map['Explanation'];
    this._topicId = map['Topic_Id'];
  }
  /*
  String toString()
  {
    String res='';
    print(_id.toString());
    
    res+=_id.toString();
    res+=_question;
    res+=_concatenateListElements(_options);
    res+=_concatenateListElements(_answers);
    res+=_explanation;
    return res;
  }
  */
}
