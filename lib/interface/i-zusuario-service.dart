import 'package:z_components/view-model/usuario-viewmodel.dart';

abstract class IZUsuarioService {
  Future<UsuarioViewModel?> buscarPerfilUsuario();
}
