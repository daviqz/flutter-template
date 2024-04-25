class Account {
  final String? username;
  final String? email;
  final int? idAccountType;

  Account({
    this.username,
    this.email,
    this.idAccountType,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      email: json['email'],
      idAccountType: json['idAccountType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': username,
      'email': email,
      'idAccountType': idAccountType,
    };
  }
}
