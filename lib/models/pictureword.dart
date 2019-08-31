import 'dart:ui';

import 'package:Dimik/utils/downloader.dart';

class PictureWordList{
  List<PictureWord>_pwList;

  PictureWordList._({List<PictureWord>pwList}):
  _pwList=pwList;

  factory PictureWordList.fromJson(List<dynamic>parsedJson){
    List<PictureWord>pwList=new List<PictureWord>();
    pwList=parsedJson.map((i)=>PictureWord.fromJson(i)).toList();

    return new PictureWordList._(
      pwList: pwList
    );

  }

  void setTopicId(int topicId)
  {
    for(int i=0;i<pwList.length;i++)
    {
      pwList[i].topicId=topicId;
    }
  }

  void downloadImages() async {
    for (int i = 0; i < pwList.length; i++) {
      //it may be possible to further optimize this
      String name='PW-Topic'+'-'+pwList[i].topicId.toString()+(i+1).toString();
      await pwList[i].downloadImage(name);
    }
  }

  List<PictureWord> get pwList => _pwList; 

}


class PictureWord {
  int _id;
  String _imgLink;
  List<String> _options;
  String _answer;
  int _correctOption;
  String _explanation;
  int _topicId;

  PictureWord(
      this._imgLink, this._options, this._correctOption, this._explanation);

  PictureWord._({String imgLink,List<String>options,String answer,String explanation}):
  _imgLink=imgLink,
  _options=options,
  _answer=answer,
  _explanation=explanation;

  factory PictureWord.fromJson(Map<String,dynamic>json){
    var temp=json['Options'];
    var v1=json['Image_link'];
    print(v1.runtimeType);
    
    List<String>options=new List<String>.from(temp);
    return new PictureWord._(
      imgLink:json['Image_link'],
      options:options,
      answer:json['Answer'],
      explanation: json['Meaning']
     );

  }

  String printOptions(){
    String res='';
    for(int i=0;i<options.length;i++)
      res+=options[i]+' ';
    return res;

  
  }

  String toString(){
    String res='';
    res+=_imgLink;
    res+=_concatenateListElements(options);
    res+=_explanation;
    return res;
  }

  String get imgLink => _imgLink;

  int get id => _id;

  int get correctOption{
    for(int i=0;i<options.length;i++)
    {
      if(options[i]==answer)
        _correctOption =  i+1;
    }

    return _correctOption ;
  }

  int get topicId => _topicId;

  List<String> get options => _options;

  String get explanation => _explanation;

  String get answer => _answer;

  set id(int id)
  {
    this._id=id;
  }

  set imgLink(String imgLink)
  {
    this._imgLink=imgLink;
  }

  set options(List<String>options)
  {
    this._options=options;
  }

  set answer(String answer)
  {
    this._answer=answer;
  }

  set explanation(String explanation)
  {
    this._explanation=explanation;
  }

  set topicId(int topicId)
  {
    this._topicId=topicId;
  }

  void downloadImage(String name) async {
    Downloader downloader = new Downloader();
    String filename = name + '.jpg'; //extension may change
    print(imgLink);
    _imgLink = await downloader.downloadImg(imgLink, filename);
    print(imgLink);
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = _id;
    }
    map['Image'] = _imgLink;
    map['Options'] = _concatenateListElements(options);
    map['Answer'] = _answer;
    map['Explanation'] = _explanation;
    map['Topic_Id'] = _topicId;

    return map;
  }

  PictureWord.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    this._imgLink = map['Image'];
    this._options= map['Options'].split('#');
    this._answer = map['Answer'];
    this._explanation= map['Explanation'];
    this._topicId= map['Topic_Id'];
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

}

