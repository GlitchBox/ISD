import 'package:Dimik/models/mixTask.dart';

class SMEList {
  List<SME> _sms;

  SMEList._({List<SME> sms}) : _sms = sms;

  factory SMEList.fromJson(List<dynamic> parsedJson) {
    List<SME> sms = new List<SME>();
    sms = parsedJson.map((i) => SME.fromJson(i)).toList();

    return new SMEList._(sms: sms);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < sms.length; i++) {
      sms[i].topicId = topicId;
    }
  }

  List<SME> get sms => _sms;
}

class SME extends MixTask {
  int _id;
  //int _answerCount;

  String _first_segment;
  String _last_segment;
  String _broken_sentence;
  String _englishSentence;
  String _banglaSentence;
  int _topicId;
  //String _explanation;

  SME.mixTask(
      {int id,
      String first_segment,
      String last_segment,
      String broken_sentence,
      String englishSentence,
      String banglaSentence})
      :
        //SME._({int id,String first_segment,String last_segment,String broken_sentence,String englishSentence,String banglaSentence}):
        this._id = id,
        this._first_segment = first_segment,
        this._last_segment = last_segment,
        this._broken_sentence = broken_sentence,
        this._englishSentence = englishSentence,
        this._banglaSentence = banglaSentence;

  factory SME.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    return new SME.mixTask(
      //return new SME._(
      //id: g,
      first_segment: json['first_segment'],
      last_segment: json['last_segment'],
      broken_sentence: json['broken_sentence'],
      englishSentence: json['english_sentence'],
      banglaSentence: json['bangla_sentence'],
    );
  }

  //getter
  int get id => _id;

  //String get question => _question;

  String get englishSentence => this._englishSentence;

  String get banglaSentence => this._banglaSentence;

  String get lastSegment => this._last_segment;

  String get firstSegment => this._first_segment;

  String get brokenSetence => this._broken_sentence;

  int get topicId=> _topicId;
  //String get explanation => _explanation;
  //setter
  set id(int smId) {
    this._id = smId;
  }

  set brokenSentence(String brokenSentence) {
    this._broken_sentence = brokenSentence;
  }

  set englishSentence(String englishSentence) {
    this._englishSentence = englishSentence;
  }

  set banglaSentence(String banglaSentence) {
    this._banglaSentence = banglaSentence;
  }

  set firstSegment(String firstSegment) {
    this._first_segment = firstSegment;
  }

  set lastSegment(String lastSegment) {
    this._last_segment = lastSegment;
  }

  set topicId(int t){
    this._topicId = t;
  }

  /*
  set explanation(String explanation)
  {
    this._explanation=explanation;
  }

  String _concatenateListElements(List<String>list)
  { 
    if(list==null)
      return '';
    String res='';
    for(int i=0;i<list.length;i++)
    {
      if(i!=list.length-1)
        res=res+list[i]+'#';
      else
        res=res+list[i];
    }
    return res;
    
  }
  */
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = id;
    }
    //map['Question'] = question;
    map['EnglishSentence'] = _englishSentence;
    map['BanglaSentence'] = _banglaSentence;
    map['BrokenSentence'] = _broken_sentence;
    map['FirstSegment'] = _first_segment;
    map['LastSegment'] = _last_segment;
    map['Topic_Id'] = _topicId;
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;

    return map;
  }

  SME.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    //this._question = map['Question'];
    this._englishSentence = map['EnglishSentence'];
    this._banglaSentence = map['BanglaSentence'];
    this._broken_sentence = map['BrokenSentence'];
    this._first_segment = map['FirstSegment'];
    this._last_segment = map['LastSegment'];
    this._topicId = map['Topic_Id'];

    //this._explanation = map['Explanation'];
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
