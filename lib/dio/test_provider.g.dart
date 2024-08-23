// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$testGetHash() => r'9d3dad8accea0b2ddcadab4933caca40f327ad11';

/// See also [testGet].
@ProviderFor(testGet)
final testGetProvider =
    AutoDisposeFutureProvider<DataResponse<IndexBanner>>.internal(
  testGet,
  name: r'testGetProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$testGetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TestGetRef = AutoDisposeFutureProviderRef<DataResponse<IndexBanner>>;
String _$testGetListHash() => r'f34f5dceadae16dc4dd9a5dd2f097e366aac7dbf';

/// See also [testGetList].
@ProviderFor(testGetList)
final testGetListProvider = AutoDisposeFutureProvider<Object?>.internal(
  testGetList,
  name: r'testGetListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$testGetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TestGetListRef = AutoDisposeFutureProviderRef<Object?>;
String _$testPostHash() => r'9ad04c3c1bd0afdf651acf721dc0b8903e85fd3d';

/// See also [TestPost].
@ProviderFor(TestPost)
final testPostProvider =
    AutoDisposeNotifierProvider<TestPost, DataResponse<Article>?>.internal(
  TestPost.new,
  name: r'testPostProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$testPostHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TestPost = AutoDisposeNotifier<DataResponse<Article>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
