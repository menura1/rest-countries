// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      flags: json['flags'] == null
          ? null
          : Flags.fromJson(json['flags'] as Map<String, dynamic>),
      population: (json['population'] as num?)?.toInt(),
      capital:
          (json['capital'] as List<dynamic>?)?.map((e) => e as String).toList(),
      region: json['region'] as String?,
      languages: (json['languages'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'flags': instance.flags,
      'population': instance.population,
      'capital': instance.capital,
      'region': instance.region,
      'languages': instance.languages,
    };

Flags _$FlagsFromJson(Map<String, dynamic> json) => Flags(
      png: json['png'] as String?,
      svg: json['svg'] as String?,
      alt: json['alt'] as String?,
    );

Map<String, dynamic> _$FlagsToJson(Flags instance) => <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
      'alt': instance.alt,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      common: json['common'] as String?,
      official: json['official'] as String?,
      nativeName: json['nativeName'] == null
          ? null
          : NativeName.fromJson(json['nativeName'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
      'nativeName': instance.nativeName,
    };

NativeName _$NativeNameFromJson(Map<String, dynamic> json) => NativeName(
      deu: json['deu'] == null
          ? null
          : Translation.fromJson(json['deu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NativeNameToJson(NativeName instance) =>
    <String, dynamic>{
      'deu': instance.deu,
    };

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      official: json['official'] as String?,
      common: json['common'] as String?,
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'official': instance.official,
      'common': instance.common,
    };
