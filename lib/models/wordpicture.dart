import 'package:Dimik/utils/downloader.dart';

class WordPictureList{
  List<WordPicture>_wpList;

  WordPictureList._({List<WordPicture>wpList}):
  _wpList=wpList;

  factory WordPictureList.fromJson(List<dynamic>parsedJson)
  {
    List<WordPicture> wpList = new List<WordPicture>();
    wpList = parsedJson.map((i)=>WordPicture.fromJson(i)).toList();

    return new WordPictureList._(
      wpList: wpList
    );
  }

  List<WordPicture>get wpList =>_wpList;

  void setTopicId(int topicId)
  {
    for(int i=0;i<wpList.length;i++)
      wpList[i].topicId=topicId;
  }

  void downloadImages() async {
    for (int i = 0; i < wpList.length; i++) {
      //it may be possible to further optimize this
      for(int j=0; j<wpList[i].imgLinks.length;j++)
      {   
          String name='WP-Topic'+'-'+wpList[i].topicId.toString()+'-'+(i+1).toString()+'-'+(j+1).toString();
          await wpList[i].downloadImage(name,j);
      }
      
    }
  }
}


class WordPicture {
  int _id;
  String _word;
  List<String> _imgLinks;
  int _correctOption;
  String _explanation;
  String _correctImage;
  int _topicId;
  WordPicture(
      this._word, this._imgLinks, this._correctOption, this._explanation);

  WordPicture._({String word,List<String>imgLinks,String correctImage,String explanation}):
  _word=word,
  _imgLinks=imgLinks,
  _correctImage=correctImage,
  _explanation=explanation;

  factory WordPicture.fromJson(Map<String,dynamic>json)
  {
      var temp=json['Option_links'];
      List<String>imageLinks=new List<String>.from(temp);
      return new WordPicture._(
        word:json['Word'],
        imgLinks: imageLinks,
        correctImage: json['Correct_image_link'],
        explanation: json['Meaning']
      );
  }

  String printOptions(){
    String res='';
    for(int i=0;i<_imgLinks.length;i++)
      res+=_imgLinks[i]+' ';
    return res;

  
  }

  String toString(){
    String res='';
    
    res+='Word: '+word+'\t';
    res+='Pictures: '+_concatenateListElements(imgLinks)+'\t';
    res+=correctImage;
    res+=explanation;
    return res;
  }

  void downloadImage(String name,int index) async {
    Downloader downloader = new Downloader();
    String filename = name + '.jpg'; //extension may change
    //String img;
    bool flag=false;
    if(imgLinks[index]==_correctImage)
      flag=true;
    print(imgLinks[index]);
    imgLinks[index] = await downloader.downloadImg(imgLinks[index], filename);
    print(imgLinks[index]);
    if(flag==true)
      _correctImage=imgLinks[index];
  }

  int get id =>_id;

  List<String> get imgLinks => _imgLinks;

  String get correctImage => _correctImage;

  int get correctOption{
    for(int i=0;i<imgLinks.length;i++)
    {
      if(imgLinks[i]==correctImage)
        _correctOption =  i+1;
    }
    return _correctOption ;
  }

  String get word => _word;

  String get explanation => _explanation;

  int get topicId => _topicId;

  set id(int id)
  {
    this._id=id;
  }

  set word(String word)
  {
    this._word=word;
  }

  set imgLinks(List<String>imgLinks)
  {
    this._imgLinks=imgLinks;
  }

  set explanation(String explanation)
  {
    this._explanation=explanation;
  }

  set correctImage(String correctImage)
  {
    this._correctImage=correctImage;
  }

  set topicId(int topicId)
  {
    this._topicId=topicId;
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

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['Id'] = _id;
    }
    map['Word'] = _word;
    map['Image_Options'] = _concatenateListElements(imgLinks);
    map['Image_Answer'] = _correctImage;
    map['Explanation'] = _explanation;
    map['Topic_Id'] = _topicId;
    return map;
  }

  WordPicture.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    this._word = map['Word'];
    this._imgLinks= map['Image_Options'].split('#');
    this._correctImage = map['Image_Answer'];
    this._explanation= map['Explanation'];
    this._topicId= map['Topic_Id'];
  }
}
