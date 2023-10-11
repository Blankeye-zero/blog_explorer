import 'package:blog_explorer/cubit/blog_cubit.dart';
import 'package:blog_explorer/data/model/blog_model.dart';
import 'package:blog_explorer/data/repos/blog_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildIcon(
    String icon, bool remove, BlogModel blog, BuildContext context) {
  switch (icon) {
    case 'download':
      return CircleAvatar(
          child: IconButton(
              onPressed: () {
                try {
                  if(remove){
                    BlogRepo().deleteDownload(blog.id).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Blog post has been deleted!')));
                  }).then((value) {BlocProvider.of<BlogCubit>(context).updateDownloadState();});
                  } else {
                    BlogRepo().addDownload(blog).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Blog post downloaded!')));
                  }).then((value) => BlocProvider.of<BlogCubit>(context).updateDownloadState());
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                }
              },
              icon: remove ? const Icon(Icons.delete) : const Icon(Icons.download)));
    case 'favorite':
      return CircleAvatar(
          child: IconButton(
              onPressed: () {
                try {
                  if(remove){
                    BlogRepo().deleteFavorite(blog.id).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Blog post has been removed from favorites!')));
                  }).then((value) => BlocProvider.of<BlogCubit>(context).updateFavoriteState());
                  } else {
                    BlogRepo().addFavorite(blog).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Blog post has been added to favorites!')));
                  }).then((value) => BlocProvider.of<BlogCubit>(context).updateFavoriteState());
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                }
              },
              icon: remove ? const Icon(Icons.delete) : const Icon(Icons.favorite)));
    default: return const CircleAvatar(child: Placeholder(),);
  }
}

class CardElement extends StatelessWidget {
  final BlogModel blog;

  final double height;

  final String icon;

  final bool remove;

  const CardElement(
      {super.key,
      required this.height,
      required this.blog,
      required this.icon,
      required this.remove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    height: height * 1 / 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(blog.imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: buildIcon(icon, remove, blog, context))
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    blog.title,
                    style: const TextStyle(
                        fontFamily: 'Gilroy Bold', fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
