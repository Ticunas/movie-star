import 'package:hive_flutter/adapters.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';

part 'credential_model.g.dart';

@HiveType(typeId: 0)
class CredentialModel extends Credential {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  CredentialModel({
    required this.name,
    required this.email,
  }) : super(name, email);
}
