class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as int,
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}

class QuoteList {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;

  QuoteList({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory QuoteList.fromJson(Map<String, dynamic> json) {
    List<Quote> quotes = List<Quote>.from(
      json['quotes'].map((quoteJson) => Quote.fromJson(quoteJson)),
    );

    return QuoteList(
      quotes: quotes,
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}
