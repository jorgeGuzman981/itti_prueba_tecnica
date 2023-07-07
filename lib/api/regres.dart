import 'package:dio/dio.dart';
import 'package:prueba_tecnica_itti/api/interface/response_parser.dart';
import 'package:prueba_tecnica_itti/api/interface/restfull_interface.dart';
import 'package:prueba_tecnica_itti/api/parser/regres_parser.dart';

class Regres implements RestfullInterface <RegreasParser> {
  
  final Dio _dio = Dio();
  @override
  Future  <RegreasParser> delete( {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future  <RegreasParser> get( {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(endPoint);
    RegreasParser regreasParser = RegreasParser();
    regreasParser.fromJsonMap(response.data);
    return regreasParser;
  }

  @override
  Future  <RegreasParser> post({Map<String, dynamic>? queryParameters}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future  <RegreasParser> put({Map<String, dynamic>? queryParameters}) {
    // TODO: implement put
    throw UnimplementedError();
  }
  
  @override
  String endPoint = 'https://reqres.in/api/users';

  
  
}