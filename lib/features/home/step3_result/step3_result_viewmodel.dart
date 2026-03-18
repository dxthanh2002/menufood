import 'package:flutter/material.dart';

class Step3ResultRecipe {
  const Step3ResultRecipe({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.highlight,
    required this.calories,
    required this.servings,
    required this.ingredients,
    required this.instructions,
  });

  final String title;
  final String imageUrl;
  final String description;
  final String duration;
  final String difficulty;
  final String highlight;
  final String calories;
  final String servings;
  final List<RecipeIngredientItem> ingredients;
  final List<RecipeInstructionStep> instructions;
}

class RecipeIngredientItem {
  const RecipeIngredientItem({required this.name, required this.note});

  final String name;
  final String note;
}

class RecipeInstructionStep {
  const RecipeInstructionStep({required this.title, required this.description});

  final String title;
  final String description;
}

class Step3ResultViewModel extends ChangeNotifier {
  final List<Step3ResultRecipe> recipes = const [
    Step3ResultRecipe(
      title: 'Tomato Egg Stir Fry',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAg6A3Tu_TzKxQ2J57-RQH0Uafuv3i_RREv26tviLdGTNhpiN6S1vP9kK0SVfcFl9ZQp0e4_1DLGWDdMIKH_O9NQ9rZvdDUlBXB63idVAlEeMAj5O4QG5V89xTktYmIN7lSnjasYBBgqWxuuHASRKaXFl8n-dC-OkR9Z3tkPPPlJ157Ok5cQ6taw6syvLn7y9kncUAsORo3i9XfmL1IOenmVD2OtVWGI1pAO1fRBF0jk2v1Km8cv25_cJ6i3bzumOoXwHRyklFohnk',
      description:
          "A classic Chinese comfort dish that's sweet, savory, and incredibly fast to make.",
      duration: '15 mins',
      difficulty: 'Easy',
      highlight: 'Healthy',
      calories: '350 kcal',
      servings: '4 servings',
      ingredients: [
        RecipeIngredientItem(name: '4 Large organic eggs', note: 'fresh'),
        RecipeIngredientItem(name: '3 Medium ripe tomatoes', note: 'wedged'),
        RecipeIngredientItem(name: '2 Scallions', note: 'chopped'),
        RecipeIngredientItem(
          name: '1 tbsp Soy sauce & Sugar',
          note: 'seasoning',
        ),
      ],
      instructions: [
        RecipeInstructionStep(
          title: 'Prep the eggs',
          description:
              'Crack eggs into a bowl, add a pinch of salt and a splash of water. Beat well until frothy.',
        ),
        RecipeInstructionStep(
          title: 'Scramble',
          description:
              'Heat oil in a wok. Pour in eggs and scramble lightly until just set. Remove and set aside.',
        ),
        RecipeInstructionStep(
          title: 'Saute Tomatoes',
          description:
              'Add more oil if needed. Stir-fry tomatoes until softened and juices start to release.',
        ),
        RecipeInstructionStep(
          title: 'Combine',
          description:
              'Add eggs back, season with soy sauce and sugar. Garnish with scallions and serve hot.',
        ),
      ],
    ),
    Step3ResultRecipe(
      title: 'Beef Onion Stir Fry',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB3NW0jIWvYUfJVbE9vAnyLBO8kn5ZP0e2l0KSIsRl6mg65Lzj3FNdnnA9NxnJzDhfjmWq56sbhRZ6OciVwotZm7So8f7Hf4XdXKPlDJ71UnuXMVorJ_YF9tk2D3fzkInd9p_rFg9DoKAPhYNTiq31ahFbah1cGkLsFzY_eTCDxRSqu6WzR2LXyzxMAfdNbqOCMHbUNzmh8ACbCZCfirb2r9Sxtc48KrsKXGFePEAyXQ0IsuF1EuT0NKi3sWT9_dK_sWsq3dNmv1TQ',
      description:
          'A savory weeknight stir fry with tender beef, sweet onions, and a glossy pan sauce.',
      duration: '20 mins',
      difficulty: 'Medium',
      highlight: 'Popular',
      calories: '420 kcal',
      servings: '2 servings',
      ingredients: [
        RecipeIngredientItem(name: '250 g Beef slices', note: 'marinated'),
        RecipeIngredientItem(name: '1 Large onion', note: 'sliced'),
        RecipeIngredientItem(name: '2 cloves Garlic', note: 'minced'),
        RecipeIngredientItem(name: '2 tbsp Soy oyster sauce', note: 'sauce'),
      ],
      instructions: [
        RecipeInstructionStep(
          title: 'Marinate beef',
          description:
              'Season beef with soy sauce, pepper, and a little cornstarch for extra tenderness.',
        ),
        RecipeInstructionStep(
          title: 'Sear quickly',
          description:
              'Cook the beef over high heat until browned on the edges, then transfer out of the pan.',
        ),
        RecipeInstructionStep(
          title: 'Cook aromatics',
          description:
              'Saute onion and garlic until fragrant and lightly caramelized.',
        ),
        RecipeInstructionStep(
          title: 'Finish the stir fry',
          description:
              'Return the beef, coat everything in the sauce, and toss until glossy and hot.',
        ),
      ],
    ),
    Step3ResultRecipe(
      title: 'Tomato Egg Soup',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDKYd2mf1OGlnS2V9YYQkdYqBQeO2c2VrsgWmb7yZD6Vz1ozWCr95qBz-ThAOyXYIDrwQQbPyNkIr-lkjvPHkueyPHBZI2GLoNyLprs2V_3Cr1ZBGmdqA78yLnoaibdKPC7D01vNWQV1rw60XXXnxPqaUciWkTgNyNyAG06vJDBRKXaLedUSAhfQabM-V0RSMXgXSqf8ZXWy07mL43lf9CmhowA21lYddMa-u_LA8A43oEMwhPtRJ5YKP7N29SRnZuSX-xWNWsLW3M',
      description:
          'A light, silky soup with tomato richness and ribbons of soft egg in every spoonful.',
      duration: '10 mins',
      difficulty: 'Easy',
      highlight: 'Quick',
      calories: '210 kcal',
      servings: '3 servings',
      ingredients: [
        RecipeIngredientItem(name: '2 Tomatoes', note: 'chopped'),
        RecipeIngredientItem(name: '2 Eggs', note: 'beaten'),
        RecipeIngredientItem(name: '3 cups Stock', note: 'hot'),
        RecipeIngredientItem(name: '1 tsp Sesame oil', note: 'finish'),
      ],
      instructions: [
        RecipeInstructionStep(
          title: 'Build the broth',
          description:
              'Bring stock to a simmer and cook the tomatoes until they soften into the liquid.',
        ),
        RecipeInstructionStep(
          title: 'Season gently',
          description:
              'Add salt, white pepper, and a touch of soy sauce to round out the flavor.',
        ),
        RecipeInstructionStep(
          title: 'Stream in the eggs',
          description:
              'Slowly pour the beaten eggs into the simmering soup while stirring for silky ribbons.',
        ),
        RecipeInstructionStep(
          title: 'Finish and serve',
          description:
              'Top with scallions and sesame oil, then serve immediately while hot.',
        ),
      ],
    ),
  ];
}
