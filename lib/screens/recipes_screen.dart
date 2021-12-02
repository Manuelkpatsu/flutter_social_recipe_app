import 'package:flutter/material.dart';
import 'package:fluttersocialrecipeapp/components/recipes_grid_view.dart';
import 'package:fluttersocialrecipeapp/models/simple_recipe.dart';

import '../api/mock_fooderlich_service.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({Key? key}) : super(key: key);

  final exploreService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
