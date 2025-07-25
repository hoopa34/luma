import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/manager_bloc/manager_bloc.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_images.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_homepage_cart.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_homepage_feed.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_homepage_home.dart';
import 'package:luma/ui/pages/buyer/homepage/page_buyer_homepage_settings.dart';
import 'package:luma/ui/pages/buyer/page_buyer_notifications.dart';
import 'package:luma/ui/pages/buyer/page_buyer_profile.dart';
import 'package:luma/ui/pages/buyer/page_buyer_search.dart';

class PageBuyerHomepage extends StatefulWidget {
  final int pageIndex;
  const PageBuyerHomepage({super.key, this.pageIndex = 1});

  @override
  State<PageBuyerHomepage> createState() => _PageBuyerHomepageState();
}

class _PageBuyerHomepageState extends State<PageBuyerHomepage>
    with TickerProviderStateMixin {
  final List<Widget> _pages = [
    PageBuyerHomepageFeed(),
    PageBuyerHomepageHome(),
    PageBuyerHomepageCart(),
    PageBuyerHomepageSettings(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.pageIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTransparent = false;

    final bloc = BlocProvider.of<ManagerBloc>(context);

    _tabController.addListener(() {
      bloc.add(ManagerPageChangeEvent(currentPage: _tabController.index));
    });

    return Scaffold(
      extendBodyBehindAppBar: isTransparent,
      extendBody: isTransparent,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        //backgroundColor: Colors.transparent,
        flexibleSpace: isTransparent == true
            ? ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.transparent),
                ),
              )
            : null,
        title: const Text("LUMA", style: AppTextStyles.logo),
        leading: Image(
          image: AppImages.appLogo,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        actions: [
          // SEARCH
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageBuyerSearch(),
                ),
              );
            },
            icon: Icon(AppIcons.search),
          ),

          // NOTIFICATIONS
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageBuyerNotifications(),
                ),
              );
            },
            icon: Icon(AppIcons.notifications),
          ),

          // PROFILE
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageBuyerProfile(),
                ),
              );
            },
            icon: Icon(AppIcons.account),
          ),
          SizedBox(width: 16),
        ],
      ),

      bottomNavigationBar: SizedBox(
        height: 64,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.article_outlined)),
                Tab(icon: Icon(Icons.home_outlined)),
                Tab(icon: Icon(AppIcons.shopCart)),
                Tab(icon: Icon(Icons.settings_outlined)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
