import 'package:clean_arc_practice/core/navigation/router.dart';
import 'package:clean_arc_practice/core/navigation/routes.dart';
import 'package:clean_arc_practice/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/posts/di/dependency_injection_module.dart';
import 'features/posts/presentation/bloc/operations/operations_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();

  final serviceLocator = GetIt.instance;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => OperationsBloc(
            addPost: serviceLocator.get(),
            deletePost: serviceLocator.get(),
            updatePost: serviceLocator.get()),
      ),
      BlocProvider(
        create: (context) => PostsBloc(getAllPosts: serviceLocator.get()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.postListRoute,
      onGenerateRoute: onGenerate,
    );
  }
}
