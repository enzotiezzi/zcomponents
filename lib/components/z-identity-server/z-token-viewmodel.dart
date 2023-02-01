class ZTokenViewModel{
  String? idToken;
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;

  ZTokenViewModel({this.idToken, this.accessToken, this.expiresIn, this.tokenType, this.refreshToken});

  factory ZTokenViewModel.fromJson(Map<String, dynamic> json){
    return ZTokenViewModel(
      idToken: json["id_token"],
      accessToken: json["access_token"],
      expiresIn: json["expires_in"],
      tokenType: json["token_type"],
      refreshToken: json["refresh_token"]
    );
  }
}