abstract class ResponseParser <T> {
  T? model;
  fromJsonString(String jsonString);
  fromJsonMap(Map<String, dynamic> jsonMap);
}