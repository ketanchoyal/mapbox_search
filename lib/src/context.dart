part of mapbox_search;

class Context {
  String? id;
  String? shortCode;
  String? wikidata;
  String? text;

  Context({
    this.id,
    this.shortCode,
    this.wikidata,
    this.text,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
    id: json["id"],
    shortCode: json["short_code"],
    wikidata: json["wikidata"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "short_code": shortCode,
    "wikidata": wikidata,
    "text": text,
  };
}
