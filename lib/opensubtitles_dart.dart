import 'entity/download_url_info.dart';
import 'entity/enums.dart';
import 'entity/feature_item.dart';
import 'entity/guessit_info.dart';
import 'entity/paginated_response.dart';
import 'entity/subtitle_item.dart';
import 'entity/subtitles_languages.dart';
import 'entity/user.dart';
import 'entity/user_status.dart';
import 'network/network_requests.dart';
import 'services/auth_service.dart';
import 'services/subtitles_service.dart';
import 'services/files_service.dart';

export 'entity/download_url_info.dart';
export 'entity/enums.dart';
export 'entity/feature_item.dart';
export 'entity/guessit_info.dart';
export 'entity/opensubtitles_api_exception.dart';
export 'entity/paginated_response.dart';
export 'entity/subtitle_item.dart';
export 'entity/subtitles_languages.dart';
export 'entity/user.dart';
export 'entity/user_status.dart';

/// A Dart client for the OpenSubtitles API.
///
/// This class provides methods to interact with the OpenSubtitles API,
/// including authentication, searching for subtitles, downloading subtitles,
/// and managing user information.
///
/// ## Features
/// - User authentication and management
/// - Subtitle search with multiple filters
/// - Subtitle download functionality
/// - File hash calculation
/// - Language and format management
/// - Popular and latest subtitles discovery
///
/// ## Authentication
/// The API requires both an API key and user authentication for most operations.
/// First, create an instance with your API key and user agent:
/// ```dart
/// final api = OpensubtitlesApi(
///   apiKey: 'your_api_key',
///   userAgent: 'your_app_name/1.0',
/// );
/// ```
///
/// Then authenticate using your credentials:
/// ```dart
/// final userStatus = await api.login(
///   username: 'your_username',
///   password: 'your_password',
/// );
/// ```
///
/// ## Usage Examples
///
/// ### Search for Subtitles
/// ```dart
/// final subtitles = await api.searchSubtitles(
///   query: 'movie title',
///   languages: ['en'],
///   type: SearchType.movie,
///   year: 2023,
/// );
/// ```
///
/// ### Download Subtitle
/// ```dart
/// if (subtitles?.data != null && subtitles!.data.isNotEmpty) {
///   final downloadUrl = await api.getDownloadUrl(
///     fileId: subtitles.data.first.id,
///   );
///
///   // Force download subtitle content
///   final subtitleContent = await api.forceDownload(
///     fileId: subtitles.data.first.id,
///   );
/// }
/// ```
///
/// ### Get File Hash
/// ```dart
/// final fileHash = await api.getOpenSubtitlesHash(
///   pathOrUrl: 'path/to/your/video/file',
/// );
/// ```
///
/// ## API Endpoints
/// The client interacts with the following main endpoints:
/// - Authentication endpoints (/auth/*)
/// - Subtitles endpoints (/subtitles/*)
/// - Files endpoints (/files/*)
///
/// ## Error Handling
/// All methods return nullable types and may throw [OpensubtitlesApiException] in case of API errors.
/// Always check the return values for null before using them.
///
/// ## Rate Limiting
/// The API has rate limits that vary based on your subscription level.
/// The client will automatically handle rate limiting responses.
///
/// ## Dependencies
/// This package requires the following dependencies:
/// - http: For making HTTP requests
/// - crypto: For hash calculations
///
/// ## License
/// This package is licensed under the MIT License.
///
/// Example usage:
/// ```dart
/// final api = OpensubtitlesApi(
///   apiKey: 'your_api_key',
///   userAgent: 'your_app_name/1.0',
/// );
///
/// // Login
/// final userStatus = await api.login(
///   username: 'your_username',
///   password: 'your_password',
/// );
///
/// // Search for subtitles
/// final subtitles = await api.searchSubtitles(
///   query: 'movie title',
///   languages: ['en'],
///   type: SearchType.movie,
/// );
///
/// // Download subtitle
/// if (subtitles?.data != null && subtitles!.data.isNotEmpty) {
///   final downloadUrl = await api.getDownloadUrl(
///     fileId: subtitles.data.first.id,
///   );
///
///   // Force download subtitle content
///   final subtitleContent = await api.forceDownload(
///     fileId: subtitles.data.first.id,
///   );
/// }
/// ```
class OpensubtitlesApi {
  late final AuthService _authService;
  late final SubtitlesService _subtitlesService;
  late final FilesService _filesService;

