class User {
  const User({
    required this.uid,
    required this.nome,
  });

  final String uid;
  final String nome;

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'uid': String uid,
        'nome': String nome,
      } =>
        User(
          uid: uid,
          nome: nome,
        ),
      _ => throw const FormatException('Could not get User'),
    };
  }
}
