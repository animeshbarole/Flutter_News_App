import 'package:equatable/equatable.dart';

class NewsQueryModel extends Equatable {
  final String newsHead;
  final String newsDes;
  final String newsImg;
  final String newsUrl;

 const  NewsQueryModel({
    required this.newsHead,
    required this.newsDes,
    required this.newsImg,
    required this.newsUrl,
  });

  factory NewsQueryModel.fromJson(Map<String, dynamic> json) {
    return NewsQueryModel(
      newsHead: json["title"] ?? "NEWS HEADLINE",
      newsDes: json["description"] ?? "SOME NEWS",
      newsImg: json["urlToImage"] ?? "SOME IMAGE",
      newsUrl: json["url"] ?? "SOME URL",
    );
  }

  @override
  List<Object?> get props => [newsHead, newsDes, newsImg, newsUrl];

  @override
  bool get stringify => true;
}
