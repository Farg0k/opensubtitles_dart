class FeatureItem {
  String? id;
  String? type;
  AttributesFeatureItem? attributes;

  FeatureItem({this.id, this.type, this.attributes});

  FeatureItem.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes =
        json['attributes'] != null
            ? new AttributesFeatureItem.fromMap(json['attributes'])
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
    return '''FeatureItem{
      id: $id, 
      type: $type, 
      attributes: $attributes
    }''';
  }
}

class AttributesFeatureItem {
  String? title;
  String? originalTitle;
  int? imdbId;
  int? tmdbId;
  String? featureId;
  String? year;
  List<String>? titleAka;
  SubtitlesCounts? subtitlesCounts;
  String? url;
  String? imgUrl;
  int? subtitlesCount;
  List<Seasons>? seasons;
  int? seasonsCount;
  String? parentTitle;
  int? seasonNumber;
  int? episodeNumber;
  int? parentImdbId;
  String? featureType;

  AttributesFeatureItem({
    this.title,
    this.originalTitle,
    this.imdbId,
    this.tmdbId,
    this.featureId,
    this.year,
    this.titleAka,
    this.subtitlesCounts,
    this.url,
    this.imgUrl,
    this.seasons,
    this.seasonsCount,
    this.parentTitle,
    this.seasonNumber,
    this.episodeNumber,
    this.parentImdbId,
    this.featureType,
  });

  AttributesFeatureItem.fromMap(Map<String, dynamic> json) {
    title = json['title'];
    originalTitle = json['original_title'];
    imdbId = json['imdb_id'];
    tmdbId = json['tmdb_id'];
    featureId = json['feature_id'];
    year = json['year'];
    titleAka = json['title_aka'].cast<String>();
    subtitlesCounts =
        json['subtitles_counts'] != null
            ? new SubtitlesCounts.fromMap(json['subtitles_counts'])
            : null;
    url = json['url'];
    imgUrl = json['img_url'];
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(new Seasons.fromMap(v));
      });
    }
    seasonsCount = json['seasons_count'];
    parentTitle = json['parent_title'];
    seasonNumber = json["season_number"];
    episodeNumber = json["episode_number"];
    parentImdbId = json["parent_imdb_id"];
    featureType = json["feature_type"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['original_title'] = this.originalTitle;
    data['imdb_id'] = this.imdbId;
    data['tmdb_id'] = this.tmdbId;
    data['feature_id'] = this.featureId;
    data['year'] = this.year;
    data['title_aka'] = this.titleAka;
    if (this.subtitlesCounts != null) {
      data['subtitles_counts'] = this.subtitlesCounts!.toMap();
    }
    data['url'] = this.url;
    data['img_url'] = this.imgUrl;
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.map((v) => v.toMap()).toList();
    }
    data['seasons_count'] = seasonsCount;
    data['parent_title'] = parentTitle;
    data["season_number"] = seasonNumber;
    data["episode_number"] = episodeNumber;
    data["parent_imdb_id"] = parentImdbId;
    data["feature_type"] = featureType;
    return data;
  }
}

class SubtitlesCounts {
  int? ro;
  int? en;
  int? es;
  int? pl;
  int? sv;
  int? ar;
  int? fi;
  int? el;
  int? nb;
  int? ea;
  int? bn;
  int? bs;
  int? bg;
  int? cs;
  int? da;
  int? nl;
  int? et;
  int? fr;
  int? hr;
  int? hu;
  int? id;
  int? it;
  int? ptPT;
  int? ru;
  int? sk;
  int? tr;
  int? ptBR;

  SubtitlesCounts({
    this.ro,
    this.en,
    this.es,
    this.pl,
    this.sv,
    this.ar,
    this.fi,
    this.el,
    this.nb,
    this.ea,
    this.bn,
    this.bs,
    this.bg,
    this.cs,
    this.da,
    this.nl,
    this.et,
    this.fr,
    this.hr,
    this.hu,
    this.id,
    this.it,
    this.ptPT,
    this.ru,
    this.sk,
    this.tr,
    this.ptBR,
  });

  SubtitlesCounts.fromMap(Map<String, dynamic> json) {
    ro = json['ro'];
    en = json['en'];
    es = json['es'];
    pl = json['pl'];
    sv = json['sv'];
    ar = json['ar'];
    fi = json['fi'];
    el = json['el'];
    nb = json['nb'];
    ea = json['ea'];
    bn = json['bn'];
    bs = json['bs'];
    bg = json['bg'];
    cs = json['cs'];
    da = json['da'];
    nl = json['nl'];
    et = json['et'];
    fr = json['fr'];
    hr = json['hr'];
    hu = json['hu'];
    id = json['id'];
    it = json['it'];
    ptPT = json['pt-PT'];
    ru = json['ru'];
    sk = json['sk'];
    tr = json['tr'];
    ptBR = json['pt-BR'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ro'] = this.ro;
    data['en'] = this.en;
    data['es'] = this.es;
    data['pl'] = this.pl;
    data['sv'] = this.sv;
    data['ar'] = this.ar;
    data['fi'] = this.fi;
    data['el'] = this.el;
    data['nb'] = this.nb;
    data['ea'] = this.ea;
    data['bn'] = this.bn;
    data['bs'] = this.bs;
    data['bg'] = this.bg;
    data['cs'] = this.cs;
    data['da'] = this.da;
    data['nl'] = this.nl;
    data['et'] = this.et;
    data['fr'] = this.fr;
    data['hr'] = this.hr;
    data['hu'] = this.hu;
    data['id'] = this.id;
    data['it'] = this.it;
    data['pt-PT'] = this.ptPT;
    data['ru'] = this.ru;
    data['sk'] = this.sk;
    data['tr'] = this.tr;
    data['pt-BR'] = this.ptBR;
    return data;
  }
}

class Seasons {
  int? seasonNumber;
  List<Episodes>? episodes;

  Seasons({this.seasonNumber, this.episodes});

  Seasons.fromMap(Map<String, dynamic> json) {
    seasonNumber = json['season_number'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season_number'] = this.seasonNumber;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Episodes {
  int? episodeNumber;
  String? title;
  int? featureId;
  int? featureImdbId;

  Episodes({
    this.episodeNumber,
    this.title,
    this.featureId,
    this.featureImdbId,
  });

  Episodes.fromMap(Map<String, dynamic> json) {
    episodeNumber = json['episode_number'];
    title = json['title'];
    featureId = json['feature_id'];
    featureImdbId = json['feature_imdb_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode_number'] = this.episodeNumber;
    data['title'] = this.title;
    data['feature_id'] = this.featureId;
    data['feature_imdb_id'] = this.featureImdbId;
    return data;
  }
}
