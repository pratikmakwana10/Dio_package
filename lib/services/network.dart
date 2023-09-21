import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Network net = Network();

class Network {
  Dio dio = Dio();

  Future<dynamic> postWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("POST URL :: $url");
    debugPrint("POST BODY :: $body");

    return dio.post(url, data: FormData.fromMap(body)).then(
          (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        debugPrint(response.data);

        return response.data;
      },
    ).catchError((error) {
      debugPrint(error);
    });
  }

  Future<dynamic> getWithDio({
    required String url,
    Map<String, dynamic> body = const {},
  }) {
    debugPrint("GET URL :: $url");
    debugPrint("GET BODY :: $body");

    return dio.get(url, queryParameters: body).then(
          (Response response) {
        int code = response.statusCode!;

        if (code < 200 || code > 400) {
          /// HANDEL STATUS
        }

        debugPrint(response.data);

        return response.data;
      },
    ).catchError((error) {
      debugPrint(error);
    });
  }
}