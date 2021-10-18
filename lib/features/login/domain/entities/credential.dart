class Credential {
  final String name;
  late String email;

  Credential(this.name, String email) {
    email = email.replaceAll(' ', '');
    this.email = email.toLowerCase();
  }
}
