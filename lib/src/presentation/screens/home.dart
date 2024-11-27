import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:unsplash/src/core/app_assets.dart';
import 'package:unsplash/src/presentation/provider/home_provider.dart';
import 'package:unsplash/src/presentation/widgets/app_space_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoBlack),
            setWidth(16),
            Text(
              'Unsplash',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(AppAssets.loading, height: 200, width: 200),
                  setHeight(32),
                  Text(
                    'Please wait...',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }
          if (state.imageList.isNotEmpty) {
            return RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {
                state.getImages();
              },
              child: CustomScrollView(
                controller: state.scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 16,
                        children: [
                          ...List.generate(state.imageList.length, (index) {
                            final images = state.imageList[index];
                            return StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: index.isEven ? 1.5 : 1.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Image.network(
                                          '${images.urls?.regular}',
                                          fit: BoxFit.cover,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                                strokeCap: StrokeCap.round,
                                                strokeWidth: 2,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  setHeight(16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${images.altDescription}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      setWidth(32),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            showDragHandle: true,
                                            context: context,
                                            routeSettings:
                                                RouteSettings(arguments: state),
                                            builder: (context) {
                                              final provider =
                                                  ModalRoute.of(context)
                                                          ?.settings
                                                          .arguments
                                                      as HomeProvider;

                                              return ListenableProvider(
                                                create: (context) => provider,
                                                child: Consumer<HomeProvider>(
                                                  builder:
                                                      (context, pro, child) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 32,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton
                                                                  .icon(
                                                                icon: pro
                                                                        .isDownloading
                                                                    ? const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeCap:
                                                                              StrokeCap.round,
                                                                          strokeWidth:
                                                                              2,
                                                                        ),
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .download,
                                                                      ),
                                                                onPressed: () {
                                                                  pro.downloadImage(
                                                                    images.urls
                                                                            ?.raw ??
                                                                        '',
                                                                  );
                                                                },
                                                                label:
                                                                    const Text(
                                                                  'Download Image',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon:
                                            const Icon(CupertinoIcons.ellipsis),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  if (state.paginationLoading)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Lottie.asset(
                          AppAssets.loading,
                          height: 150,
                          width: 150,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
          if (state.failure != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(AppAssets.errorLottie, height: 200, width: 200),
                  setHeight(32),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  setHeight(32),
                  ElevatedButton(
                    onPressed: () {
                      state.getImages();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
