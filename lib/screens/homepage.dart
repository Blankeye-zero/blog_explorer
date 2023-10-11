import 'package:blog_explorer/screens/blog_detail.dart';
import 'package:blog_explorer/widgets/card_element.dart';
import 'package:blog_explorer/widgets/custom_appbar.dart';
import 'package:blog_explorer/widgets/custom_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/cubit/blog_cubit.dart';

import 'package:blog_explorer/data/model/blog_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool circularIndicator = false;
  @override
  void initState() {
    circularIndicator = true;
    BlocProvider.of<BlogCubit>(context)
        .updateBlogState()
        .then((value) => setState(() {
              circularIndicator = false;
            }))
        .catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(const SnackBar(content: Text('NETW; There is an error while fetching Data. Kindly try again later')));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey, screenHeight: height),
      body: Container(
        color: Colors.black,
        child: BlocBuilder<BlogCubit, BlogState>(
          builder: (context, state) {
            if(circularIndicator){
              return const Center(
                    child: CircularProgressIndicator(),
                  );
            } else {
              return ListView.builder(
                    addAutomaticKeepAlives: true,
                    cacheExtent: 10,
                    itemBuilder: (context, index) {
                      BlogModel blog = state.blogList[index];
                      final height = MediaQuery.of(context).size.height;
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogDetail(blog: blog),
                                ));
                          },
                          child: CardElement(
                            height: height,
                            blog: blog,
                            remove: false,
                            icon: 'download',
                          ));
                    },
                    itemCount: state.blogList.length,
                  ); 
            }
          }
        ),
      ),
    );
  }
}

