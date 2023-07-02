// lib/env/env.dart
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'CMC_PRO_API_KEY')
  static const apiKey = _Env.apiKey;
}
