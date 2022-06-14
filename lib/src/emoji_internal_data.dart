String unicodeToString(String unified) {
  return String.fromCharCodes(
    unified.split('-').map(
      (e) {
        return int.parse(e, radix: 16);
      },
    ),
  );
}

class EmojiInternalData {
  String? id;
  String? name;
  String? unified;
  String? nonQualified;
  String? category;
  int? sortOrder;
  bool? hasApple;
  bool? hasGoogle;
  List<String?> skins = [];

  String get char => unicodeToString(unified!);

  String charForSkin(int skin) {
    if (skin == 0 || skin >= skins.length + 1) {
      return char;
    }
    String unified = skins[skin - 1]!;
    return unicodeToString(unified);
  }

  String? unifiedForSkin(int skin) {
    if (skin == 0 || skin >= skins.length + 1) {
      return unified;
    }
    return skins[skin - 1];
  }

  EmojiInternalData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['unified'];
    name = jsonData['name'];
    unified = jsonData['unified'];
    nonQualified = jsonData['non_qualified'];
    category = jsonData['category'];
    sortOrder = jsonData['sort_order'];
    hasApple = jsonData['has_img_apple'];
    hasGoogle = jsonData['has_img_google'];
    if (jsonData.containsKey('skin_variations')) {
      for (var key in jsonData['skin_variations'].keys) {
        var entry = jsonData['skin_variations'][key];
        skins.add(entry['unified']);
      }
    }
  }
}
