part of mapbox_search;

class Properties {
  String? shortCode;
  String? wikidata;
  String? address;

  Properties({
    this.shortCode,
    this.wikidata,
    this.address,
  });

  factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    shortCode: json["short_code"] == null ? null : json["short_code"],
    wikidata: json["wikidata"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "short_code": shortCode == null ? null : shortCode,
    "wikidata": wikidata,
    "address": address,
  };
}
