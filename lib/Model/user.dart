class User {
  final String id;
  final String username;
  final String mail;
  final String token;
  final String phoneNumber;
  final int credit;
  final List<String> votedfor;
  User({
    this.id,
    this.username,
    this.phoneNumber,
    this.mail,
    this.token,
    this.credit,
    this.votedfor,
  });
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        phoneNumber = data['phoneNumber'],
        mail = data['mail'],
        credit = data['credit'],
        token = data['token'],
        votedfor = data['votedfor'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
      'mail': mail,
      'token': token,
      'credit': credit,
      'votedfor': votedfor,
    };
  }
}
