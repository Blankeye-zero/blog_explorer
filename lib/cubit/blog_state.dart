part of 'blog_cubit.dart';

class BlogState {
  List<BlogModel> blogList;
  List<BlogModel> favoriteList;
  List<BlogModel> downloadList;
  BlogState({required this.blogList, required this.favoriteList, required this.downloadList});
}