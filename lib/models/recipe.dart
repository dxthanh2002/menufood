class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String difficulty;
  final double rating;
  final bool isPopular;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.rating,
    this.isPopular = false,
  });
}

class AnalyzeResponse {
  final bool? error;
  final AnalyzeData? data;

  AnalyzeResponse({this.error, this.data});

  factory AnalyzeResponse.fromJson(Map<String, dynamic> json) =>
      AnalyzeResponse(
        error: json["error"],
        data: json["data"] == null ? null : AnalyzeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class AnalyzeData {
  final List<IngredientData>? ingredients;
  final List<String>? rawIngredients;
  final bool? normalized;
  final Language? language;

  AnalyzeData({
    this.ingredients,
    this.rawIngredients,
    this.normalized,
    this.language,
  });

  factory AnalyzeData.fromJson(Map<String, dynamic> json) => AnalyzeData(
    ingredients: json["ingredients"] == null
        ? []
        : List<IngredientData>.from(
            json["ingredients"]!.map((x) => IngredientData.fromJson(x)),
          ),
    rawIngredients: json["rawIngredients"] == null
        ? []
        : List<String>.from(json["rawIngredients"]!.map((x) => x)),
    normalized: json["normalized"],
    language: languageValues.map[json["language"]]!,
  );

  Map<String, dynamic> toJson() => {
    "ingredients": ingredients == null
        ? []
        : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
    "rawIngredients": rawIngredients == null
        ? []
        : List<dynamic>.from(rawIngredients!.map((x) => x)),
    "normalized": normalized,
    "language": languageValues.reverse[language],
  };
}

class IngredientData {
  final String? name;
  final String? key;
  final double? confidence;
  final Language? language;

  IngredientData({this.name, this.key, this.confidence, this.language});

  factory IngredientData.fromJson(Map<String, dynamic> json) => IngredientData(
    name: json["name"],
    key: json["key"],
    confidence: json["confidence"]?.toDouble(),
    language: languageValues.map[json["language"]]!,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "confidence": confidence,
    "language": languageValues.reverse[language],
  };
}

enum Language { EN }

final languageValues = EnumValues({"en": Language.EN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class RecipeDetailReponse {
  final bool? error;
  final RecipeData? data;

  RecipeDetailReponse({this.error, this.data});

  factory RecipeDetailReponse.fromJson(Map<String, dynamic> json) =>
      RecipeDetailReponse(
        error: json["error"],
        data: json["data"] == null ? null : RecipeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class RecipeData {
  final String? id;
  final String? code;
  final String? name;
  final String? slug;
  final String? imageUrl;
  final String? introduction;
  final String? description;
  final String? shortDescription;
  final String? cuisineType;
  final String? mealType;
  final String? difficulty;
  final int? servings;
  final int? kcal;
  final Nutrition? nutrition;
  final Times? times;
  final List<Ingredient>? ingredients;
  final List<Step>? steps;
  final CategoryData? category;
  final bool? isFavorite;

  RecipeData({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.imageUrl,
    this.introduction,
    this.description,
    this.shortDescription,
    this.cuisineType,
    this.mealType,
    this.difficulty,
    this.servings,
    this.kcal,
    this.nutrition,
    this.times,
    this.ingredients,
    this.steps,
    this.category,
    this.isFavorite,
  });

  factory RecipeData.fromJson(Map<String, dynamic> json) => RecipeData(
    id: json["_id"],
    code: json["code"],
    name: json["name"],
    slug: json["slug"],
    imageUrl: json["imageUrl"],
    introduction: json["introduction"],
    description: json["description"],
    shortDescription: json["shortDescription"],
    cuisineType: json["cuisineType"],
    mealType: json["mealType"],
    difficulty: json["difficulty"],
    servings: json["servings"],
    kcal: json["kcal"],
    nutrition: json["nutrition"] == null
        ? null
        : Nutrition.fromJson(json["nutrition"]),
    times: json["times"] == null ? null : Times.fromJson(json["times"]),
    ingredients: json["ingredients"] == null
        ? []
        : List<Ingredient>.from(
            json["ingredients"]!.map((x) => Ingredient.fromJson(x)),
          ),
    steps: json["steps"] == null
        ? []
        : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
    category: json["category"] == null
        ? null
        : CategoryData.fromJson(json["category"]),
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "name": name,
    "slug": slug,
    "imageUrl": imageUrl,
    "introduction": introduction,
    "description": description,
    "shortDescription": shortDescription,
    "cuisineType": cuisineType,
    "mealType": mealType,
    "difficulty": difficulty,
    "servings": servings,
    "kcal": kcal,
    "nutrition": nutrition?.toJson(),
    "times": times?.toJson(),
    "ingredients": ingredients == null
        ? []
        : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
    "steps": steps == null
        ? []
        : List<dynamic>.from(steps!.map((x) => x.toJson())),
    "category": category?.toJson(),
    "isFavorite": isFavorite,
  };
}

class CategoryData {
  final String? id;
  final String? code;
  final String? name;

  CategoryData({this.id, this.code, this.name});

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      CategoryData(id: json["id"], code: json["code"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "code": code, "name": name};
}

class Ingredient {
  final String? key;
  final String? name;
  final double? quantity;
  final String? unit;
  final String? note;
  final bool? isOptional;

  Ingredient({
    this.key,
    this.name,
    this.quantity,
    this.unit,
    this.note,
    this.isOptional,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    key: json["key"],
    name: json["name"],
    quantity: json["quantity"]?.toDouble(),
    unit: json["unit"],
    note: json["note"],
    isOptional: json["isOptional"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "quantity": quantity,
    "unit": unit,
    "note": note,
    "isOptional": isOptional,
  };
}

class Nutrition {
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final int? fiber;

  Nutrition({this.calories, this.protein, this.carbs, this.fat, this.fiber});

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
    calories: json["calories"],
    protein: json["protein"],
    carbs: json["carbs"],
    fat: json["fat"],
    fiber: json["fiber"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "protein": protein,
    "carbs": carbs,
    "fat": fat,
    "fiber": fiber,
  };
}

class Step {
  final int? stepNumber;
  final String? title;
  final String? content;
  final String? imageUrl;
  final int? durationMinutes;

  Step({
    this.stepNumber,
    this.title,
    this.content,
    this.imageUrl,
    this.durationMinutes,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    stepNumber: json["stepNumber"],
    title: json["title"],
    content: json["content"],
    imageUrl: json["imageUrl"],
    durationMinutes: json["durationMinutes"],
  );

  Map<String, dynamic> toJson() => {
    "stepNumber": stepNumber,
    "title": title,
    "content": content,
    "imageUrl": imageUrl,
    "durationMinutes": durationMinutes,
  };
}

class Times {
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? totalTimeMinutes;

  Times({this.prepTimeMinutes, this.cookTimeMinutes, this.totalTimeMinutes});

  factory Times.fromJson(Map<String, dynamic> json) => Times(
    prepTimeMinutes: json["prepTimeMinutes"],
    cookTimeMinutes: json["cookTimeMinutes"],
    totalTimeMinutes: json["totalTimeMinutes"],
  );

  Map<String, dynamic> toJson() => {
    "prepTimeMinutes": prepTimeMinutes,
    "cookTimeMinutes": cookTimeMinutes,
    "totalTimeMinutes": totalTimeMinutes,
  };
}

class RecipeSuggestionResponse {
  final bool? error;
  final SuggestionData? data;

  RecipeSuggestionResponse({this.error, this.data});

  factory RecipeSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      RecipeSuggestionResponse(
        error: json["error"],
        data: json["data"] == null
            ? null
            : SuggestionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class SuggestionData {
  final List<SuggestionItem>? items;
  final SuggestionPagination? pagination;

  SuggestionData({this.items, this.pagination});

  factory SuggestionData.fromJson(Map<String, dynamic> json) => SuggestionData(
    items: json["items"] == null
        ? []
        : List<SuggestionItem>.from(
            json["items"]!.map((x) => SuggestionItem.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : SuggestionPagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SuggestionItem {
  final String? id;
  final String? name;
  final String? imageUrl;

  SuggestionItem({this.id, this.name, this.imageUrl});

  factory SuggestionItem.fromJson(Map<String, dynamic> json) => SuggestionItem(
    id: json["_id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "imageUrl": imageUrl,
  };
}

class SuggestionPagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  SuggestionPagination({this.page, this.limit, this.total, this.totalPages});

  factory SuggestionPagination.fromJson(Map<String, dynamic> json) =>
      SuggestionPagination(
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

class SearchRecipeResponse {
  final bool? error;
  final SearchRecipeData? data;

  SearchRecipeResponse({this.error, this.data});

  factory SearchRecipeResponse.fromJson(Map<String, dynamic> json) =>
      SearchRecipeResponse(
        error: json["error"],
        data: json["data"] == null
            ? null
            : SearchRecipeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class SearchRecipeData {
  final List<SearchRecipeItem>? items;
  final SearchRecipePagination? pagination;

  SearchRecipeData({this.items, this.pagination});

  factory SearchRecipeData.fromJson(Map<String, dynamic> json) =>
      SearchRecipeData(
        items: json["items"] == null
            ? []
            : List<SearchRecipeItem>.from(
                json["items"]!.map((x) => SearchRecipeItem.fromJson(x)),
              ),
        pagination: json["pagination"] == null
            ? null
            : SearchRecipePagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class SearchRecipeItem {
  final String? id;
  final String? code;
  final String? name;
  final String? slug;
  final String? shortDescription;
  final String? imageUrl;
  final Difficulty? difficulty;
  final int? cookTimeMinutes;
  final String? cuisineType;
  final String? mealType;
  final double? matchScore;
  final double? contextScore;
  final double? proteinAlignmentScore;
  final double? meatFormAlignmentScore;
  final double? recommendScore;
  final List<MatchedIngredient>? matchedIngredients;
  final List<String>? missingIngredients;
  final bool? isFavorite;

  SearchRecipeItem({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.shortDescription,
    this.imageUrl,
    this.difficulty,
    this.cookTimeMinutes,
    this.cuisineType,
    this.mealType,
    this.matchScore,
    this.contextScore,
    this.proteinAlignmentScore,
    this.meatFormAlignmentScore,
    this.recommendScore,
    this.matchedIngredients,
    this.missingIngredients,
    this.isFavorite,
  });

  factory SearchRecipeItem.fromJson(Map<String, dynamic> json) =>
      SearchRecipeItem(
        id: json["_id"],
        code: json["code"],
        name: json["name"],
        slug: json["slug"],
        shortDescription: json["shortDescription"],
        imageUrl: json["imageUrl"],
        difficulty: difficultyValues.map[json["difficulty"]]!,
        cookTimeMinutes: json["cookTimeMinutes"],
        cuisineType: json["cuisineType"],
        mealType: json["mealType"],
        matchScore: json["matchScore"]?.toDouble(),
        contextScore: json["contextScore"]?.toDouble(),
        proteinAlignmentScore: json["proteinAlignmentScore"]?.toDouble(),
        meatFormAlignmentScore: json["meatFormAlignmentScore"]?.toDouble(),
        recommendScore: json["recommendScore"]?.toDouble(),
        matchedIngredients: json["matchedIngredients"] == null
            ? []
            : List<MatchedIngredient>.from(
                json["matchedIngredients"]!.map(
                  (x) => matchedIngredientValues.map[x]!,
                ),
              ),
        missingIngredients: json["missingIngredients"] == null
            ? []
            : List<String>.from(json["missingIngredients"]!.map((x) => x)),
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "name": name,
    "slug": slug,
    "shortDescription": shortDescription,
    "imageUrl": imageUrl,
    "difficulty": difficultyValues.reverse[difficulty],
    "cookTimeMinutes": cookTimeMinutes,
    "cuisineType": cuisineType,
    "mealType": mealType,
    "matchScore": matchScore,
    "contextScore": contextScore,
    "proteinAlignmentScore": proteinAlignmentScore,
    "meatFormAlignmentScore": meatFormAlignmentScore,
    "recommendScore": recommendScore,
    "matchedIngredients": matchedIngredients == null
        ? []
        : List<dynamic>.from(
            matchedIngredients!.map((x) => matchedIngredientValues.reverse[x]),
          ),
    "missingIngredients": missingIngredients == null
        ? []
        : List<dynamic>.from(missingIngredients!.map((x) => x)),
    "isFavorite": isFavorite,
  };
}

enum Difficulty { EASY }

final difficultyValues = EnumValues({"easy": Difficulty.EASY});

enum MatchedIngredient { GARLIC, GROUND_BEEF, GROUND_PORK, SALT }

final matchedIngredientValues = EnumValues({
  "garlic": MatchedIngredient.GARLIC,
  "ground-beef": MatchedIngredient.GROUND_BEEF,
  "ground-pork": MatchedIngredient.GROUND_PORK,
  "salt": MatchedIngredient.SALT,
});

class SearchRecipePagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  SearchRecipePagination({this.page, this.limit, this.total, this.totalPages});

  factory SearchRecipePagination.fromJson(Map<String, dynamic> json) =>
      SearchRecipePagination(
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
