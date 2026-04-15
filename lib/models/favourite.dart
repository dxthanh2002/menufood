class FavouriteRecipeResponse {
  final bool? error;
  final FavouriteData? data;

  FavouriteRecipeResponse({this.error, this.data});

  factory FavouriteRecipeResponse.fromJson(Map<String, dynamic> json) =>
      FavouriteRecipeResponse(
        error: json["error"],
        data: json["data"] == null
            ? null
            : FavouriteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class FavouriteData {
  final List<FavouriteItem>? items;
  final FavouritePagination? pagination;

  FavouriteData({this.items, this.pagination});

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    items: json["items"] == null
        ? []
        : List<FavouriteItem>.from(
            json["items"]!.map((x) => FavouriteItem.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : FavouritePagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class FavouriteItem {
  final String? id;
  final String? appId;
  final String? userId;
  final String? recipeId;
  final String? recipeCode;
  final String? recipeName;
  final String? recipeSlug;
  final String? recipeImageUrl;
  final String? shortDescription;
  final String? difficulty;
  final int? cookTimeMinutes;
  final String? cuisineType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  FavouriteItem({
    this.id,
    this.appId,
    this.userId,
    this.recipeId,
    this.recipeCode,
    this.recipeName,
    this.recipeSlug,
    this.recipeImageUrl,
    this.shortDescription,
    this.difficulty,
    this.cookTimeMinutes,
    this.cuisineType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> json) => FavouriteItem(
    id: json["_id"],
    appId: json["appId"],
    userId: json["userId"],
    recipeId: json["recipeId"],
    recipeCode: json["recipeCode"],
    recipeName: json["recipeName"],
    recipeSlug: json["recipeSlug"],
    recipeImageUrl: json["recipeImageUrl"],
    shortDescription: json["shortDescription"],
    difficulty: json["difficulty"],
    cookTimeMinutes: json["cookTimeMinutes"],
    cuisineType: json["cuisineType"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "appId": appId,
    "userId": userId,
    "recipeId": recipeId,
    "recipeCode": recipeCode,
    "recipeName": recipeName,
    "recipeSlug": recipeSlug,
    "recipeImageUrl": recipeImageUrl,
    "shortDescription": shortDescription,
    "difficulty": difficulty,
    "cookTimeMinutes": cookTimeMinutes,
    "cuisineType": cuisineType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class FavouritePagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  FavouritePagination({this.page, this.limit, this.total, this.totalPages});

  factory FavouritePagination.fromJson(Map<String, dynamic> json) =>
      FavouritePagination(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
  };
}
