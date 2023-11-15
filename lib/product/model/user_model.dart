class UserModel {
  String? uid;
  String? email;
  String? userName;
  List<String>? tasks;

  UserModel({this.uid, this.email, this.userName, this.tasks});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['Uid'];
    email = json['email'];
    userName = json['userName'];
    tasks = json['tasks'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Uid'] = uid;
    data['email'] = email;
    data['userName'] = userName;
    data['tasks'] = tasks;
    return data;
  }
}