  /// Creates a new instance of the OpenSubtitles API client.
  ///
  /// [apiKey] - Your OpenSubtitles API key
  /// [userAgent] - A string identifying your application
  OpensubtitlesApi({required String apiKey, required String userAgent})
      : apiKey = apiKey,
        userAgent = userAgent {
    final networkRequests = NetworkRequests();
    final headers = {
      'Content-Type': 'application/json',
      'User-Agent': userAgent,
      'Accept': 'application/json',
      'Api-Key': apiKey,
    };

    _authService = AuthService(networkRequests, headers);
    _subtitlesService = SubtitlesService(networkRequests, headers);
    _filesService = FilesService(networkRequests, headers);
  }

  /// The base URL for the OpenSubtitles API
  set apiUrl(String value) {
    _authService.apiUrl = value;
    _subtitlesService.apiUrl = value;
    _filesService.apiUrl = value;
  }

  /// The authentication token received after successful login

  set authToken(String value) {
    _authService.authToken = value;
    _filesService.authToken = value;
  }

  /// The API key used for authentication
  final String apiKey;

  /// The user agent string identifying the application
  final String userAgent;

  // Auth methods
  /// Authenticates a user with the OpenSubtitles API.
  ///
  /// [username] - The user's username
  /// [password] - The user's password
  ///
  /// Returns a [UserStatus] object containing the authentication token and user information.
  /// Returns null if authentication fails.
  ///
  /// ## Rate Limit
  /// Request rate limit is 1 request per 1 second.
  Future<UserStatus?> login({
    required String username,
    required String password,
  }) => _authService.login(username: username, password: password);

  /// Logs out the current user from the OpenSubtitles API.
  ///
  /// [token] - Optional authentication token. If not provided, uses the current token.
  /// [baseUrl] - Optional base URL for the API. If not provided, uses the default URL.
  ///
  /// Returns true if logout was successful, false otherwise.
  Future<bool> logout({String? token, String? baseUrl}) =>
      _authService.logout(token: token, baseUrl: baseUrl);

  /// Retrieves information about the currently authenticated user.
  ///
  /// [token] - Optional authentication token. If not provided, uses the current token.
  /// [baseUrl] - Optional base URL for the API. If not provided, uses the default URL.
  ///
  /// Returns a [User] object containing user information, or null if the request fails.
  Future<User?> getUserInformation({String? token, String? baseUrl}) =>
      _authService.getUserInformation(token: token, baseUrl: baseUrl);

  // Subtitles methods
  /// Gets a list of supported subtitle formats.
  ///
  /// Returns a list of format strings (e.g., 'srt', 'vtt', 'ass'), or null if the request fails.
  Future<List<String>?> getSubtitleFormats() =>
      _subtitlesService.getSubtitleFormats();

  /// Gets a list of supported languages for subtitles.
  ///
  /// Returns a list of [SubtitlesLanguages] objects, or null if the request fails.
  Future<List<SubtitlesLanguages>?> getLanguages() =>
      _subtitlesService.getLanguages();

  /// Discovers popular content based on specified criteria.
  ///
  /// [language] - Optional language code to filter results
  /// [type] - Optional content type (movie, episode, etc.)
  ///
  /// Returns a list of [FeatureItem] objects, or null if the request fails.
  Future<List<FeatureItem>?> discoverPopular({
    String? language,
    ItemType? type,
  }) => _subtitlesService.discoverPopular(language: language, type: type);

  /// Gets the latest uploaded subtitles.
  ///
  /// [language] - Optional language code to filter results
  /// [type] - Optional content type (movie, episode, etc.)
  ///
  /// Returns a list of [SubtitleItem] objects, or null if the request fails.
  Future<List<SubtitleItem>?> latestSubtitles({
    String? language,
    ItemType? type,
  }) => _subtitlesService.latestSubtitles(language: language, type: type);

  /// Gets the most downloaded subtitles.
  ///
  /// [language] - Optional language code to filter results
  /// [type] - Optional content type (movie, episode, etc.)
  ///
  /// Returns a list of [SubtitleItem] objects, or null if the request fails.
  Future<List<SubtitleItem>?> mostDownloadedSubtitles({
    String? language,
    ItemType? type,
  }) =>
      _subtitlesService.mostDownloadedSubtitles(language: language, type: type);

