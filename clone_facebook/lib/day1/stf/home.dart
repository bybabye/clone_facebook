import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clone_facebook/day2/stf/post_page.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/provider/post_provider.dart';
import 'package:clone_facebook/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _sizeH;
  late double _sizeW;
  late AuthencationProvider _auth;
  late PostProvider postProvider;
  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => PostProvider(_auth),
      ),
    ], child: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      postProvider = context.watch<PostProvider>();
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    "facebook",
                    textStyle: AppStyle.h4,
                  )
                ],
              ),
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostPage(),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(_auth.user.avatar ?? _auth.avatar),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("What do you think ?? "),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              expandedHeight: 150.0,
              actions: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Text(postProvider.posts[0].post.bio ?? "null"),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
