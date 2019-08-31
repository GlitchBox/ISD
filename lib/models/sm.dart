class SMList {
  List<SM> _sms;

  SMList._({List<SM> sms}) : _sms = sms;

  factory SMList.fromJson(List<dynamic> parsedJson) {
    List<SM> sms = new List<SM>();
    sms = parsedJson.map((i) => SM.fromJson(i)).toList();

    // for (int ind = 0; ind < sms.length; ind++) {
    //   print(sms.elementAt(ind)._banglaSentence +
    //       " " +
    //       sms.elementAt(ind)._englishSentence);
    // }

    return new SMList._(sms: sms);
  }

  void setTopicId(int topicId) {
    for (int i = 0; i < sms.length; i++) {
      sms[i].topicId = topicId;
    }
  }

  List<SM> get sms => _sms;
}

class SM {
  int _id;
  //int _answerCount;
  //String _question;
  String _englishSentence;
  String _banglaSentence;
  int _topicId;
  //String _explanation;

  SM._({/*int id,*/ String english_sentence, String bangla_sentence})
      :
        //_id=id,
        //_question=question,
        _englishSentence = english_sentence,
        _banglaSentence = bangla_sentence;

  factory SM.fromJson(Map<String, dynamic> json) {
    //var dataList=json['data'];
    /*
    var temp= json['Options'];
    List<String>optionList= new List<String>.from(temp);
    var temp1= json['Answers'];
    List<String>answerList = new List<String>.from(temp1);
    */
    //var g=int.parse(json['id']);//Id of MockApi returns as a string.Will be changed when taking data from laravel
    //print(g.runtimeType);

    // print("here");
    // print(json['english_sentence']+json['bangla_sentence']);
    return new SM._(
      //id: g,
      //question: json['broken_sentence'],
      english_sentence: json['english_sentence'],
      bangla_sentence: json['bangla_sentence'],
    );
  }

  //getter
  int get id => _id;

  // String get question => _question;

  String get englishSentence => _englishSentence;

  String get banglaSentence => _banglaSentence;

  int get topicId => _topicId;

  //String get explanation => _explanation;
  //setter
  set id(int smId) {
    this._id = smId;
  }

  // set question(String smQuestion){
  //   this._question=smQuestion;
  // }

  set englishSentence(String englishSentence) {
    this._englishSentence = englishSentence;
  }

  set banglaSentence(String banglaSentence) {
    this._banglaSentence = banglaSentence;
  }

  set topicId(int t) {
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
    map['Topic_Id'] = _topicId;
    //map['AnswerCount'] = answerCount;
    //map['Explanation'] = explanation;

    return map;
  }

  SM.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    //this.answerCount = map['AnswerCount'];
    //this._question = map['Question'];
    this._englishSentence = map['EnglishSentence'];
    this._banglaSentence = map['BanglaSentence'];
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
