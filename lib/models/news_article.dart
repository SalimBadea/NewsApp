class NewsArticle{
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
}

class Source{
  String? id;
  String? name;
}

class BaseResponse{
  String? status;
  int totalResults = 0;
  List<NewsArticle>? articles;
}