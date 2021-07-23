import 'package:z_components/api/api-settings.dart';
import 'package:z_components/api/service.dart';
import 'package:z_components/api/z-estrutura-empresa/i-estrutura-epresa-service.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/paginated-list.dart';
import 'package:z_components/components/filtro/z-response.dart';

class EstruturaEmpresaService extends Service
    implements IEstruturaEmpresaService {
  EstruturaEmpresaService(String token) : super(token);

  final String _baseURL = "${ApiSettings.ENDPOINT_API_V1}/estrutura-empresa";

  @override
  Future<ZResponse<Nivel>> listarNiveis(SearchOptions searchOptions) async {
    var params = searchOptions.toHttpParams();

    var url = "$_baseURL/niveis$params";

    try {
      var res = await request(url, Service.HTTP_GET);

      return PaginatedList<Nivel>(response: res, deserializer: Nivel.fromJson)
          .mapToPaginatedList();
    } catch (e) {
      return null;
    }
  }
}
