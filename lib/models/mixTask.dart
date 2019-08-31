
import 'package:Dimik/models/fb.dart';
import 'package:Dimik/models/sme.dart';
import 'package:Dimik/models/sm.dart';
import 'package:Dimik/models/mcq.dart';

class MixTaskList {
  List<MixTask> _sms;
  //List<MixTask> get list=>_sms;
  
  MixTaskList._({List<MixTask>sms}):
  _sms=sms;

  factory MixTaskList.fromJson(List<dynamic> parsedJson) {

    List<MixTask> sms = new List<MixTask>();
    sms = parsedJson.map((i)=>MixTask.fromJson(i)).toList();

    return new MixTaskList._(
      sms: sms
    );
  }

  List<MixTask>get sms =>_sms;
}


class MixTask{
  int _id;
  //int _answerCount;
  
  //
  String _first_segment;
  String _last_segment;
  String _broken_sentence;
  String _englishSentence;
  String _banglaSentence;

  String _taskName;
  //String _explanation;

  MixTask();

  MixTask.sme({int id,String first_segment,String last_segment,String broken_sentence,String englishSentence,String banglaSentence}):
  _id=id,
  this._first_segment = first_segment,
  this._last_segment = last_segment,
  this._broken_sentence = broken_sentence,
  this._englishSentence=englishSentence,
  this._banglaSentence=banglaSentence;

  MixTask.sm({int id,String englishSentence,String banglaSentence}):
  _id=id,
  this._englishSentence=englishSentence,
  this._banglaSentence=banglaSentence;

  factory MixTask.fromJson(Map<String, dynamic> json){
    
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);
    
    if(json['Task_Name'] == "sentenceMatchingEngToEng"){
      // return new SME.mixTask(
      //   first_segment: json['first_segment'],
      //   last_segment: json['last_segment'],
      //   broken_sentence: json['broken_sentence'],
      //   englishSentence: json['english_sentence'],
      //   banglaSentence: json['bangla_sentence'],);
      return new SME.fromJson(json);
    }
    else if(json['Task_Name'] == "mcq"){
      //return new MCQ.fromJson(json);
    }
    else if(json['Task_Name'] == "fillintheblanks"){
      // return new SME.mixTask(
      //   first_segment: json['first_segment'],
      //   last_segment: json['last_segment'],
      //   broken_sentence: json['broken_sentence'],
      //   englishSentence: json['english_sentence'],
      //   banglaSentence: json['bangla_sentence'],);
     // return new FB.fromJson(json);
    }

    else if(json['Task_Name'] == "sentenceMatching"){
      // return new SM.mixTask(
      //   question: json['broken_sentence'],
      //   englishSentence: json['english_sentence'],
      //   banglaSentence: json['bangla_sentence'],
      // );

      //return new SM.fromJson(json);
    }


    
    return MixTask();
    // return new MCQ.mixTask(
    //   //id: json["Id"],
    //     question: json["Question"],
    //     options: optionList,
    //     answer: json["Answer"],
    //     explanation: json["Explanation"]
    //   );
    
  } 

  //getter
  int get id =>_id;

  //String get question => _question;

  String get englishSentence => this._englishSentence;

  String get banglaSentence => this._banglaSentence;

  String get lastSegment => this._last_segment;

  String get firstSegment => this._first_segment;

  String get brokenSetence => this._broken_sentence;
  //String get explanation => _explanation;
  //setter
  set id(int smId){
    this._id=smId;
  }

  set brokenSentence(String brokenSentence){
    this._broken_sentence=brokenSentence;
  }

  set englishSentence(String englishSentence){
    this._englishSentence=englishSentence;
  }

  set banglaSentence(String banglaSentence){
    this._banglaSentence=banglaSentence;
  }

   set firstSegment(String firstSegment){
    this._first_segment=firstSegment;
  }

   set lastSegment(String lastSegment){
    this._last_segment=lastSegment;
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
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;
    
    return map;
  }

  MixTask.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    //this._question = map['Question'];
    this._englishSentence= map['EnglishSentence'];
    this._banglaSentence = map['BanglaSentence'];
    this._broken_sentence = map['BrokenSentence'];
    this._first_segment = map['FirstSegment'];
    this._last_segment = map['LastSegment'];

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