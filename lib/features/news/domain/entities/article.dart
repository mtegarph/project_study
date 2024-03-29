import 'package:equatable/equatable.dart';

//in this entity is the business object that be need in the news features is article
//and only get the data from the api that the feature need
//in entity is a model for the all data that we need so if we have
//a different api but we need the data from that different api in
//entity we make the model for the two data from different api so later
// we just combine the different data in repository to one in this entity
class ArticleEntity extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
