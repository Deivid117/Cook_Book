import 'package:cook_book_app/src/screens/add_recipe_page.dart';
import 'package:cook_book_app/src/screens/details_page.dart';
import 'package:cook_book_app/src/screens/login_page.dart';
import 'package:cook_book_app/src/screens/my_favorites_page.dart';
import 'package:cook_book_app/src/screens/my_recipes_page.dart';
import 'package:cook_book_app/src/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

import 'connection/server_controller.dart';
import 'screens/home_page.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 22)),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
              backgroundColor: Colors.cyan)
          //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[300])
          ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginPage(
                serverController: _serverController,
                context: context,
              );

            case "/home":
              User loggedUser = settings.arguments as User;
              _serverController.loggedUser = loggedUser;
              return HomePage(serverController: _serverController);

            case "/register":
              User? loggedUser = settings.arguments as User?;
              return RegisterPage(
                serverController: _serverController,
                context: context,
                userToEdit: loggedUser,
              );

            case "/favorites":
              return MyFavoritesPage(
                serverController: _serverController,
              ); 

            case "/my_recipes":
              return MyRecipesPage(
                serverController: _serverController,
              ); 

            case "/details":
              Recipe recipe = settings.arguments as Recipe;
              return DetailsPage(
                serverController: _serverController, recipe: recipe,
              );     

            case "/add_recipe":
              return AddRecipePage(
                serverController: _serverController,
              );      

            case "/edit_recipe":
              Recipe recipe = settings.arguments as Recipe;
              return AddRecipePage(
                serverController: _serverController,
                recipe: recipe,
              );    
          }
          return LoginPage(
            serverController: _serverController,
            context: context,
          );
        });
      },
    );
  }
}
