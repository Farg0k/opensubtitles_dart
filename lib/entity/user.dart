class User {
  int? allowedDownloads;
  int? allowedTranslations;
  String? level;
  int? userId;
  bool? extInstalled;
  bool? vip;
  int? downloadsCount;
  int? remainingDownloads;

  User({
    this.allowedDownloads,
    this.allowedTranslations,
    this.level,
    this.userId,
    this.extInstalled,
    this.vip,
    this.downloadsCount,
    this.remainingDownloads,
  });

  User.fromMap(Map<String, dynamic> json) {
    allowedDownloads = json['allowed_downloads'];
    allowedTranslations = json['allowed_translations'];
    level = json['level'];
    userId = json['user_id'];
    extInstalled = json['ext_installed'];
    vip = json['vip'];
    downloadsCount = json['downloads_count'];
    remainingDownloads = json['remaining_downloads'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowed_downloads'] = this.allowedDownloads;
    data['allowed_translations'] = this.allowedTranslations;
    data['level'] = this.level;
    data['user_id'] = this.userId;
    data['ext_installed'] = this.extInstalled;
    data['vip'] = this.vip;
    data['downloads_count'] = this.downloadsCount;
    data['remaining_downloads'] = this.remainingDownloads;
    return data;
  }

  @override
  String toString() {
    return '''User{
      allowedDownloads: $allowedDownloads, 
      allowedTranslations: $allowedTranslations, 
      level: $level, 
      userId: $userId, 
      extInstalled: $extInstalled, 
      vip: $vip,
      downloadsCount: $downloadsCount,
      remainingDownloads : $remainingDownloads
    }''';
  }
}
