import 'package:flutter/foundation.dart';
import 'package:mindful/core/enums/application_category.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';

/// Represents the categorized usage statistics for a given period.
///
/// This model groups app usage data based on application category.
/// It provides separate values for screen time and data usage for each category.
@immutable
class CategoricalUsageModel {
  /// Total screen time (in milliseconds) spent on entertainment apps this week.
  final int entertainmentScreenTime;

  /// Total data usage (bytes) from entertainment apps this week (combined Wi-Fi and mobile data).
  final int entertainmentDataUsage;

  /// Total screen time (in milliseconds) spent on productivity apps this week.
  final int productivityScreenTime;

  /// Total data usage (bytes) from productivity apps this week (combined Wi-Fi and mobile data).
  final int productivityDataUsage;

  /// Total screen time (in milliseconds) spent on social apps this week.
  final int socialScreenTime;

  /// Total data usage (bytes) from social apps this week (combined Wi-Fi and mobile data).
  final int socialDataUsage;

  /// Total screen time (in milliseconds) spent on game apps this week.
  final int gameScreenTime;

  /// Total data usage (bytes) from game apps this week (combined Wi-Fi and mobile data).
  final int gameDataUsage;

  /// Total screen time (in milliseconds) spent on apps in other categories this week.
  final int otherScreenTime;

  /// Total data usage (bytes) from apps in other categories this week (combined Wi-Fi and mobile data).
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

  /// Creates a `CategoricalUsageModel` instance by processing a list of Android apps.
  ///
  /// This factory constructor iterates through the provided list of apps and accumulates
  /// screen time and data usage for each app category. The `todayOfWeek` value is used to
  /// access the appropriate data from the `screenTimeThisWeek` and `wifiUsageThisWeek` lists
  /// within each `AndroidApp` object (assuming these represent usage data for the current week).
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
