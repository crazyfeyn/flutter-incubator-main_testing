// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      type: json['type'] as String,
      stream: StreamInfo.fromJson(json['stream'] as Map<String, dynamic>),
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(e as Map<String, dynamic>))
          .toList(),
      debug: DebugInfo.fromJson(json['debug'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'type': instance.type,
      'stream': instance.stream,
      'gifts': instance.gifts,
      'debug': instance.debug,
    };

StreamInfo _$StreamInfoFromJson(Map<String, dynamic> json) => StreamInfo(
      user_id: json['user_id'] as String,
      is_private: json['is_private'] as bool,
      settings: (json['settings'] as num).toInt(),
      shard_url: json['shard_url'] as String,
      public_tariff:
          PublicTariff.fromJson(json['public_tariff'] as Map<String, dynamic>),
      private_tariff: PrivateTariff.fromJson(
          json['private_tariff'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamInfoToJson(StreamInfo instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'is_private': instance.is_private,
      'settings': instance.settings,
      'shard_url': instance.shard_url,
      'public_tariff': instance.public_tariff,
      'private_tariff': instance.private_tariff,
    };

PublicTariff _$PublicTariffFromJson(Map<String, dynamic> json) => PublicTariff(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      duration: json['duration'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PublicTariffToJson(PublicTariff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'duration': instance.duration,
      'description': instance.description,
    };

PrivateTariff _$PrivateTariffFromJson(Map<String, dynamic> json) =>
    PrivateTariff(
      clientPrice: (json['client_price'] as num).toInt(),
      duration: json['duration'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PrivateTariffToJson(PrivateTariff instance) =>
    <String, dynamic>{
      'client_price': instance.clientPrice,
      'duration': instance.duration,
      'description': instance.description,
    };

Gift _$GiftFromJson(Map<String, dynamic> json) => Gift(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$GiftToJson(Gift instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'description': instance.description,
    };

DebugInfo _$DebugInfoFromJson(Map<String, dynamic> json) => DebugInfo(
      duration: json['duration'] as String,
      at: json['at'] as String,
    );

Map<String, dynamic> _$DebugInfoToJson(DebugInfo instance) => <String, dynamic>{
      'duration': instance.duration,
      'at': instance.at,
    };
