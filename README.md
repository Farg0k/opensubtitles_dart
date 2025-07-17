# OpenSubtitles API

A Dart package for working with the OpenSubtitles API. This package provides a simple interface for interacting with the OpenSubtitles API, including subtitle search, download, authentication, and other features.

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  opensubtitles_dart: latest_version
```

## Usage

### Initialization

```
import 'package:opensubtitles_dart/opensubtitles_dart.dart';

final api = OpensubtitlesApi(
  apiKey: 'your_api_key',
  userAgent: 'your_app_name/1.0',
);
```

### Authentication

```
// Login
final userStatus = await api.login(
  username: 'your_username',
  password: 'your_password',
);

// Logout
await api.logout();

// Get user information
final userInfo = await api.getUserInformation();
```

### Computing File Hash

```
// Get hash from local file
final localHash = await api.getOpenSubtitlesHash('path/to/your/video.mp4');

// Get hash from URL
final urlHash = await api.getOpenSubtitlesHash('https://example.com/video.mp4');

// Use hash to search subtitles
final subtitles = await api.searchSubtitles(
  movieHash: localHash,
  languages: ['en'],
);
```

### Searching Subtitles

```
// Search by title
final subtitles = await api.searchSubtitles(
  query: 'movie title',
  languages: ['en', 'de'],
  type: SearchType.movie,
);

// Search by IMDB ID
final subtitlesByImdb = await api.searchSubtitles(
  imdb_id: 1234567,
  languages: ['en'],
);

// Search by movie hash
final subtitlesByHash = await api.searchSubtitles(
  movieHash: 'movie_hash',
  languages: ['en'],
);
```

### Downloading Subtitles

```
// Get download URL
final downloadInfo = await api.getDownloadUrl(
  fileId: 123456,
  subFormat: 'srt',
);

// Force download
final subtitleContent = await api.forceDownload(
  fileId: 123456,
  subFormat: 'srt',
);
```

### Searching Movies and TV Shows

```
// Search movies
final movies = await api.searchFeatures(
  query: 'movie title',
  type: SearchFeaturesType.movie,
  year: 2023,
);

// Get popular content
final popular = await api.discoverPopular(
  language: 'en',
  type: ItemType.movie,
);

// Get latest added subtitles
final latest = await api.latestSubtitles(
  language: 'en',
  type: ItemType.movie,
);
```

### Additional Functions

```
// Get supported formats
final formats = await api.getSubtitleFormats();

// Get supported languages
final languages = await api.getLanguages();

// Analyze filename
final fileInfo = await api.guessit(filename: 'movie.2023.1080p.en.mkv');
```

## Error Handling

The package throws `OpensubtitlesApiException` in case of API errors or network issues:

```
try {
  final subtitles = await api.searchSubtitles(query: 'movie');
} catch (e) {
  if (e is OpensubtitlesApiException) {
    print('API Error: ${e.message}');
    print('Status Code: ${e.statusCode}');
    print('Data: ${e.data}');
  }
}
```

## License

MIT License


📢 If you have any questions or suggestions – open an issue on [GitHub](https://github.com/Farg0k/opensubtitles_dart).