class SubtitlesLanguages {
  SubtitlesLanguages({required this.languageCode, required this.languageName});
  final String languageCode;
  final String languageName;

  Map<String, dynamic> toMap() {
    return {
      'language_code': this.languageCode,
      'language_name': this.languageName,
    };
  }

  factory SubtitlesLanguages.fromMap(Map<String, dynamic> map) {
    return SubtitlesLanguages(
      languageCode: map['language_code'] as String,
      languageName: map['language_name'] as String,
    );
  }

  @override
  String toString() {
    return 'SubtitlesLanguages{languageCode: $languageCode, languageName: $languageName}';
  }
}
