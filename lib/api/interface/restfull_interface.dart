abstract class RestfullInterface <T> {
  late String endPoint;
  Future<T> get( {Map<String, dynamic>? queryParameters});
  Future<T> post( {Map<String, dynamic>? queryParameters});
  Future<T> put({Map<String, dynamic>? queryParameters});
  Future<T> delete( {Map<String, dynamic>? queryParameters});
}