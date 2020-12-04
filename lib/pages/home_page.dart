import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hfs/bloc/channel_cubit/cubit/channel_cubit.dart';
import 'package:hfs/bloc/user_cubit/stream_cubit.dart';
import 'package:hfs/pages/video_player_page.dart';

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
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserCubit, CubitStreamState>(
          builder: (context, state) {
            if (state is StreamUserState && state.hasData) {
              return _HomePageContent(
                pageController: pageController,
              );
            } else if (state is StreamUserState && state.isLoading) {
              return Center(
                child: SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is StreamUserState && state.hasError) {
              return Center(
                child: Text("We are having some problems loading videos :("),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent({Key key, @required this.pageController})
      : assert(pageController != null),
        super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(
            "Live Flutter",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200.0,
            child: PageView(
              controller: pageController,
              children: List.generate(
                3,
                (_) => FeaturedStreamCard(
                  onTap: () {
                    context.read<ChannelCubit>().configureChannel("");
                    Navigator.of(context).push(
                      PlayerPage.route(""),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 24.0, top: 42.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Browse",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(
              List.generate(
                8,
                (_) => FeaturedStreamCard(
                  onTap: () {
                    context.read<ChannelCubit>().configureChannel("");
                    Navigator.of(context).push(
                      PlayerPage.route(""),
                    );
                  },
                ),
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12.0,
            ),
          ),
        ),
      ],
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
