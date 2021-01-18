class ApiSettings {
  static final String API_TOKEN = "ZTOKEN";
  static final String REFRESH_TOKEN = "REFRESH_TOKEN";
  static final String TOKEN_EXPIRATION_DATE = "TOKEN_EXPIRATION_DATE";
  static final String API_ID_USER = "IDUSER";
  static final String API_USERNAME = "USERNAME";
  static final String API_PASSWORD = "PASSWORD";
  static final String API_REMEMBER = "APIREMEMBER";
  static final String ID_COLABORADOR = "IDCOLABORADOR";
  static final String ID_CONTA = "ID_CONTA";
  static final String ID_EMPRESA = "IDEMPRESA";
  static final String LATITUDE = "LATITUDE";
  static final String LONGITUDE = "LONGITUDE";

  static final String ATUALIZA_DATAJORNADA = "ATUALIZA_DATAJORNADA";
  static final String ATUALIZA_NOTIFICACAO = "ATUALIZA_NOTIFICACAO";
  static final String ATUALIZA_PODE_BATER_PONTO = "ATUALIZA_PODE_BATER_PONTO";
  static final String EXIBIR_VIDEO = "EXIBIR_VIDEO";

  /*static final String _host = "192.168.1.112";
  static final String ENDPOINT_API_V1 = "http://${_host}:5001/api/v1";
  static final String ENDPOINT_API = "http://${_host}:5001/moltres/apis";
  static final String ENDPOINT = "http://${_host}:5001/moltres";*/

  static final String _host = "gateway-dev.zellar.com.br";
  static final String ENDPOINT_API = "https://${_host}/moltres/apis";
  static final String ENDPOINT = "https://${_host}/moltres";
  static final String ENDPOINT_API_V1 = "https://${_host}/api/v1";
}