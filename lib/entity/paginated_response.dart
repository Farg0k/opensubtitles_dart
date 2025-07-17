class PaginatedResponse<T> {
  final List<T> items;
  final int totalPages;
  final int totalCount;
  final int perPage;
  final int currentPage;

  PaginatedResponse({
    required this.items,
    required this.totalPages,
    required this.totalCount,
    required this.perPage,
    required this.currentPage,
  });

  factory PaginatedResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    return PaginatedResponse<T>(
      items:
          (map['data'] as List<dynamic>).map((item) => fromMap(item)).toList(),
      totalPages: map['total_pages'] ?? 1,
      totalCount: map['total_count'] ?? 0,
      perPage: map['per_page'] ?? 0,
      currentPage: map['page'] ?? 1,
    );
  }

  @override
  String toString() {
    return '''PaginatedResponse{
      items: $items, 
      totalPages: $totalPages, 
      totalCount: $totalCount, 
      perPage: $perPage, 
      currentPage: $currentPage
    }''';
  }
}
