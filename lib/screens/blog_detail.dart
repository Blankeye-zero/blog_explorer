import 'package:blog_explorer/data/model/blog_model.dart';
import 'package:blog_explorer/data/repos/blog_repo.dart';
import 'package:blog_explorer/widgets/custom_appbar.dart';
import 'package:blog_explorer/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class BlogDetail extends StatelessWidget {
  final BlogModel blog;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BlogDetail({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey, screenHeight: height),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: const Icon(
            Icons.favorite,
            color: Colors.black,
          ),
          onPressed: () {
            try {
              BlogRepo().addFavorite(blog).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Blog post added to Favorites!')));
              }).then((value) => BlogRepo().generateFavoriteList());
            } catch (error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            }
          }),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: height * 1 / 4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(blog.imageUrl), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Text(
                    blog.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                const Center(
                  child: Text(
                    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis vel eros donec ac. Lobortis scelerisque fermentum dui faucibus in ornare. Cras ornare arcu dui vivamus arcu felis bibendum ut tristique. Sed elementum tempus egestas sed sed risus pretium quam vulputate. Gravida quis blandit turpis cursus in hac habitasse platea dictumst. Lectus urna duis convallis convallis tellus id interdum velit. Tellus mauris a diam maecenas sed. Congue quisque egestas diam in arcu. Volutpat blandit aliquam etiam erat velit. Laoreet suspendisse interdum consectetur libero id. Dictum fusce ut placerat orci nulla pellentesque dignissim enim sit. Sit amet luctus venenatis lectus magna fringilla.
                  
                  Sed ullamcorper morbi tincidunt ornare. Dignissim suspendisse in est ante in. Justo nec ultrices dui sapien. Convallis a cras semper auctor. Sed arcu non odio euismod lacinia at. Euismod quis viverra nibh cras pulvinar mattis nunc sed. Felis donec et odio pellentesque diam volutpat commodo. Nibh praesent tristique magna sit amet purus gravida. Egestas congue quisque egestas diam in arcu cursus. Et egestas quis ipsum suspendisse ultrices gravida. Et tortor at risus viverra adipiscing. Et netus et malesuada fames ac turpis egestas maecenas. Malesuada proin libero nunc consequat interdum. Est sit amet facilisis magna etiam tempor orci.''',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
