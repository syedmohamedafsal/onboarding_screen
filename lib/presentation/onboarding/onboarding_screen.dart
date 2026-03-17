import 'package:flutter/material.dart';
import 'package:onboarding_eid_screen/presentation/widget/star_effect.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "rive": "assets/rive/ramadan-animation.riv",
      "title": "Ramadan Kareem",
      "desc":
          "Ramadan is a sacred month filled with reflection, patience, and compassion. It is a time to purify the heart, strengthen faith, and spread kindness to everyone around us. May this blessed month bring peace, spiritual growth, and countless blessings to your life.",
    },
    {
      "rive": "assets/rive/husband-wife-praying-before-iftar.riv",
      "title": "Moments of Prayer",
      "desc":
          "Ramadan reminds us to slow down and reconnect with what truly matters. Through prayer, gratitude, and devotion, we strengthen our bond with Allah and nurture love within our families. These moments of faith bring serenity and purpose to our hearts.",
    },
    {
      "rive": "assets/rive/men-hugging-flat-eid-al-fitr-animation.riv",
      "title": "Spread Love",
      "desc":
          "Eid is a celebration of unity, forgiveness, and joy. It is the perfect time to embrace one another, forgive the past, and share happiness with family, friends, and the community. Let kindness and compassion guide every interaction during this beautiful celebration.",
    },
    {
      "rive": "assets/rive/flat-eid-al-fitr-animation.riv",
      "title": "Eid Mubarak",
      "desc":
          "May this Eid bring endless joy, prosperity, and blessings into your life. Celebrate the beauty of togetherness, gratitude, and generosity. May your home be filled with laughter, your heart with peace, and your future with hope and happiness.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),

      body: Stack(
        children: [

          /// Background Color
          Container(color: const Color(0xff0f172a)),

          /// PageView Content
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = onboardingData[index];
              bool active = index == currentPage;

              return AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: active ? 1 : 0.92,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: active ? 1 : 0.4,
                  child: Column(
                    children: [

                      /// Rive + Stars Section
                      Expanded(
                        flex: 6,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 600),
                          offset: active ? Offset.zero : const Offset(0, 0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Stack(
                              children: [

                                /// ⭐ Stars behind rive
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: Opacity(
                                      opacity: 0.7,
                                      child: const StarBackground(),
                                    ),
                                  ),
                                ),

                                /// Rive Animation
                                Center(
                                  child: RiveAnimation.asset(
                                    item["rive"]!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// Text Section (NO STARS)
                      Expanded(
                        flex: 4,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 600),
                          offset: active ? Offset.zero : const Offset(0, 0.4),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 10, 28, 90),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),

                                /// Title
                                Text(
                                  item["title"]!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.amiri(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                /// Description
                                Text(
                                  item["desc"]!,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white70,
                                    height: 1.7,
                                  ),
                                ),

                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          /// Bottom Controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Skip
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(3);
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),

                /// Indicators
                Row(
                  children: List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 18 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.white
                            : Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                /// Next Button
                TextButton(
                  onPressed: () {
                    if (currentPage == onboardingData.length - 1) {
                      // Navigate to home
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    currentPage == onboardingData.length - 1 ? "Start" : "Next",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}