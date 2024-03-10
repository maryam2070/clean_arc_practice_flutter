import 'package:clean_arc_practice/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';
import 'package:clean_arc_practice/features/posts/domain/use_cases/add_post.dart';
import 'package:clean_arc_practice/features/posts/domain/use_cases/delete_post.dart';
import 'package:clean_arc_practice/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:clean_arc_practice/features/posts/domain/use_cases/update_post.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/network_info.dart';
import '../data/datasources/Post_remote_data_source.dart';
import '../data/datasources/post_local_data_source.dart';
import 'package:http/http.dart' as http;


final serviceLocator = GetIt.instance;

void setUp() {



  serviceLocator.registerSingleton<PostLocalDataSource>(PostLocalDataSourceImpl(sp: SharedPreferences.getInstance()));

    serviceLocator.registerSingleton<PostRemoteDataSource>(
        PostRemoteDataSourceImpl(client: http.Client()));

    serviceLocator.registerSingleton<NetworkInfo>(NetworkInfoImpl(
            checker: InternetConnectionChecker()));


  serviceLocator.registerSingleton<PostsRepository>(PostsRepositoryImpl(cache: serviceLocator.get(),
      network: serviceLocator.get(),
      networkInfo: serviceLocator.get()));

  serviceLocator.registerSingleton<GetAllPosts>(GetAllPosts(repo:serviceLocator.get()));
  serviceLocator.registerSingleton<AddPost>(AddPost(repo:serviceLocator.get()));
  serviceLocator.registerSingleton<UpdatePost>(UpdatePost(repo:serviceLocator.get()));
  serviceLocator.registerSingleton<DeletePost>(DeletePost(repo:serviceLocator.get()));

    // serviceLocator.registerLazySingleton<PostsRepository>(() =>
    //     PostsRepositoryImpl(cache: serviceLocator.get(),
    //         network: serviceLocator.get(),
    //         networkInfo: serviceLocator.get()));

}