class FacebookModel {
  final String? email;
  final String? id;
  final String? name;
  final PictureModel? pictureModel;

  FacebookModel({this.email, this.id, this.name, this.pictureModel});

  factory FacebookModel.fromJson(Map<String, dynamic> json) => FacebookModel(
        email: json['email'],
        id: json['id'] as String?,
        name: json['name'],
        pictureModel: PictureModel.fromJson(json['picture']['data']),
      );
}

class PictureModel {
  final String? url;
  final int? width;
  final int? height;

  PictureModel({this.url, this.width, this.height});

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
        url: json['url'],
        width: json['width'],
        height: json['height'],
      );
}
