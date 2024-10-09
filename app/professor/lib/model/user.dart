class CustomUser {
  const CustomUser({
    required this.uid,
    required this.nome,
    required this.email,
    required this.cargo,
  });

  final String uid;
  final String nome;
  final String email;
  final String cargo;

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'nome': String nome,
        'email': String email,
        'cargo': String cargo,
      } =>
        CustomUser(
          uid: id,
          nome: nome,
          email: email,
          cargo: cargo,
        ),
      _ => throw const FormatException('Could not get CustomUser'),
    };
  }
}
