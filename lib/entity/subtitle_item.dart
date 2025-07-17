class SubtitleItem {
  String? id;
  String? type;
  AttributesSubtitleItem? attributes;

  SubtitleItem({this.id, this.type, this.attributes});

  SubtitleItem.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes =
        json['attributes'] != null
            ? new AttributesSubtitleItem.fromMap(json['attributes'])
            : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toMap();
    }
    return data;
  }

  @override
  String toString() {
    return '''SubtitleItem{
      id: $id, 
      type: $type, 
      attributes: $attributes
    }''';
  }
}

class AttributesSubtitleItem {
  String? subtitleId;
  String? language;
  int? downloadCount;
  int? newDownloadCount;
  bool? hearingImpaired;
  bool? hd;
  double? fps;
  int? votes;
  double? ratings;
  bool? fromTrusted;
  bool? foreignPartsOnly;
  String? uploadDate;
  List<String>? fileHashes;
  bool? aiTranslated;
  int? nbCd;
  String? slug;
  bool? machineTranslated;
  String? release;
  String? comments;
  int? legacySubtitleId;
  int? legacyUploaderId;
  Uploader? uploader;
  FeatureDetails? featureDetails;
  String? url;
  List<RelatedLinks>? relatedLinks;
  List<Files>? files;

  AttributesSubtitleItem({
    this.subtitleId,
    this.language,
    this.downloadCount,
    this.newDownloadCount,
    this.hearingImpaired,
    this.hd,
    this.fps,
    this.votes,
    this.ratings,
    this.fromTrusted,
    this.foreignPartsOnly,
    this.uploadDate,
    this.fileHashes,
    this.aiTranslated,
    this.nbCd,
    this.slug,
    this.machineTranslated,
    this.release,
    this.comments,
    this.legacySubtitleId,
    this.legacyUploaderId,
    this.uploader,
    this.featureDetails,
    this.url,
    this.relatedLinks,
    this.files,
  });

