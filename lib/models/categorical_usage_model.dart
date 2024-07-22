import 'package:flutter/foundation.dart';
import 'package:mindful/core/enums/application_category.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';

@immutable
class CategoricalUsageModel {
  final int entertainmentScreenTime;
  final int entertainmentDataUsage;
  final int productivityScreenTime;
  final int productivityDataUsage;
  final int socialScreenTime;
  final int socialDataUsage;
  final int gameScreenTime;
  final int gameDataUsage;
  final int otherScreenTime;
  final int otherDataUsage;

  const CategoricalUsageModel({
    this.entertainmentScreenTime = 0,
    this.entertainmentDataUsage = 0,
    this.productivityScreenTime = 0,
    this.productivityDataUsage = 0,
    this.socialScreenTime = 0,
    this.socialDataUsage = 0,
    this.gameScreenTime = 0,
    this.gameDataUsage = 0,
    this.otherScreenTime = 0,
    this.otherDataUsage = 0,
  });

  factory CategoricalUsageModel.fromApps(List<AndroidApp> apps) {
    int entertainmentScreenTime = 0;
    int entertainmentDataUsage = 0;
    int productivityScreenTime = 0;
    int productivityDataUsage = 0;
    int socialScreenTime = 0;
    int socialDataUsage = 0;
    int gameScreenTime = 0;
    int gameDataUsage = 0;
    int otherScreenTime = 0;
    int otherDataUsage = 0;

    for (var app in apps) {
      switch (app.category) {
        case AppCategory.audio:
        case AppCategory.video:
        case AppCategory.image:
          {
            entertainmentScreenTime += app.screenTimeThisWeek[todayOfWeek];
            entertainmentDataUsage += app.wifiUsageThisWeek[todayOfWeek] +
                app.mobileUsageThisWeek[todayOfWeek];

            break;
          }
        case AppCategory.productivity:
        case AppCategory.news:
          {
            productivityScreenTime += app.screenTimeThisWeek[todayOfWeek];
            productivityDataUsage += app.wifiUsageThisWeek[todayOfWeek] +
                app.mobileUsageThisWeek[todayOfWeek];
            break;
          }
        case AppCategory.social:
          {
            socialScreenTime += app.screenTimeThisWeek[todayOfWeek];
            socialDataUsage += app.wifiUsageThisWeek[todayOfWeek] +
                app.mobileUsageThisWeek[todayOfWeek];
            break;
          }
        case AppCategory.game:
          {
            gameScreenTime += app.screenTimeThisWeek[todayOfWeek];
            gameDataUsage += app.wifiUsageThisWeek[todayOfWeek] +
                app.mobileUsageThisWeek[todayOfWeek];
            break;
          }
        case AppCategory.maps:
        case AppCategory.accessibility:
        case AppCategory.undefined:
          {
            otherScreenTime += app.screenTimeThisWeek[todayOfWeek];
            otherDataUsage += app.wifiUsageThisWeek[todayOfWeek] +
                app.mobileUsageThisWeek[todayOfWeek];
            break;
          }
      }
    }

    return CategoricalUsageModel(
      entertainmentScreenTime: entertainmentScreenTime,
      entertainmentDataUsage: entertainmentDataUsage,
      productivityScreenTime: productivityScreenTime,
      productivityDataUsage: productivityDataUsage,
      socialScreenTime: socialScreenTime,
      socialDataUsage: socialDataUsage,
      gameScreenTime: gameScreenTime,
      gameDataUsage: gameDataUsage,
      otherScreenTime: otherScreenTime,
      otherDataUsage: otherDataUsage,
    );
  }
}
