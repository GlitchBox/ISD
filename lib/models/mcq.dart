class MCQList {
  List<MCQ> _mcqs;

  MCQList({List<MCQ>mcqs}):
  _mcqs=mcqs;

  factory MCQList.fromJson(List<dynamic> parsedJson) {

    List<MCQ> tempMcqs = new List<MCQ>();
    tempMcqs = parsedJson.map((i)=>MCQ.fromJson(i)).toList();

    return new MCQList(
      mcqs: tempMcqs
    );
  }

  List<MCQ>get mcqs =>_mcqs;
}



class MCQ{

  //final int _mcqId;
  int _id;
  String _question;
  List<String> _options;
  String _answer;
  String _explanation;

  

  MCQ._({int id,String question,List<String> options,String answer,String explanation}):
      _id=id,
      _question=question,
      _options=options,
      _answer=answer,
      _explanation=explanation;

  factory MCQ.fromJson(Map<String,dynamic>json)
  { 
    var temp= json["Options"];
    List<String>optionList= new List<String>.from(temp);
    //for(int i=0;i<optionList.length;i++)
      //print(optionList[i]);
    return new MCQ._(
      //id: json["Id"],
      question: json["Question"],
      options: optionList,
      answer: json["Answer"],
      explanation: json["Explanation"]
    );
    
  }

  //getters and setters

  //getter
  int get id => _id;

  String get question => _question;

  List<String> get options => _options;

  String get answer => _answer;

  String get explanation => _explanation;
  //setters
  set id(int mcqId) {
    
      this._id = mcqId;
    
  }
  
  set question(String mcqQuestion) {
    
      this._question = mcqQuestion;
    
  }

  set options(List<String> mcqOptions) {
    
      this._options = mcqOptions;
    
  }

  set answer(String mcqAnswer) {
    
      this._answer = mcqAnswer;
    
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
    map['Question'] = _question;
    map['Options'] = _concatenateListElements(options);
    map['Answer'] = _answer;
    map['Explanation'] = _explanation;
    
    return map;
  }

  MCQ.fromMapObject(Map<String, dynamic> map) {
    this._id = map['Id'];
    this._question = map['Question'];
    this._options= map['Options'].split('#');
    this._answer = map['Answer'];
    this._explanation= map['Explanation'];
  }
  
  String toString(){
    String res='';
    res+=question+' ';
    res+=_concatenateListElements(options);
    res+=answer;
    res+=explanation;
    return res;
  }

String printOptions(){
    String res='';
    for(int i=0;i<options.length;i++)
      res+=options[i]+' ';
    return res;

  
  }
   
  

}