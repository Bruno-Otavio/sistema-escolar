class User {
  const User({
    required this.id,
    required this.nome,
    required this.email,
  });

  final String id;
  final String nome;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'nome': String nome,
        'email': String email,
      } =>
        User(
          id: id,
          nome: nome,
          email: email,
        ),
      _ => throw const FormatException('Could not get User'),
    };
  }
}
