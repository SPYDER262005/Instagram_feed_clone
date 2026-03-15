import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'pinch_zoom_image.dart';

class PostCarousel extends StatefulWidget {
  final List<String> images;

  const PostCarousel({super.key, required this.images});

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        /// IMAGE SWIPE
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return PinchZoomImage(
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.cover,
                  memCacheWidth: 800, // Optimize memory and speed
                  filterQuality: FilterQuality.medium,
                  fadeOutDuration: const Duration(milliseconds: 200),
                  fadeInDuration: const Duration(milliseconds: 200),
                  placeholder: (context, url) => Container(color: Colors.grey[50]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
        ),

        /// DOT INDICATOR
        if (widget.images.length > 1)
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: controller,
              count: widget.images.length,
              effect: const WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.white,
                dotColor: Colors.white54,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
