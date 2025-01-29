import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';
import 'package:vsc_acc/ui/views/home/home_viewmodel.dart';

class ImageCarousel extends StackedView<HomeViewModel> {
  ImageCarousel({Key? key}) : super(key: key);

  final List<String> image = [
    'assets/images/offer4.jpg',
    'assets/images/offer3.jpg',
    'assets/images/offer2.png',
    'assets/images/offer1.jpg',
  ];

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        CarouselSlider(
          items: image.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    // Handle image tap if needed
                  },
                  child: Container(
                    width: screenWidth,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: appwhite1,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error), // Handle asset errors
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            padEnds: false,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              viewModel.currentIndexs(index); // Update the current index
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: image.asMap().entries.map((entry) {
            int index = entry.key;
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    viewModel.currentIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
