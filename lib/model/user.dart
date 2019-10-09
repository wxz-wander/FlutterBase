///用户信息实体类
class User {
  String name;
  String avatarUrl;
  int age;
  String gender; //'男'or'女'
  User.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.avatarUrl = json['avatarUrl'];
    this.age = json['age'];
    this.gender = json['gender'];
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'avatarUrl': avatarUrl, 'age': age, 'gender': gender};
}
