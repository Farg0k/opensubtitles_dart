enum SearchType { movie, episode, all }

enum ItemType { movie, tvshow }

enum Inclusion { exclude, include }

enum OrderBy {
  language,
  download_count,
  new_download_count,
  hearing_impaired,
  hd,
  fps,
  votes,
  points,
  ratings,
  from_trusted,
  foreign_parts_only,
  ai_translated,
  machine_translated,
  upload_date,
  release,
  comments,
}

enum OrderDirection { asc, desc }

enum QueryMatch { start, word, exact }

enum SearchFeaturesType { movie, tvshow, episode }
