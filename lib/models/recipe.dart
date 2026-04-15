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
  final NutritionDetail? nutrition;
  final TimesDetail? times;
  final List<IngredientDetail>? ingredients;
  final List<StepDetail>? steps;
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
        : NutritionDetail.fromJson(json["nutrition"]),
    times: json["times"] == null ? null : TimesDetail.fromJson(json["times"]),
    ingredients: json["ingredients"] == null
        ? []
        : List<IngredientDetail>.from(
            json["ingredients"]!.map((x) => IngredientDetail.fromJson(x)),
          ),
    steps: json["steps"] == null
        ? []
        : List<StepDetail>.from(
            json["steps"]!.map((x) => StepDetail.fromJson(x)),
          ),
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

class IngredientDetail {
  final String? key;
  final String? name;
  final double? quantity;
  final String? unit;
  final String? note;
  final bool? isOptional;

  IngredientDetail({
    this.key,
    this.name,
    this.quantity,
    this.unit,
    this.note,
    this.isOptional,
  });

  factory IngredientDetail.fromJson(Map<String, dynamic> json) =>
      IngredientDetail(
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

class NutritionDetail {
  final int? calories;
  final int? protein;
  final int? carbs;
  final int? fat;
  final int? fiber;

  NutritionDetail({
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
  });

  factory NutritionDetail.fromJson(Map<String, dynamic> json) =>
      NutritionDetail(
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

class StepDetail {
  final int? stepNumber;
  final String? title;
  final String? content;
  final String? imageUrl;
  final int? durationMinutes;

  StepDetail({
    this.stepNumber,
    this.title,
    this.content,
    this.imageUrl,
    this.durationMinutes,
  });

  factory StepDetail.fromJson(Map<String, dynamic> json) => StepDetail(
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

class TimesDetail {
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? totalTimeMinutes;

  TimesDetail({
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.totalTimeMinutes,
  });

  factory TimesDetail.fromJson(Map<String, dynamic> json) => TimesDetail(
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
  final String? difficulty;
  final int? cookTimeMinutes;
  final String? cuisineType;
  final String? mealType;
  final double? matchScore;
  final double? contextScore;
  final double? proteinAlignmentScore;
  final double? meatFormAlignmentScore;
  final double? recommendScore;
  final List<String>? matchedIngredients;
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
        difficulty: json["difficulty"],
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
            : List<String>.from(json["matchedIngredients"]!.map((x) => x)),
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
    "difficulty": difficulty,
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
        : List<dynamic>.from(matchedIngredients!.map((x) => x)),
    "missingIngredients": missingIngredients == null
        ? []
        : List<dynamic>.from(missingIngredients!.map((x) => x)),
    "isFavorite": isFavorite,
  };
}

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

class RecipeTrendingResponse {
  final bool? error;
  final TrendingData? data;

  RecipeTrendingResponse({this.error, this.data});

  factory RecipeTrendingResponse.fromJson(Map<String, dynamic> json) =>
      RecipeTrendingResponse(
        error: json["error"],
        data: json["data"] == null ? null : TrendingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class TrendingData {
  final List<TrendingItem>? items;
  final Pagination? pagination;

  TrendingData({this.items, this.pagination});

  factory TrendingData.fromJson(Map<String, dynamic> json) => TrendingData(
    items: json["items"] == null
        ? []
        : List<TrendingItem>.from(
            json["items"]!.map((x) => TrendingItem.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class TrendingItem {
  final String? id;
  final String? name;
  final String? imageUrl;
  final int? totalTimeMinutes;
  final String? difficulty;
  final bool? isFavorite;
  final double? score;

  TrendingItem({
    this.id,
    this.name,
    this.imageUrl,
    this.totalTimeMinutes,
    this.difficulty,
    this.score,
    this.isFavorite,
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) => TrendingItem(
    id: json["_id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    totalTimeMinutes: json["totalTimeMinutes"],
    difficulty: json["difficulty"],
    score: json["score"]?.toDouble(),
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "imageUrl": imageUrl,
    "totalTimeMinutes": totalTimeMinutes,
    "difficulty": difficulty,
    "score": score,
    "isFavorite": isFavorite,
  };
}

class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
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
