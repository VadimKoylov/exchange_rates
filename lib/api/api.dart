import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exchange_rates/model/convert_model.dart';

class Api {
  final dio = Dio();
  static const String baseUrl = "https://api.apilayer.com/currency_data/";
  static const String baseToken = "neQytxMQPFLw2S8ApE56Hk4lJ34KihgW";

  Api() {
    dio.options.headers['content-Type'] = 'application/json';
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('REQUEST[${options.method}]');
          log('PATH: ${options.path}');
          log('');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE[${response.statusCode}]');
          log('PATH: ${response.requestOptions.path}');
          log('');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          log('ERROR[${e.response?.statusCode}]');
          log('PATH: ${e.requestOptions.path}');
          log('');
          return handler.next(e);
        },
      ),
    );
  }

  Future<ConvertModel> getRatio({
    required String startDate,
    required String endDate,
    required String to,
    required String from,
  }) async {
    final response = await dio.get(
      "${baseUrl}timeframe?start_date=$startDate"
      "&end_date=$endDate&source=$from&currencies=$to",
      queryParameters: {
        "apikey": baseToken,
      },
    );
    log("response: $response");
    return ConvertModel.fromJson(response.data);
  }
}
