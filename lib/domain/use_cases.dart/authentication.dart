import 'package:flutter_tdd/domain/entities/account_entity.dart';

import '../entities/entities.dart';

/// Casos de uso são apenas interfaces. Não precisa testar o domain
abstract class Authentication {
  Future<AccountEntity> auth({
    required String email,
    required String password,
  });
}
