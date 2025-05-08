import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_num.dart';

/// Resolves [ItemPosition] from the given [index] and [length] of the item in the list
ItemPosition getItemPositionInList(int index, int length) => length <= 1
    ? ItemPosition.none
    : index == 0
        ? ItemPosition.top
        : index == (length - 1)
            ? ItemPosition.bottom
            : ItemPosition.mid;

/// Creates [BorderRadius] from the given [ItemPosition] for the group item
BorderRadius getBorderRadiusFromPosition(ItemPosition position) =>
    switch (position) {
      /// Nothing
      ItemPosition.fit => BorderRadius.circular(0),

      /// Default all sides
      ItemPosition.none => BorderRadius.circular(24),

      /// Top
      ItemPosition.topLeft =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          topLeft: const Radius.circular(24),
        ),
      ItemPosition.top => const BorderRadius.vertical(
          top: Radius.circular(24),
          bottom: Radius.circular(6),
        ),
      ItemPosition.topRight =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          topRight: const Radius.circular(24),
        ),

      // Mid
      ItemPosition.left => const BorderRadius.horizontal(
          right: Radius.circular(6),
          left: Radius.circular(24),
        ),
      ItemPosition.mid => BorderRadius.circular(6),
      ItemPosition.right => const BorderRadius.horizontal(
          left: Radius.circular(6),
          right: Radius.circular(24),
        ),

      // Bottom
      ItemPosition.bottomLeft =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          bottomLeft: const Radius.circular(24),
        ),
      ItemPosition.bottom => const BorderRadius.vertical(
          top: Radius.circular(6),
          bottom: Radius.circular(24),
        ),
      ItemPosition.bottomRight =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          bottomRight: const Radius.circular(24),
        ),
    };

/// Resolves [IconData] from the given [hourOfDay] of time.
IconData getIconFromHourOfDay(int hourOfDay) => hourOfDay.isBetween(5, 12)
    ? FluentIcons.weather_sunny_high_20_filled // morning (5-12) am
    : hourOfDay.isBetween(12, 16)
        ? FluentIcons.weather_sunny_20_filled // noon (12-4) pm
        : hourOfDay.isBetween(16, 21)
            ? FluentIcons.weather_moon_20_filled // evening (4-9) pm
            : FluentIcons.sleep_20_filled; // night

/// Resolves [Color] from the given [hourOfDay] of time.
Color? getColorFromHourOfDay(BuildContext context, int hourOfDay) => Color.lerp(
      Theme.of(context).colorScheme.error,
      Theme.of(context).colorScheme.primary,
      max(hourOfDay, 1) / 24,
    );
