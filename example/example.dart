import 'package:opensubtitles_dart/opensubtitles_dart.dart';

Future<void> main() async {
  try {
    // Initialize API client
    final apiKey =
        'your_api_key_here'; // Get API key from https://www.opensubtitles.com/en/consumers
    final userAgent =
        'YourAppName/1.0'; // Unique identifier for your application
    final opensubtitlesApi =
        OpensubtitlesApi(apiKey: apiKey, userAgent: userAgent);

    // User authentication
    print('Authenticating user...');
    final userStatus = await opensubtitlesApi.login(
      username: 'your_username',
      password: 'your_password',
    );

    if (userStatus != null) {
      print('Authentication successful!');
      opensubtitlesApi.authToken = userStatus.token ?? '';
      opensubtitlesApi.apiUrl = userStatus.baseUrl ?? '';
    }

    // Get list of available subtitle formats
    print('\nGetting subtitle formats...');
    final subtitleFormats = await opensubtitlesApi.getSubtitleFormats();
    print('Available formats: ${subtitleFormats?.join(', ')}');

    // Get list of languages
    print('\nGetting languages list...');
    final languages = await opensubtitlesApi.getLanguages();
    print(
        'Available languages: ${languages?.map((l) => '${l.languageName} (${l.languageCode})').join(', ')}');

    // Search subtitles for a movie
    print('\nSearching subtitles for movie...');
    final searchResult = await opensubtitlesApi.searchSubtitles(
      query: 'The Matrix',
      languages: ['en'],
      type: SearchType.movie,
    );

    if (searchResult != null) {
      print('Found ${searchResult.items.length} subtitles:');
      for (var subtitle in searchResult.items) {
        print(
            '- ${subtitle.attributes?.files?[0].fileName ?? 'Unknown file'} (${subtitle.attributes?.language ?? 'Unknown language'})');
      }
    }

    // Get popular movies
    print('\nGetting popular movies...');
    final popularMovies = await opensubtitlesApi.discoverPopular(
      language: 'en',
      type: ItemType.movie,
    );

    if (popularMovies != null) {
      print('Popular movies:');
      for (var movie in popularMovies) {
        print('- ${movie.attributes?.title}');
      }
    }

    // Get user information
    print('\nGetting user information...');
    final user = await opensubtitlesApi.getUserInformation();
    if (user != null) {
      print('User: ID ${user.userId}');
      print('Remaining downloads: ${user.remainingDownloads}');
    }

    // Compute hash for local file
    print('\nComputing hash for local file...');
    final localHash = await opensubtitlesApi.getOpenSubtitlesHash(
        pathOrUrl: 'path/to/your/video.mp4');
    print('Local file hash: $localHash');

    // Compute hash for URL
    print('\nComputing hash for URL...');
    final urlHash = await opensubtitlesApi.getOpenSubtitlesHash(
        pathOrUrl: 'https://example.com/video.mp4');
    print('URL file hash: $urlHash');

    // Search subtitles by hash
    print('\nSearching subtitles by hash...');
    final hashSearchResult = await opensubtitlesApi.searchSubtitles(
      movieHash: localHash,
      languages: ['en'],
    );

    if (hashSearchResult != null && hashSearchResult.items.isNotEmpty) {
      print('Found ${hashSearchResult.items.length} subtitles by hash:');
      for (var subtitle in hashSearchResult.items) {
        print('Subtitle ID: ${subtitle.attributes?.subtitleId}');
        print('Language: ${subtitle.attributes?.language}');
        print('Download count: ${subtitle.attributes?.downloadCount}');
        print('Release: ${subtitle.attributes?.release}');
        print('---');
      }
    }

    // Logout from the system
    print('\nLogging out...');
    final logoutResult = await opensubtitlesApi.logout();
    print('Logout result: $logoutResult');
  } catch (e) {
    print('Error: $e');
  }
}
