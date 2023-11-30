abstract class User {
  User(
      {required this.name,
      required this.lastName,
      required this.age,
      required this.biography});
  String name;
  String lastName;
  int age;
  String biography;
}

abstract class UserCredentials {
  UserCredentials({required this.email, required this.password});

  String email;
  String password;
}
