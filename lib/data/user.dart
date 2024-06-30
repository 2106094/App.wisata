

class User {
  final int? id;
  final String username;
  final String password;

  late String name;
  late String bio;
  late String email;

  User({this.id, required this.username, required this.password, String? name, String? bio, String? email}) {
    this.name = name ?? ''; // Initialize name with a default empty string if not provided
    this.bio = bio ?? ''; // Initialize bio with a default empty string if not provided
    this.email = email ?? '$username@example.com'; // Initialize email with a default value if not provided
  }

  get userId => null;

  setBio(String value) {
    bio = value;
  }

  setEmail(String value) {
    email = value;
  }

  setName(String value) {
    name = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'bio': bio,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, name: $name, email: $email, bio: $bio}';
  }

  static fromJson(statu) {}
}
