class SearchItem {
  String name;
  String img;
  String src;

  SearchItem({
    required this.name,
    this.img = '',
    required this.src,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        name: json['name'], img: json['img'] ?? '', src: json['src']);
  }
}

class PluginSearchResponse {
  String pluginName;
  List<SearchItem> data;

  PluginSearchResponse({
    required this.pluginName,
    required this.data,
  });

  factory PluginSearchResponse.fromJson(Map<String, dynamic> json) {
    return PluginSearchResponse(
      pluginName: json['pluginName'],
      data: (json['data'] as List)
          .map((itemJson) => SearchItem.fromJson(itemJson))
          .toList(),
    );
  }
}
