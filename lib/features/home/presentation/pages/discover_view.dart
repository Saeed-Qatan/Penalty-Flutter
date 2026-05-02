import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/promo_banner.dart';
import '../widgets/nearby_courts_list.dart';
import '../widgets/featured_courts_list.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(LoadHomeDataEvent()),
      child: const DiscoverViewBody(),
    );
  }
}

class DiscoverViewBody extends StatelessWidget {
  const DiscoverViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(child: CircularProgressIndicator(color: AppColors.neonGreen));
        } else if (state is HomeError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(LoadHomeDataEvent());
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        } else if (state is HomeLoaded) {
          final data = state.homeData;
          return RefreshIndicator(
            color: AppColors.neonGreen,
            backgroundColor: AppColors.surface,
            onRefresh: () async {
              context.read<HomeBloc>().add(LoadHomeDataEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(
                      userName: 'فهد',
                      profileImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBwbvFILYrhBkxUN4NKAEJamNcgTfTeDDkdksUiptYlcyVCNI9xKngT2HredqnwDUSj_XzPUgARYdvGsGsvQrw4D5kSiMKeH-I7Slfo3H1qiJ-jxODj3i22oKhpmnRDVrlsE5cIfiLYE9d1uC6cYQiCAlyM1vhwICCUPHtTmYZKijZ3auDkYdfpgpR31fAxLOlmfijAxa1W-cz6Dv3PViruFRpQJo27LtP8QlQhTJxbrDjtrsCiBs7gOJ9ylvTQ09cAQBF-uAfQyiZT',
                    ),
                    const HomeSearchBar(),
                    const SizedBox(height: 24),
                    if (data.promotions.isNotEmpty) ...[
                      PromoBanner(promotion: data.promotions.first),
                      const SizedBox(height: 32),
                    ],
                    if (data.nearbyCourts.isNotEmpty) ...[
                      NearbyCourtsList(courts: data.nearbyCourts),
                      const SizedBox(height: 32),
                    ],
                    if (data.featuredCourts.isNotEmpty) ...[
                      FeaturedCourtsList(courts: data.featuredCourts),
                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
