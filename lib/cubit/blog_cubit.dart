import 'package:bloc/bloc.dart';
import 'package:blog_explorer/data/model/blog_model.dart';
import 'package:blog_explorer/data/repos/blog_repo.dart';
import 'package:flutter/foundation.dart';
part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit()
      : super(BlogState(blogList: [], favoriteList: [], downloadList: []));

  Future<void> updateBlogState() {
    try{
      return BlogRepo().generateBlogList().then((blogList) {
      // blogList = blogList.where((blog) => blog.imageUrl != "https://cdn.subspace.money/whatsub_blogs/slate(1).png").toList();
      state.blogList = [...blogList];
      emit(state);
    });
    } catch(error){
      if(kDebugMode){
        print(error);
      }
      rethrow;
    }
  }

  Future<void> updateFavoriteState() {
    try{
      return BlogRepo().generateFavoriteList().then((favoriteList) {
      emit(BlogState(blogList: state.blogList, favoriteList: favoriteList, downloadList: state.downloadList));
    });
    }catch(error){
      if(kDebugMode){
        print(error);
      }
      rethrow;
    }
    
  }

  Future<void> updateDownloadState() {
    try{
      return BlogRepo().generateDownloadList().then((downloadList) {
      emit(BlogState(blogList: state.blogList, favoriteList: state.favoriteList, downloadList: downloadList));
    });
    }catch (error){
      if(kDebugMode){
        print(error);
      }
      rethrow;
    }

  }
}
