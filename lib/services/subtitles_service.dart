import '../entity/feature_item.dart';
import '../entity/paginated_response.dart';
import '../entity/subtitle_item.dart';
import '../entity/subtitles_languages.dart';
import '../entity/enums.dart';
import '../network/network_requests.dart';
import '../constants/api_constants.dart';

class SubtitlesService {
  final NetworkRequests _networkRequests;
  final Map<String, String> _headers;
  String _apiUrl = ApiConstants.defaultApiUrl;

  SubtitlesService(this._networkRequests, this._headers);

  set apiUrl(String value) => _apiUrl = value;

  Future<List<String>?> getSubtitleFormats() async {
    final url = '$_apiUrl/infos/formats';
    final uri = Uri.parse(url);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final formats = response?['data']?['output_formats'] as List<dynamic>?;
    return formats?.map((item) => item.toString()).toList();
  }

  Future<List<SubtitlesLanguages>?> getLanguages() async {
    final url = '$_apiUrl/infos/languages';
    final uri = Uri.parse(url);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final languages = response?['data'] as List<dynamic>?;
    return languages?.map((item) => SubtitlesLanguages.fromMap(item)).toList();
  }

  Future<List<FeatureItem>?> discoverPopular({
    String? language,
    ItemType? type,
  }) async {
    final url = '$_apiUrl/discover/popular';
    final queryParams = <String, String>{};
    if (language != null) queryParams['language'] = language;
    if (type != null) queryParams['type'] = type.name;
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final data = response?['data'] as List<dynamic>?;
    return data?.map((item) => FeatureItem.fromMap(item)).toList();
  }

  Future<List<SubtitleItem>?> latestSubtitles({
    String? language,
    ItemType? type,
  }) async {
    final url = '$_apiUrl/discover/latest';
    final queryParams = <String, String>{};
    if (language != null) queryParams['language'] = language;
    if (type != null) queryParams['type'] = type.name;
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final data = response?['data'] as List<dynamic>?;
    return data?.map((item) => SubtitleItem.fromMap(item)).toList();
  }

  Future<List<SubtitleItem>?> mostDownloadedSubtitles({
    String? language,
    ItemType? type,
  }) async {
    final url = '$_apiUrl/discover/most_downloaded';
    final queryParams = <String, String>{};
    if (language != null) queryParams['language'] = language;
    if (type != null) queryParams['type'] = type.name;
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final data = response?['data'] as List<dynamic>?;
    return data?.map((item) => SubtitleItem.fromMap(item)).toList();
  }

  Future<PaginatedResponse<SubtitleItem>?> searchSubtitles({
    Inclusion? aiTranslated,
    int? episodeNumber,
    Inclusion? foreignPartsOnly,
    Inclusion? hearingImpaired,
    int? id,
    int? imdbId,
    List<String>? languages,
    Inclusion? machineTranslated,
    String? movieHash,
    Inclusion? movieHashMatch,
    OrderBy? orderBy,
    OrderDirection? orderDirection,
    int? page,
    int? parentFeatureId,
    int? parentImdbId,
    int? parentTmdbId,
    String? query,
    int? seasonNumber,
    int? tmdbId,
    Inclusion? trustedSources,
    SearchType? type,
    int? uploaderId,
    int? year,
  }) async {
    final url = '$_apiUrl/subtitles';
    final queryParams = {
      if (aiTranslated != null) 'ai_translated': aiTranslated.name,
      if (episodeNumber != null) 'episode_number': episodeNumber,
      if (foreignPartsOnly != null) 'foreign_parts_only': foreignPartsOnly.name,
      if (hearingImpaired != null) 'hearing_impaired': hearingImpaired.name,
      if (id != null) 'id': id,
      if (imdbId != null) 'imdb_id': imdbId,
      if (languages != null) 'languages': languages.join(','),
      if (machineTranslated != null)
        'machine_translated': machineTranslated.name,
      if (movieHash != null) 'moviehash': movieHash,
      if (movieHashMatch != null) 'moviehash_match': movieHashMatch.name,
      if (orderBy != null) 'order_by': orderBy.name,
      if (orderDirection != null) 'order_direction': orderDirection.name,
      if (page != null) 'page': page,
      if (parentFeatureId != null) 'parent_feature_id': parentFeatureId,
      if (parentImdbId != null) 'parent_imdb_id': parentImdbId,
      if (query != null) 'query': query,
      if (seasonNumber != null) 'season_number': seasonNumber,
      if (tmdbId != null) 'tmdb_id': tmdbId,
      if (trustedSources != null) 'trusted_sources': trustedSources,
      if (type != null) 'type': type.name,
      if (uploaderId != null) 'uploader_id': uploaderId,
      if (year != null) 'year': year,
    };
    if (queryParams.isEmpty) return null;

    final uri = Uri.parse(url).replace(
      queryParameters: queryParams.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    if (response == null) return null;
    return PaginatedResponse.fromMap(response, SubtitleItem.fromMap);
  }

  Future<List<FeatureItem>?> searchFeatures({
    int? featureId,
    bool? fullSearch,
    String? imdbId,
    String? query,
    QueryMatch? queryMatch,
    String? tmdbId,
    SearchFeaturesType? type,
    int? year,
  }) async {
    final url = '$_apiUrl/features';
    final queryParams = {
      if (featureId != null) 'feature_id': featureId,
      if (fullSearch != null) 'full_search': fullSearch,
      if (imdbId != null) 'imdb_id': imdbId,
      if (query != null && query.length > 2) 'query': query,
      if (queryMatch != null) 'query_match': queryMatch.name,
      if (tmdbId != null) 'tmdb_id': tmdbId,
      if (type != null) 'type': type.name,
      if (year != null) 'year': year,
    };
    if (queryParams.isEmpty) return null;
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    final data = response?['data'] as List<dynamic>?;
    return data?.map((item) => FeatureItem.fromMap(item)).toList();
  }
}
