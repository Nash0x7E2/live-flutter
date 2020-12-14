import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hfs/bloc/archived_videos_cubit/archived_videos_cubit.dart';
import 'package:hfs/bloc/channel_cubit/channel_cubit.dart';
import 'package:hfs/bloc/livevideos_cubit/livestream_cubit.dart';
import 'package:hfs/bloc/user_cubit/stream_cubit.dart';
import 'package:hfs/models/video_model.dart';
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
  const _HomePageContent({
    Key key,
    @required this.pageController,
  })  : assert(pageController != null),
        super(key: key);
  final PageController pageController;

  void onFeatureCardPressed(BuildContext context, Video item) {
    context.read<ChannelCubit>().configureChannel(item.playbackUrl);
    Navigator.of(context).push(
      PlayerPage.route(item.playbackUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LivestreamCubit>().loadStreams();
        context.read<ArchivedVideosCubit>().getArchivedVideos();
      },
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              "Live Flutter",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BlocBuilder<LivestreamCubit, LivestreamState>(
            builder: (BuildContext context, LivestreamState state) {
              final hasData = state is DataLiveStreamState &&
                  !state.isLoading &&
                  state.videos.isNotEmpty;
              final noVideos = state is DataLiveStreamState &&
                  !state.isLoading &&
                  state.videoCount == 0;

              if (hasData && state is DataLiveStreamState) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200.0,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: state.videoCount,
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.videos[index];
                        return FeaturedStreamCard(
                          thumbnailUrl: item.thumbnailUrl,
                          onTap: () => onFeatureCardPressed(context, item),
                        );
                      },
                    ),
                  ),
                );
              } else if (noVideos && state is DataLiveStreamState) {
                return SliverToBoxAdapter(
                  child: const SizedBox(
                    height: 200.0,
                    child: Center(
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 100,
                        color: Color(0xFF0047ff),
                      ),
                    ),
                  ),
                );
              } else if (state is DataLiveStreamState && state.hasError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child:
                        Text("Oops, we are having some problem connecting :/"),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }
            },
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
            sliver: BlocBuilder<ArchivedVideosCubit, ArchivedVideosState>(
              builder: (BuildContext context, ArchivedVideosState state) {
                final hasData = state is DataArchivedVideosState &&
                    !state.isLoading &&
                    state.videoCount > 1;
                if (hasData && state is DataArchivedVideosState) {
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.videos[index];
                        return FeaturedStreamCard(
                          thumbnailUrl: item.thumbnailUrl,
                          onTap: () => onFeatureCardPressed(context, item),
                        );
                      },
                      childCount: state.videoCount,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7,
                      crossAxisSpacing: 12.0,
                    ),
                  );
                } else if (state is DataArchivedVideosState && state.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                          "Oops, we are having some problem connecting :/"),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedStreamCard extends StatelessWidget {
  const FeaturedStreamCard({
    Key key,
    @required this.onTap,
    this.thumbnailUrl,
  }) : super(key: key);
  final VoidCallback onTap;
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Image.network(
            thumbnailUrl,
            errorBuilder: (context, _, __){
              return Image.asset("assets/logo.png");
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
