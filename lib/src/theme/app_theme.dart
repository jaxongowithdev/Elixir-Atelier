import 'package:flutter/material.dart';

class AppTheme {
  // Primary Alchemy Colors - Warm Golden Theme
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color amberGlow = Color(0xFFFFB84D);
  static const Color bronzeDeep = Color(0xFF8B6914);

  // Background Colors - Parchment/Medieval
  static const Color bgDark = Color(0xFF1A1410);
  static const Color bgParchment = Color(0xFF2D2416);
  static const Color bgCard = Color(0xFF3D3020);
  static const Color bgLight = Color(0xFF4A3F2A);

  // Accent Colors
  static const Color mysticalPurple = Color(0xFF9B59B6);
  static const Color alchemyRed = Color(0xFFE74C3C);
  static const Color herbGreen = Color(0xFF27AE60);
  static const Color crystalBlue = Color(0xFF3498DB);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8F5E4);
  static const Color textSecondary = Color(0xFFBFAE8C);
  static const Color textMuted = Color(0xFF8B7C5F);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldPrimary, bronzeDeep],
  );

  static const LinearGradient parchmentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgParchment, bgDark],
  );

  static const LinearGradient cauldronGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
  );

  // Shadows
  static List<BoxShadow> goldShadow = [
    BoxShadow(
      color: goldPrimary.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 12,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];

  // Border Radius
  static const BorderRadius radiusSmall = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMedium = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusLarge = BorderRadius.all(Radius.circular(24));

  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    color: textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static const TextStyle headingMedium = TextStyle(
    color: textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    color: textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyMedium = TextStyle(
    color: textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle caption = TextStyle(
    color: textMuted,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Rarity Colors
  static Color getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'legendary':
        return const Color(0xFFFF6B35);
      case 'epic':
        return const Color(0xFFA855F7);
      case 'rare':
        return const Color(0xFF3B82F6);
      case 'uncommon':
        return const Color(0xFF10B981);
      case 'common':
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  // Element Colors
  static Color getElementColor(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return const Color(0xFFEF4444);
      case 'water':
        return const Color(0xFF3B82F6);
      case 'earth':
        return const Color(0xFF84CC16);
      case 'air':
        return const Color(0xFF8B5CF6);
      case 'light':
        return const Color(0xFFFBBF24);
      case 'dark':
        return const Color(0xFF6B7280);
      default:
        return textMuted;
    }
  }

  // Decorative Border
  static BoxDecoration ornateCard({
    Color? borderColor,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [bgCard, bgParchment],
      ),
      borderRadius: radiusMedium,
      border: Border.all(
        color: borderColor ?? goldPrimary.withOpacity(0.3),
        width: 2,
      ),
      boxShadow: shadows ?? cardShadow,
    );
  }

  // Glass Effect
  static BoxDecoration glassEffect({Color? tint}) {
    return BoxDecoration(
      color: (tint ?? bgCard).withOpacity(0.7),
      borderRadius: radiusMedium,
      border: Border.all(
        color: goldPrimary.withOpacity(0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 0,
        ),
      ],
    );
  }
}