  /// Searches for subtitles with various filters.
  ///
  /// [query] - Search query string
  /// [languages] - List of language codes to filter results
  /// [type] - Type of content to search for
  /// [year] - Year of release
  /// [imdbId] - IMDB ID of the content
  /// [tmdbId] - TMDB ID of the content
  /// [page] - Page number for pagination
  /// [orderBy] - Field to sort results by
  /// [orderDirection] - Sort direction (asc/desc)
  /// [hearingImpaired] - Filter for hearing impaired subtitles
  /// [trustedSources] - Filter for trusted sources only
  /// [machineTranslated] - Include machine translated subtitles
  /// [aiTranslated] - Include AI translated subtitles
  /// [movieHash] - Moviehash of the moviefile (must be exactly 16 hexadecimal characters, pattern: ^[a-f0-9]{16}$)
  ///
  /// Returns a [PaginatedResponse] containing [SubtitleItem] objects, or null if the request fails.
  ///
  /// ## Search Guidelines
  /// ### ID Usage
  /// - Use `imdb_id` for movies or episodes
  /// - Use `parent_imdb_id` for TV Shows
  /// - When searching for TV show episodes, send the parent ID along with episode and season number
  /// - If you have the unique ID of an episode, only send this ID, excluding episode or season number
  ///
  /// ### Best Practices
  /// 1. If you can obtain the moviehash from the file, please send it along
  /// 2. If you possess the ID (IMDB or TMDB), send it instead of a query for more precision
  /// 3. Include the filename as a query parameter along with the moviehash for improved results
  /// 4. Treat parameters as filters rather than additional criteria
  /// 5. Explore querying the /features endpoint to gather the exact list of available episodes
  /// 6. Remove leading zeroes in ID parameters (IMDB ID, TMDB ID...)
  /// 7. Send all queries in lowercase
  /// 8. Avoid http redirection by sending request parameters sorted and without default values
  ///
  /// ### Moviehash
  /// - Must be exactly 16 hexadecimal characters (0-9, a-f)
  /// - Match pattern: ^[a-f0-9]{16}$
  /// - If a moviehash is sent with a request, a `moviehash_match` boolean field will be added to the response
  /// - The matching subtitles will always come first in the response
  /// - Example: "1234567890abcdef"
  ///
  /// ### Ordering
  /// - If possible, don't order results as sorting on server is "expensive, time consuming operation"
  /// - You have much higher chance to get cached result when not using ordering
  /// - Ordering is possible on the following fields:
  ///   - language
  ///   - download_count
  ///   - new_download_count
  ///   - hearing_impaired
  ///   - hd
  ///   - fps
  ///   - votes
  ///   - points
  ///   - ratings
  ///   - from_trusted
  ///   - foreign_parts_only
  ///   - ai_translated
  ///   - machine_translated
  ///   - upload_date
  ///   - release
  ///   - comments
  /// - Change the order direction with `order_direction` (asc/desc)
  ///
  /// ### Translation Quality
  /// - `ai_translated` subtitles (default include in search results) should be much better quality than `machine_translated` subtitles (excluded in search results)
  ///
  /// ### Important Notes
  /// - This is a collaborative project where subtitles are submitted by users, filtered by admins, and movie/show results are processed through various APIs
  /// - Occasionally, errors may occur, and we depend on user feedback to address and rectify them
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
  }) => _subtitlesService.searchSubtitles(
    aiTranslated: aiTranslated,
    episodeNumber: episodeNumber,
    foreignPartsOnly: foreignPartsOnly,
    hearingImpaired: hearingImpaired,
    id: id,
    imdbId: imdbId,
    languages: languages,
    machineTranslated: machineTranslated,
    movieHash: movieHash,
    movieHashMatch: movieHashMatch,
    orderBy: orderBy,
    orderDirection: orderDirection,
    page: page,
    parentFeatureId: parentFeatureId,
    parentImdbId: parentImdbId,
    parentTmdbId: parentTmdbId,
    query: query,
    seasonNumber: seasonNumber,
    tmdbId: tmdbId,
    trustedSources: trustedSources,
    type: type,
    uploaderId: uploaderId,
    year: year,
  );

  /// Searches for features (movies, TV shows) with various filters.
  ///
  /// [query] - Search query string (must be at least 3 characters long, accepts release/file names)
  /// [type] - Type of content to search for
  /// [year] - Year of release
  /// [imdbId] - IMDB ID of the content
  /// [tmdbId] - TMDB ID of the content
  /// [featureId] - Specific feature ID to search for
  /// [fullSearch] - Whether to perform a full text search
  /// [queryMatch] - How to match the query text
  ///
  /// Returns a list of [FeatureItem] objects, or null if the request fails.
  ///
  /// ## Query Requirements
  /// - Must be at least 3 characters long
  /// - Accepts release names and file names
  Future<List<FeatureItem>?> searchFeatures({
    int? featureId,
    bool? fullSearch,
    String? imdbId,
    String? query,
    QueryMatch? queryMatch,
    String? tmdbId,
    SearchFeaturesType? type,
    int? year,
  }) => _subtitlesService.searchFeatures(
    featureId: featureId,
    fullSearch: fullSearch,
    imdbId: imdbId,
    query: query,
    queryMatch: queryMatch,
    tmdbId: tmdbId,
    type: type,
    year: year,
  );

  /// Analyzes a filename to extract metadata using the Guessit library.
  ///
  /// [filename] - The filename to analyze
  ///
  /// Returns a [GuessitInfo] object containing extracted metadata, or null if the request fails.
  Future<GuessitInfo?> guessit({required String filename}) =>
      _filesService.guessit(filename: filename);

  // Files methods
  /// Gets a download URL for a subtitle file.
  ///
  /// [fileId] - ID of the subtitle file to download
  /// [subFormat] - Desired subtitle format
  /// [fileName] - Custom filename for the downloaded file
  /// [inFps] - Input FPS for frame rate conversion
  /// [outFps] - Output FPS for frame rate conversion
  /// [timeShift] - Time shift in seconds
  /// [token] - Optional authentication token
  /// [baseUrl] - Optional base URL for the API
  ///
  /// Returns a [DownloadUrlInfo] object containing the download URL and metadata, or null if the request fails.
  ///
  /// ## Important Notes
  /// - Subtitle file in temporary URL will be always in UTF-8 encoding
  /// - The download count is calculated on this action, not the file download itself
  /// - IN and OUT FPS must be indicated for subtitle conversions. These values should be collected from the subtitle search result or calculated somehow
  /// - The download URL is temporary and cannot be used more than 3 hours. Do not cache it, but you can download the file more than once if needed
  Future<DownloadUrlInfo?> getDownloadUrl({
    required int fileId,
    String? subFormat,
    String? fileName,
    double? inFps,
    double? outFps,
    double? timeShift,
    String? token,
    String? baseUrl,
  }) => _filesService.getDownloadUrl(
    fileId: fileId,
    subFormat: subFormat,
    fileName: fileName,
    inFps: inFps,
    outFps: outFps,
    timeShift: timeShift,
    token: token,
    baseUrl: baseUrl,
  );

  /// Forces a direct download of subtitle content.
  ///
  /// [fileId] - ID of the subtitle file to download
  /// [subFormat] - Desired subtitle format
  /// [fileName] - Custom filename for the downloaded file
  /// [inFps] - Input FPS for frame rate conversion
  /// [outFps] - Output FPS for frame rate conversion
  /// [timeShift] - Time shift in seconds
  /// [token] - Optional authentication token
  /// [baseUrl] - Optional base URL for the API
  ///
  /// Returns the subtitle content as a string, or null if the request fails.
  Future<String?> forceDownload({
    required int fileId,
    String? subFormat,
    String? fileName,
    double? inFps,
    double? outFps,
    double? timeShift,
    String? token,
    String? baseUrl,
  }) => _filesService.forceDownload(
    fileId: fileId,
    subFormat: subFormat,
    fileName: fileName,
    inFps: inFps,
    outFps: outFps,
    timeShift: timeShift,
    token: token,
    baseUrl: baseUrl,
  );

  /// Calculates the OpenSubtitles hash for a file.
  ///
  /// [pathOrUrl] - Path to the local file or URL of the remote file
  /// [fileSize] - Optional file size in bytes
  ///
  /// Returns the calculated hash as a string.
  Future<String> getOpenSubtitlesHash({
    required String pathOrUrl,
    int? fileSize,
  }) => _filesService.getOpenSubtitlesHash(
    pathOrUrl: pathOrUrl,
    fileSize: fileSize,
  );
}
