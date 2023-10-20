class User {
  final String id;
  final String nome;
  final String email;
  final String senha;

  User(
      {required this.id,
      required this.nome,
      required this.email,
      required this.senha});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }
}