  AttributesSubtitleItem.fromMap(Map<String, dynamic> json) {
    subtitleId = json['subtitle_id'];
    language = json['language'];
    downloadCount = json['download_count'];
    newDownloadCount = json['new_download_count'];
    hearingImpaired = json['hearing_impaired'];
    hd = json['hd'];
    fps = json['fps'];
    votes = json['votes'];
    ratings = json['ratings'];
    fromTrusted = json['from_trusted'];
    foreignPartsOnly = json['foreign_parts_only'];
    uploadDate = json['upload_date'];
    if (json['file_hashes'] != null) {
      fileHashes = <String>[];
      json['file_hashes'].forEach((v) {
        fileHashes!.add(v.toString());
      });
    }
    aiTranslated = json['ai_translated'];
    nbCd = json['nb_cd'];
    slug = json['slug'];
    machineTranslated = json['machine_translated'];
    release = json['release'];
    comments = json['comments'];
    legacySubtitleId = json['legacy_subtitle_id'];
    legacyUploaderId = json['legacy_uploader_id'];
    uploader =
        json['uploader'] != null
            ? new Uploader.fromMap(json['uploader'])
            : null;
    featureDetails =
        json['feature_details'] != null
            ? new FeatureDetails.fromMap(json['feature_details'])
            : null;
    url = json['url'];
    if (json['related_links'] != null) {
      relatedLinks = <RelatedLinks>[];
      json['related_links'].forEach((v) {
        relatedLinks!.add(new RelatedLinks.fromMap(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromMap(v));
      });
    }
  }

  @override
  String toString() {
    return '''AttributesSubtitleItem{
      subtitleId: $subtitleId, 
      language: $language, 
      downloadCount: $downloadCount, 
      newDownloadCount: $newDownloadCount, 
      hearingImpaired: $hearingImpaired, 
      hd: $hd, 
      fps: $fps, 
      votes: $votes, 
      ratings: $ratings, 
      fromTrusted: $fromTrusted, 
      foreignPartsOnly: $foreignPartsOnly, 
      uploadDate: $uploadDate, 
      fileHashes: $fileHashes, 
      aiTranslated: $aiTranslated, 
      nbCd: $nbCd, 
      slug: $slug, 
      machineTranslated: $machineTranslated, 
      release: $release, 
      comments: $comments, 
      legacySubtitleId: $legacySubtitleId, 
      legacyUploaderId: $legacyUploaderId, 
      uploader: $uploader, 
      featureDetails: $featureDetails, 
      url: $url, 
      relatedLinks: $relatedLinks, 
      files: $files
    }''';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitle_id'] = this.subtitleId;
    data['language'] = this.language;
    data['download_count'] = this.downloadCount;
    data['new_download_count'] = this.newDownloadCount;
    data['hearing_impaired'] = this.hearingImpaired;
    data['hd'] = this.hd;
    data['fps'] = this.fps;
    data['votes'] = this.votes;
    data['ratings'] = this.ratings;
    data['from_trusted'] = this.fromTrusted;
    data['foreign_parts_only'] = this.foreignPartsOnly;
    data['upload_date'] = this.uploadDate;
    if (this.fileHashes != null) {
      data['file_hashes'] = this.fileHashes!.map((v) => v).toList();
    }
    data['ai_translated'] = this.aiTranslated;
    data['nb_cd'] = this.nbCd;
    data['slug'] = this.slug;
    data['machine_translated'] = this.machineTranslated;
    data['release'] = this.release;
    data['comments'] = this.comments;
    data['legacy_subtitle_id'] = this.legacySubtitleId;
    data['legacy_uploader_id'] = this.legacyUploaderId;
    if (this.uploader != null) {
      data['uploader'] = this.uploader!.toMap();
    }
    if (this.featureDetails != null) {
      data['feature_details'] = this.featureDetails!.toMap();
    }
    data['url'] = this.url;
    if (this.relatedLinks != null) {
      data['related_links'] = this.relatedLinks!.map((v) => v.toMap()).toList();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Uploader {
  int? uploaderId;
  String? name;
  String? rank;

  Uploader({this.uploaderId, this.name, this.rank});

  Uploader.fromMap(Map<String, dynamic> json) {
    uploaderId = json['uploader_id'];
    name = json['name'];
    rank = json['rank'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploader_id'] = this.uploaderId;
    data['name'] = this.name;
    data['rank'] = this.rank;
    return data;
  }
}

class FeatureDetails {
  int? featureId;
  String? featureType;
  int? year;
  String? title;
  String? movieName;
  int? imdbId;
  int? tmdbId;

  FeatureDetails({
    this.featureId,
    this.featureType,
    this.year,
    this.title,
    this.movieName,
    this.imdbId,
    this.tmdbId,
  });

  FeatureDetails.fromMap(Map<String, dynamic> json) {
    featureId = json['feature_id'];
    featureType = json['feature_type'];
    year = json['year'];
    title = json['title'];
    movieName = json['movie_name'];
    imdbId = json['imdb_id'];
    tmdbId = json['tmdb_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_id'] = this.featureId;
    data['feature_type'] = this.featureType;
    data['year'] = this.year;
    data['title'] = this.title;
    data['movie_name'] = this.movieName;
    data['imdb_id'] = this.imdbId;
    data['tmdb_id'] = this.tmdbId;
    return data;
  }
}

class RelatedLinks {
  String? label;
  String? url;
  String? imgUrl;

  RelatedLinks({this.label, this.url, this.imgUrl});

  RelatedLinks.fromMap(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['url'] = this.url;
    data['img_url'] = this.imgUrl;
    return data;
  }
}

class Files {
  int? fileId;
  int? cdNumber;
  String? fileName;

  Files({this.fileId, this.cdNumber, this.fileName});

  Files.fromMap(Map<String, dynamic> json) {
    fileId = json['file_id'];
    cdNumber = json['cd_number'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_id'] = this.fileId;
    data['cd_number'] = this.cdNumber;
    data['file_name'] = this.fileName;
    return data;
  }

  @override
  String toString() {
    return '''Files{
      fileId: $fileId, 
      cdNumber: $cdNumber, 
      fileName: $fileName
    }''';
  }
}
