import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toml/toml.dart';
import 'package:yaml_writer/yaml_writer.dart';

part 'request.g.dart';

@JsonSerializable()
class Request {
  final String type;
  final StreamInfo stream;
  final List<Gift> gifts;
  final DebugInfo debug;

  Request({
    required this.type,
    required this.stream,
    required this.gifts,
    required this.debug,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestToJson(this);

  String toYaml() {
    final writer = YamlWriter();
    return writer.write(toJson());
  }

  String toToml() {
    final jsonString = jsonEncode(toJson());
    final primitiveMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return TomlDocument.fromMap(primitiveMap).toString();
  }
}

@JsonSerializable()
class StreamInfo {
  final String user_id;
  final bool is_private;
  final int settings;
  final String shard_url;
  final PublicTariff public_tariff;
  final PrivateTariff private_tariff;

  StreamInfo({
    required this.user_id,
    required this.is_private,
    required this.settings,
    required this.shard_url,
    required this.public_tariff,
    required this.private_tariff,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) =>
      _$StreamInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StreamInfoToJson(this);
}

@JsonSerializable()
class PublicTariff {
  final int id;
  final int price;
  final String duration;
  final String description;

  PublicTariff({
    required this.id,
    required this.price,
    required this.duration,
    required this.description,
  });

  factory PublicTariff.fromJson(Map<String, dynamic> json) =>
      _$PublicTariffFromJson(json);
  Map<String, dynamic> toJson() => _$PublicTariffToJson(this);
}

@JsonSerializable()
class PrivateTariff {
  @JsonKey(name: 'client_price')
  final int clientPrice;
  final String duration;
  final String description;

  PrivateTariff({
    required this.clientPrice,
    required this.duration,
    required this.description,
  });

  factory PrivateTariff.fromJson(Map<String, dynamic> json) =>
      _$PrivateTariffFromJson(json);
  Map<String, dynamic> toJson() => _$PrivateTariffToJson(this);
}

@JsonSerializable()
class Gift {
  final int id;
  final int price;
  final String description;

  Gift({
    required this.id,
    required this.price,
    required this.description,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
  Map<String, dynamic> toJson() => _$GiftToJson(this);
}

@JsonSerializable()
class DebugInfo {
  final String duration;
  final String at;

  DebugInfo({
    required this.duration,
    required this.at,
  });

  factory DebugInfo.fromJson(Map<String, dynamic> json) =>
      _$DebugInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DebugInfoToJson(this);
}
