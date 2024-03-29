import 'package:flutter/material.dart';
import 'package:spotify_clone/domain/api_endpoints.dart';

import 'package:spotify_clone/widgets/main_podcast_widget.dart';
import 'package:spotify_clone/widgets/main_track_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> tabs = [
    Tab(text: 'Music'),
    Tab(text: 'Podcasts & Shows'),
  ];
  Future<void> _loadContent() async {
    // Perform any asynchronous loading tasks here
    // For example, fetching data from an API or loading other resources
    await Future.delayed(Duration(seconds: 2));
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_none_rounded,
                            size: 24,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Icon(Icons.access_time, size: 24),
                          SizedBox(
                            width: 25,
                          ),
                          Icon(Icons.settings_outlined, size: 24),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0), // Height of the tab bar
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align the tabs to the left
                children: [
                  for (final tab in tabs)
                    GestureDetector(
                      onTap: () {
                        _tabController.animateTo(tabs.indexOf(tab));
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 24.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Color(0xFF2A2A2A),
                            ),
                            child: Text(
                              tab.text!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(width: 20.0),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FutureBuilder(
            future: _loadContent(), // Use the future method here
            builder: (context, snapshot) {
              // Check the connection state of the future
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is loading, display the circular progress indicator
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // Data is loaded, display the content
                return TabBarView(
                  controller: _tabController, // Use the TabController here
                  children: [
                    ListView(
                      children: [
                        MainTrackWidget(
                          title: 'Recommendations',
                          url: ApiEndPoints.recommendations1,
                        ),
                        MainTrackWidget(
                          title: 'Featured Playlists',
                          url: ApiEndPoints.featuredPlaylists,
                        ),
                        MainTrackWidget(
                          title: 'Trending',
                          url: ApiEndPoints.recommendations2,
                        ),
                        MainTrackWidget(
                          title: 'Made For You',
                          url: ApiEndPoints.recommendations3,
                        ),
                        MainTrackWidget(
                          title: 'New Releases',
                          url: ApiEndPoints.recommendations4,
                        ),
                        MainTrackWidget(
                          title: 'Recently Played',
                          url: ApiEndPoints.recommendations5,
                        ),
                      ],
                    ),
                    MainPodcastWidget(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
      