import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:islamic_tools_app/customWidgets/custom_card.dart';
import 'package:islamic_tools_app/customWidgets/custom_snack_bar_text.dart';
import 'package:islamic_tools_app/models/islamic_radio_model.dart';
import 'package:islamic_tools_app/models/radio_channels_list.dart';
import 'package:just_audio/just_audio.dart';
import '../customWidgets/custom_text.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  late AudioPlayer _player;
  int? currentlyPlayingId;
  bool isPlaying = false;
  double volume = 1.0; // NEW: volume tracking

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // Listen to changes in the player's playing state
    _player.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });
  }

  // Function to invoke the playing operation
  Future<void> _play(String url, int id) async {
    // ✅ Capture context early before any await
    final theme = Theme.of(context);

    try {
      if (currentlyPlayingId != id) {
        await _player.setUrl(url);
      }
      await _player.setVolume(volume); // NEW: Apply volume before playing
      await _player.play();
      setState(() {
        currentlyPlayingId = id;
      });
    } catch (e) {
      // ✅ Use the captured theme instead of Theme.of(context)
      CustomSnackBarText(
        snackBarText: "Error playing audio: $e",
        snackBarColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.secondary.withAlpha(204),
      );
    }
  }

// Pause function
  Future<void> _pause() async {
    await _player.pause();
    setState(() {
      // Keep currentlyPlayingId to highlight selected channel
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          textTitle: 'radio_tab.channels'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: isArabic ? 42 : 32,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withAlpha(153),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
          textAlign: TextAlign.center,
        ),
        Expanded(
            child: ListView.builder(
                // Decrease default top padding
                padding: const EdgeInsets.only(top: 12),
                itemCount: islamicRadioList.length,
                itemBuilder: (context, index) {
                  // Get the radio model at the current index
                  final IslamicRadioModel currentRadio =
                      islamicRadioList[index];
                  final bool isPlayingForThisItem =
                      currentlyPlayingId == currentRadio.id && isPlaying;
                  return CustomCard(
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      currentRadio.islamicRadioCountryFlag),
                                  radius: 20,
                                ),
                                CustomText(
                                  textTitle:
                                      currentRadio.islamicRadioCountryName,
                                  fontSize: isArabic ? 16 : 14,
                                  fontFamily: 'kofi',
                                  fontWeight: FontWeight.w900,
                                  shadowColor: Colors.black.withAlpha(153),
                                  blurRadius: 4,
                                  offsetOne: 2,
                                  offsetTwo: 2,
                                  textColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                            const Gap(12),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  CustomText(
                                    textTitle:
                                        currentRadio.islamicRadioListName,
                                    fontSize: isArabic ? 20 : 16,
                                    fontFamily: 'kofi',
                                    fontWeight: FontWeight.w900,
                                    shadowColor: Colors.black.withAlpha(153),
                                    blurRadius: 4,
                                    offsetOne: 2,
                                    offsetTwo: 2,
                                    textColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const Gap(8),
                                  GestureDetector(
                                    onTap: () {
                                      if (isPlaying &&
                                          currentlyPlayingId ==
                                              currentRadio.id) {
                                        _pause();
                                      } else {
                                        _play(
                                            currentRadio.islamicRadioStreamUrl,
                                            currentRadio.id);
                                      }
                                    },
                                    child: Icon(
                                      isPlayingForThisItem
                                          ? Icons.pause_circle
                                          : Icons.play_circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(currentRadio.islamicRadioIcon),
                                radius: 24,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              volume == 0
                                  ? Icons.volume_off
                                  : volume < 0.5
                                      ? Icons.volume_down
                                      : Icons.volume_up,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const Gap(8),
                            Expanded(
                              child: Slider(
                                value: volume,
                                min: 0.0,
                                max: 1.0,
                                divisions: 10,
                                label: (volume * 100).toInt().toString(),
                                activeColor: Theme.of(context).dividerColor,
                                inactiveColor: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(100),
                                onChanged: (double newVolume) {
                                  setState(() {
                                    volume = newVolume;
                                    _player.setVolume(
                                        volume); // 🔊 Apply volume in real time
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    containerWidth: MediaQuery.of(context).size.width * .8,
                    containerHeight: MediaQuery.of(context).size.height * .2,
                    cardColor:
                        Theme.of(context).colorScheme.secondary.withAlpha(204),
                    boxShadowColor:
                        Theme.of(context).colorScheme.onSurface.withAlpha(32),
                    cardElevation: 10, // Add missing required parameters
                    blurRadius: 40,
                    spreadRadius: 0,
                    offsetOne: 5,
                    offSetTwo: 5,
                    horizontalMargin: 24,
                    vertMargin: 16,
                  );
                }))
      ],
    );
  }
}
