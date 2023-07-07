import 'package:prueba_tecnica_itti/api/interface/response_parser.dart';

import '../models/regres_users_response_model.dart';

class RegreasParser implements ResponseParser<RegresUsersResponseModel> {
  @override
  fromJsonMap(Map<String, dynamic> jsonMap) {
    model = RegresUsersResponseModel.fromJson(jsonMap);
  }

  @override
  fromJsonString(String jsonString) {
    model = regresUsersResponseModelFromJson(jsonString);
  }

  @override
  RegresUsersResponseModel? model;
}
