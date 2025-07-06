/// User ID wrapper - must be 36 characters (UUIDv4 format).
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

/// User name wrapper - must be 4-32 characters, letters only.
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

/// A user in the system.
class User {
  const User({
    required this.id,
    this.name,
    this.bio,
  });

  /// User's unique ID (UUIDv4 format, 36 characters).
  final UserId id;

  /// User's display name (4-32 characters, letters only).
  final UserName? name;

  /// User's biography (max 255 characters).
  final UserBio? bio;
}

/// Handles backend user operations.
class Backend {
  /// Gets a user by ID.
  Future<User> getUser(UserId id) async => User(id: id);

  /// Updates user information.
  Future<void> putUser(
    UserId id, {
    UserName? name,
    UserBio? bio,
  }) async {}
}

/// Provides user management operations.
class UserService {
  UserService(this.backend);

  /// The backend for data operations.
  final Backend backend;

  /// Gets a user by ID.
  Future<User> get(UserId id) async {
    return await backend.getUser(id);
  }

  /// Updates a user's information.
  Future<void> update(User user) async {
    await backend.putUser(
      user.id,
      name: user.name,
      bio: user.bio,
    );
  }
}

void main() {
  // Example usage
  final Backend backend = Backend();
  final UserService userService = UserService(backend);

  // Create user with proper types
  final User user = User(
    id: UserId('34567890-98765434567890'),
    name: UserName('John'),
    bio: UserBio('Flutter Dev'),
  );

  print('User created: ${user.name}');
}
