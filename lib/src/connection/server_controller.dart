import 'package:flutter/widgets.dart';
import 'package:flutter_modulo1_fake_backend/data_init.dart';
import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart' as server;
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class ServerController {
  User? loggedUser;

  // Generar datos iniciándolos para nuestro fake backend
  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User?> login(String userName, String password) async{
    // Con el await esperamos a que la petición termine
    return await server.backendLogin(userName, password);
  }

  Future<bool> addUser(User nUser) async {
    return await server.addUser(nUser);
  }

  Future<bool> updateUser(User user) async {
    loggedUser = user;
    return await server.updateUser(user);
  }

  Future<Recipe> addRecipe(Recipe nRecipe) async {
    nRecipe.id = recipes.length + 1;
    recipes.add(nRecipe);
    return nRecipe;
  }

  Future<bool> updateRecipe(Recipe recipe) async {
    return await server.updateRecipe(recipe);
  }

  Future<List<Recipe>> getRecipeList() async {
    return await server.getRecipes();
  }

   Future<Recipe> addFavorite(Recipe nFavorite) async {
    return await server.addFavorite(nFavorite);
  }

  Future<bool> deleteFavorite(Recipe favoriteRecipe) async {
    return await server.deleteFavorite(favoriteRecipe);
  }

  Future<bool> getIsFavorite(Recipe recipeToCheck) async {
    return await server.isFavorite(recipeToCheck);
  }

  Future<List<Recipe>> getFavoritesList() async {
    return await server.getFavorites();
  }

  Future<List<Recipe>> getUserRecipesList() async {
    return await server.getUserRecipes(loggedUser!);
  }
}
