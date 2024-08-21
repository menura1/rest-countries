import 'package:json_annotation/json_annotation.dart';

part 'Country.g.dart';

@JsonSerializable()
class Country {
  const Country(
      {this.name,
      this.flags,
      this.population,
      this.capital,
      this.region,
      this.languages});

  final Name? name;
  final Flags? flags;
  final int? population;
  final List<String>? capital;
  final String? region;
  final Map<String, String>? languages;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class Flags {
  final String? png;
  final String? svg;
  final String? alt;

  Flags({
    this.png,
    this.svg,
    this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);

  Map<String, dynamic> toJson() => _$FlagsToJson(this);
}

@JsonSerializable()
class Name {
  final String? common;
  final String? official;
  final NativeName? nativeName;

  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class NativeName {
  final Translation? deu;

  NativeName({
    this.deu,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) =>
      _$NativeNameFromJson(json);

  Map<String, dynamic> toJson() => _$NativeNameToJson(this);
}

@JsonSerializable()
class Translation {
  final String? official;
  final String? common;

  Translation({
    this.official,
    this.common,
  });

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}
