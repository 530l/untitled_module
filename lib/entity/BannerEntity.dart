import 'package:json_annotation/json_annotation.dart';

// 1.指定生成的文件，一般是当前文件.g.dart,必须和当前文件名字一致。
// banner 一定要一致
part 'BannerEntity.g.dart';

/// flutter pub run build_runner build --delete-conflicting-outputs
//
/// # 后面的 --delete-conflicting-outputs 是可选的，作用是：
/// # 自动删除任何现存的，与即将生成的输出文件冲突的文件，然后继续构建过程。
/// # 这样可以清理由于老版本或不同构建配置造成的遗留文件

@JsonSerializable() // 2.添加注解，告知此类是要生成Model类的
class BannerEntity {
  @JsonKey(name: 'id') // 3.可选，添加注解，告知此属性对应的json key
  final int bid;
  final String desc;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  BannerEntity({
    required this.bid,
    required this.desc,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  // 4、反序列化，固定写法：_${类名}FromJson(json)
  factory BannerEntity.fromJson(Map<String, dynamic> json) => _$BannerEntityFromJson(json);

  // 5、序列化，固定写法：_${类名}ToJson(this)
  Map<String, dynamic> toJson() => _$BannerEntityToJson(this);
}
