import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';
import 'model.dart';

part 'test_provider.g.dart';

@riverpod
Future<DataResponse<IndexBanner>> testGet(TestGetRef ref) =>
    ApiClient.instance.get("/testGet", fromJsonT: (json) => IndexBanner.fromJson(json));


@riverpod
class TestPost extends _$TestPost {
  @override
  DataResponse<Article>? build() => null;

  Future<void> testPost(curPage) async {
    state = await ApiClient.instance.post<DataResponse<Article>, Article>("/testPost",
        fromJsonT: (json) => Article.fromJson(json),
        data: {'page': curPage, "keyword": "${DateTime.now().millisecondsSinceEpoch}"});
  }
}

@riverpod
Future testGetList(TestGetListRef ref) => ApiClient.instance.get("/testGetList");




