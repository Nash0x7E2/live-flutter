import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hfs/backend/stream_backend.dart';
import 'package:hfs/pages/landing_page.dart';
import 'package:hfs/pages/video_player_page.dart';
import 'package:hfs/providers/backend_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(HLSPOC());
}

class HLSPOC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackendProvider(
      backend: StreamBackEnd(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return HomePage();
      },
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HFS",
          style: TextStyle(fontSize: 24.0),
        ),
        backgroundColor: const Color(0xff4d7bfe),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24.0),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200.0,
                child: PageView(
                  controller: pageController,
                  children: [
                    FeaturedStreamCard(
                      onTap: () => Navigator.of(context).push(
                        PlayerPage.route(""),
                      ),
                    ),
                    FeaturedStreamCard(
                      onTap: () => Navigator.of(context).push(
                        PlayerPage.route(""),
                      ),
                    ),
                    FeaturedStreamCard(
                      onTap: () => Navigator.of(context).push(
                        PlayerPage.route(""),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedStreamCard extends StatelessWidget {
  const FeaturedStreamCard({
    Key key,
    @required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Image.network(
            "https://source.unsplash.com/random/1600×900",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
