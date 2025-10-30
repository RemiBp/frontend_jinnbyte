class GetGalleryImagesResponse {
  final List<GalleryImage>? images;

  GetGalleryImagesResponse({this.images});

  factory GetGalleryImagesResponse.fromJson(Map<String, dynamic> json) {
    return GetGalleryImagesResponse(
      images: (json['images'] as List<dynamic>?)?.map((e) => GalleryImage.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'images': images?.map((e) => e.toJson()).toList(),
      };
}

class GalleryImage {
  final int? id;
  final String? url;
  final String? source;

  GalleryImage({this.id, this.url, this.source});

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      id: json['id'] as int?,
      url: json['url'] as String?,
      source: json['source'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'source': source,
      };
}