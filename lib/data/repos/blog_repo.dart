import 'package:blog_explorer/data/model/blog_model.dart';
import 'package:blog_explorer/data/network/network_service.dart';
import 'package:blog_explorer/helpers/sql_helper.dart';
import 'package:flutter/foundation.dart';

class BlogRepo {
  NetworkService nt = NetworkService();

  Future<List<BlogModel>> generateBlogList() {
    try {
      return nt.fetchBlogPosts().then((response) =>
          response.map((blog) => BlogModel.fromJson(blog)).toList());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Error occured when fetching blog list. Kindly Try again Later');
    }
  }

  Future<List<BlogModel>> generateFavoriteList() {
    try {
      return SQLHelper.getFavorites().then((favoriteList) =>
          favoriteList.map((blog) => BlogModel.fromJson(blog)).toList());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Error occurred when fetching your favorite list. Kindly try again later');
    }
  }

  Future<List<BlogModel>> generateDownloadList() {
    try {
      return SQLHelper.getDownloads().then((downloadList) =>
          downloadList.map((blog) => BlogModel.fromJson(blog)).toList());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Error occurred when fetching your downloads. Kindly try again later');
    }
  }

  Future<void> addDownload(BlogModel blog) {
    try {
      return SQLHelper.addDownload(blog.id, blog.title, blog.imageUrl);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw
      Exception(
          'CODE:REPO; Error occurred while downloading . Kindly try again later');
    }
  }

  Future<void> addFavorite(BlogModel blog) {
    try {
      return SQLHelper.addFavorite(blog.id, blog.title, blog.imageUrl);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Error occurred while adding to your Favorites . Kindly try again later');
    }
  }

  Future<void> deleteFavorite(String id) {
    try {
      return SQLHelper.deleteFavorite(id);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Cannot remove this entry from favorite. Kindly try again later');
    }
  }

  Future<void> deleteDownload(String id) {
    try {
      return SQLHelper.deleteDownload(id);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:REPO; Cannot delete this blog from downloads. Kindly try again later');
    }
  }
}
