// @dart=2.9

class Data {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Data({this.postId, this.id, this.name, this.email, this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
