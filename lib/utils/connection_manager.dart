import 'dart:convert';
import 'package:quiz/models/model.dart';
import 'package:quiz/models/place_model.dart';
import 'package:quiz/utils/resources.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class ConnectionManager{
  String _baseUrl = "maps.googleapis.com";
  String resourcePath = "/maps/api/place/nearbysearch/json";
  Model Function(dynamic) constructor = (json) => PlacesModel.fromJson(json);

  Future<ApiResponse> index([Map<String, String> params]) {
    return apiRequest(HttpMethods.GET, params, resourcePath);
  }

  Future<ApiResponse> apiRequest(HttpMethods method, Map<String, String> params, String resourcePath, [Model Function(dynamic) customConstructor]) async {
    if (params == null) params = {};
    final apiResponse = await apiRequestDynamic(method, params, resourcePath);
    Model Function(dynamic) theModelConstructor = customConstructor != null ? customConstructor : constructor;
    if (apiResponse.responseJson != null) {
      apiResponse.model = theModelConstructor(apiResponse.responseJson);
      apiResponse.responseJson = null;
    } else if (apiResponse.responseJsonList != null) {
      apiResponse.models = apiResponse.responseJsonList.map((json) => theModelConstructor(json)).toList();
      apiResponse.responseJsonList = null;
    }
    return apiResponse;
  }

  Future<ApiResponse> apiRequestDynamic(HttpMethods method, Map<String, String> params, String originalUrl) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await apiRequestRaw(method, params, originalUrl);
      var responseBody = "";
      if (response is http.Response)
        responseBody = response.body;
      else if (response is http.StreamedResponse) responseBody = await response.stream.bytesToString();
      print("====== " + method.toString() + " " + originalUrl + " " + response.statusCode.toString() + responseBody);

      dynamic jsonResponse = "";
      try {
        jsonResponse = json.decode(responseBody);
      } catch (e) {
        e.toString();
      }

      if (response.statusCode == 200) {
        if (jsonResponse is Map) {
          apiResponse.responseJson = jsonResponse;
        } else if (jsonResponse is List) {
          apiResponse.responseJsonList = jsonResponse;
        }
      } else {
        apiResponse.error = "(" + response.statusCode.toString() + ") " + responseBody;
      }
    } catch (e, s) {
      apiResponse.error = e.toString();
      print(e);
      print(s);
    }
    return apiResponse;
  }


  Future<http.BaseResponse> apiRequestRaw(HttpMethods method, Map<String, String> params, String originalUrl) async {

    String fullUrl = _getUrl(params, originalUrl);

    print("estas es la url completa "+fullUrl);

    if (method == HttpMethods.GET) {
      return http.get(fullUrl);
    } else if (method == HttpMethods.POST) {
      return http.post(fullUrl, body: params);
    } else if (method == HttpMethods.PATCH) {
      return http.patch(fullUrl, body: params);
    } else if (method == HttpMethods.PUT) {
      return http.put(fullUrl, body: params);
    } else if (method == HttpMethods.DELETE) {
      return http.delete(fullUrl);
    }
  }

  String _getUrl(Map<String, String> params, String urlService) {
    var uri = new Uri.https(_baseUrl, urlService, params);
    return uri.toString();
  }

}

class ApiResponse{

  String methodCalled = "";
  Model model;
  List<Model> models;
  String unprocessableEntityMessage;
  Map<String, dynamic> unprocessableEntityJson;
  String error;

  Map<String, dynamic> responseJson;
  List<dynamic> responseJsonList;

  ApiResponse();
}