class DownloadUrlInfo {
  String? link;
  String? fileName;
  int? requests;
  int? remaining;
  String? message;
  String? resetTime;
  String? resetTimeUtc;

  DownloadUrlInfo({
    this.link,
    this.fileName,
    this.requests,
    this.remaining,
    this.message,
    this.resetTime,
    this.resetTimeUtc,
  });

  DownloadUrlInfo.fromMap(Map<String, dynamic> json) {
    link = json['link'];
    fileName = json['file_name'];
    requests = json['requests'];
    remaining = json['remaining'];
    message = json['message'];
    resetTime = json['reset_time'];
    resetTimeUtc = json['reset_time_utc'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['file_name'] = this.fileName;
    data['requests'] = this.requests;
    data['remaining'] = this.remaining;
    data['message'] = this.message;
    data['reset_time'] = this.resetTime;
    data['reset_time_utc'] = this.resetTimeUtc;
    return data;
  }

  @override
  String toString() {
    return '''DownloadUrlInfo{
      link: $link, 
      fileName: $fileName, 
      requests: $requests, 
      remaining: $remaining, 
      message: $message, 
      resetTime: $resetTime, 
      resetTimeUtc: $resetTimeUtc
    }''';
  }
}
