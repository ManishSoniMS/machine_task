import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_task/bloc/auth/auth_bloc.dart';
import 'package:machine_task/bloc/search/search_bloc.dart';
import 'package:machine_task/pages/splash.dart';

import 'bloc/categories/categories_cubit.dart';
import 'bloc/get_products/get_products_cubit.dart';
import 'bloc/product_details/product_details_cubit.dart';
import 'bloc/products_by_category/products_by_category_cubit.dart';
import 'pages/home.dart';
import 'pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(const AuthEvent.started()),
        ),
        BlocProvider<GetProductsCubit>(
          create: (context) => GetProductsCubit()..fetch(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit()..fetch(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<ProductDetailsCubit>(
          create: (context) => ProductDetailsCubit(),
        ),
        BlocProvider<ProductDetailsCubit>(
          create: (context) => ProductDetailsCubit(),
        ),
        BlocProvider<ProductsByCategoryCubit>(
          create: (context) => ProductsByCategoryCubit(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return state.maybeWhen(authenticated: (_) {
              return const HomePage();
            }, orElse: () {
              return const LoginPage();
            }, initial: () {
              return const Splash();
            });
          }),
        ),
      ),
    );
  }
}
