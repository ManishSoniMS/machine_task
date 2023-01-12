import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_task/models/product.dart';
import 'package:machine_task/models/user.dart';
import 'package:machine_task/services/dio_client.dart';

import '../utils/api_constants.dart';

class RemoteSource {
  final DioClient _dio = DioClient();
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  Future<AuthUser?> login(String email, String password) async {
    try {
      final result = await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user == null) return null;
      return AuthUser(id: user.uid, email: user.email!);
    } on FirebaseException catch (error) {
      if (error.code == "user-not-found") {
        final result = await _firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        final user = result.user;
        if (user == null) return null;
        return AuthUser(id: user.uid, email: user.email!);
      } else {
        return null;
      }
    } catch (error) {
      log("|---------------------------------------------------------------|");
      log("$error");
      return null;
    }
  }

  Future<AuthUser?> isUserLoggedIn() async {
    final user = _firebase.currentUser;

    if (user == null) return null;
    return AuthUser(id: user.uid, email: user.email!);
  }

  Future<void> logout() async {
    await _firebase.signOut();
  }

  Future<GetProducts> getAllProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    final response = await _dio.getDio().get(
      ApiConstants.products,
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );
    return GetProducts.fromMap(response.data);
  }

  Future<Product> getProductById(int productId) async {
    final response = await _dio.getDio().get(
          "${ApiConstants.products}/$productId",
        );
    return Product.fromMap(response.data);
  }

  Future<GetProducts> searchProduct({
    required String query,
    int limit = 20,
    int skip = 0,
  }) async {
    final response = await _dio.getDio().get(
      ApiConstants.products,
      queryParameters: {
        'q': query,
        'limit': limit,
        'skip': skip,
      },
    );
    return GetProducts.fromMap(response.data);
  }

  Future<List<String>> getCategories() async {
    final response = await _dio.getDio().get(
          ApiConstants.categories,
        );

    return (response.data as List).map((e) => e.toString()).toList();
  }

  Future<GetProducts> getProductsByCategory({
    required String category,
  }) async {
    final response = await _dio.getDio().get(
          "${ApiConstants.productsByCategory}/$category",
        );
    return GetProducts.fromMap(response.data);
  }
}
