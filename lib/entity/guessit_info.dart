class GuessitInfo {
  String? title;
  int? year;
  String? language;
  String? subtitleLanguage;
  String? screenSize;
  String? streamingService;
  String? source;
  String? other;
  String? audioCodec;
  String? audioChannels;
  String? videoCodec;
  String? releaseGroup;
  String? type;
  int? season;
  int? episode;
  String? episodeTitle;

  GuessitInfo({
    this.title,
    this.year,
    this.language,
    this.subtitleLanguage,
    this.screenSize,
    this.streamingService,
    this.source,
    this.other,
    this.audioCodec,
    this.audioChannels,
    this.videoCodec,
    this.releaseGroup,
    this.type,
    this.season,
    this.episode,
    this.episodeTitle,
  });

  GuessitInfo.fromMap(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    language = json['language'];
    subtitleLanguage = json['subtitle_language'];
    screenSize = json['screen_size'];
    streamingService = json['streaming_service'];
    source = json['source'];
    other = json['other'];
    audioCodec = json['audio_codec'];
    audioChannels = json['audio_channels'];
    videoCodec = json['video_codec'];
    releaseGroup = json['release_group'];
    type = json['type'];
    season = json['season'];
    episode = json['episode'];
    episodeTitle = json['episode_title'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['year'] = this.year;
    data['language'] = this.language;
    data['subtitle_language'] = this.subtitleLanguage;
    data['screen_size'] = this.screenSize;
    data['streaming_service'] = this.streamingService;
    data['source'] = this.source;
    data['other'] = this.other;
    data['audio_codec'] = this.audioCodec;
    data['audio_channels'] = this.audioChannels;
    data['video_codec'] = this.videoCodec;
    data['release_group'] = this.releaseGroup;
    data['type'] = this.type;
    data['season'] = this.season;
    data['episode'] = this.episode;
    data['episode_title'] = this.episodeTitle;
    return data;
  }

  @override
  String toString() {
    return '''GuessitInfo{
      title: $title, 
      year: $year, 
      language: $language, 
      subtitleLanguage: $subtitleLanguage, 
      screenSize: $screenSize, 
      streamingService: $streamingService, 
      source: $source, 
      other: $other, 
      audioCodec: $audioCodec, 
      audioChannels: $audioChannels, 
      videoCodec: $videoCodec, 
      releaseGroup: $releaseGroup, 
      type: $type, 
      season: $season, 
      episode: $episode, 
      episodeTitle: $episodeTitle
    }''';
  }
}
