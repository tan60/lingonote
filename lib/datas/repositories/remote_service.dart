import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/corrected_ai_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:lingonote/datas/models/query_ai_model.dart';
import 'package:lingonote/datas/repositories/base_service.dart';
import 'package:lingonote/domains/managers/open_ai_mgr.dart';

class RemoteService extends BaseService {
  static RemoteService? _instance;

  factory RemoteService() {
    _instance ??= RemoteService._internal();
    return _instance!;
  }

  RemoteService._internal();

  @override
  Future<List<NoteModel>>? fetchMyNotes(int userUid) {
    return null;
  }

  @override
  Future? postNote(NoteModel note) {
    return null;
  }

  @override
  Future? updateNote(NoteModel note) {
    return null;
  }

  @override
  Future<int> fetchTotalPostedCount(int userUid) async {
    return 0;
  }

  @override
  Future<NoteModel>? fetchFirstNote(int userUid) {
    return null;
  }

  @override
  Future<List<AchieveModel>>? fetchAcheive(int userUid) {
    return null;
  }

  @override
  Future<dynamic>? postCorrectQuery(QueryAIModel queryAIModel) async {
    const String apiUrl = 'https://api.openai.com/v1/edits';
    Response response = await DioMgr().get().post(
          apiUrl,
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${OpenAIMgr().apiKey}',
          }),
          data: jsonEncode(queryAIModel.toJson()),
        );

    int? statusCode = response.statusCode;

    if (statusCode != null) {
      if (statusCode >= 200 && statusCode < 300) {
        if (statusCode == 200) {
          try {
            //final data = jsonDecode(response.data);
            //print(data);
            return CorrectedAIModel.fromJson(response.data);
          } catch (e) {
            throw Error();
          }
        }
      } else if (statusCode >= 300 && statusCode < 400) {
      } else if (statusCode >= 400 && statusCode < 500) {
      } else if (statusCode >= 500) {}
    } else {
      throw Error();
    }

    throw Error();
  }
}

class DioMgr {
  static DioMgr? _instance;
  late final Dio dio;

  factory DioMgr() {
    _instance ??= DioMgr._internal();

    return _instance!;
  }

  DioMgr._internal() {
    dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Dio get() {
    return dio;
  }
}
