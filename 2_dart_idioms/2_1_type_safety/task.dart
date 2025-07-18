class UserId {
  UserId(this.value) {
    if (value.length != 36) {
      throw const FormatException('Must be 36 characters long');
    }
  }
  final String value;

  @override
  String toString() => value;
}

class UserName {
  UserName(this.value) {
    if (value.length < 4 || value.length > 32 || _containsNumber(value)) {
      throw const FormatException(
          'UserName must be 4-32 characters, letters only');
    }
  }

  final String value;

  static final RegExp _letterOnlyRegExp = RegExp(r'^[a-zA-Z]+$');

  bool _containsNumber(String input) => !_letterOnlyRegExp.hasMatch(input);

  @override
  String toString() => value;
}

class UserBio {
  const UserBio(this.value);
  final String value;

  @override
  String toString() => value;
}

class User {
  const User({
    required this.id,
    this.name,
    this.bio,
  });

  final UserId id;

  final UserName? name;

  final UserBio? bio;
}

class Backend {
  Future<User> getUser(UserId id) async => User(id: id);

  Future<void> putUser(
    UserId id, {
    UserName? name,
    UserBio? bio,
  }) async {}
}

class UserService {
  UserService(this.backend);

  final Backend backend;

  Future<User> get(UserId id) async {
    return await backend.getUser(id);
  }

  Future<void> update(User user) async {
    await backend.putUser(
      user.id,
      name: user.name,
      bio: user.bio,
    );
  }
}

void main() {
  final Backend backend = Backend();
  final UserService userService = UserService(backend);

  final User user = User(
    id: UserId('34567890-98765434567890'),
    name: UserName('John'),
    bio: UserBio('Flutter Dev'),
  );

  print('User created: ${user.name}');
}
