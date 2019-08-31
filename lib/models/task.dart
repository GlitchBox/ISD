/*class Task {
  final String name;

  Task._({this.name});

  factory Task.fromJson(Map<String, dynamic> json) {
    return new Task._(
      name: json['task_name'],
    );
  }

  String getName(){
    return name;
  }
  // Task(this._token);

  // Task.map(dynamic obj) {
  //   this._token = obj["topic_name"];
  // }

  // String get token => _token;

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["topic_name"] = _token;

  //   return map;
  // }
}*/

class Task {
  final String name;

  Task({this.name});

  String getName() {
    return name;
  }
}
