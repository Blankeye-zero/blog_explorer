import 'package:blog_explorer/screens/blog_detail.dart';
import 'package:blog_explorer/widgets/card_element.dart';
import 'package:blog_explorer/widgets/custom_appbar.dart';
import 'package:blog_explorer/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/cubit/blog_cubit.dart';

import 'package:blog_explorer/data/model/blog_model.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool circularIndicator = false;
  @override
  void initState() {
    circularIndicator = true;
    BlocProvider.of<BlogCubit>(context)
        .updateDownloadState()
        .then((value) => setState(() {
              circularIndicator = false;
            }));
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
          buildWhen: (previous, current) => previous.downloadList.length != current.downloadList.length ,
          builder: (context,state) {
            if(circularIndicator){
              return const Center(
                    child: CircularProgressIndicator(),
                  );
            }
            if(state.downloadList.isEmpty){
              return const Center(
                child: Text('Your downloads box is Empty!!', style: TextStyle(color: Colors.white),),
              );
            } else {
              return ListView.builder(
                  addAutomaticKeepAlives: true,
                  cacheExtent: 10,
                    itemBuilder: (context, index) {
                      BlogModel blog = state.downloadList[index];
                      final height = MediaQuery.of(context).size.height;
                      return InkWell(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blog: blog),));
                      },child: CardElement(height: height, blog: blog, remove: true,icon: 'download',));
                    },
                    itemCount: state.downloadList.length,
                  );
            }
          }
        ),
      ),
    );
  }
}
