import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/ingredient.dart';

/// Original alchemy ingredient artwork — replaces recycled playing-card SVGs.
class IngredientVisual extends StatelessWidget {
  final Ingredient ingredient;
  final double size;

  const IngredientVisual({
    super.key,
    required this.ingredient,
    this.size = 64,
  });

  const IngredientVisual.unknown({
    super.key,
    this.size = 64,
  }) : ingredient = _unknown;

  static const Ingredient _unknown = Ingredient(
    id: 'unknown',
    name: 'Unknown',
    type: IngredientType.mineral,
    element: IngredientElement.earth,
    rarity: IngredientRarity.common,
    purity: 0,
    power: 0,
    stability: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: IngredientVisualPainter(ingredient: ingredient),
      ),
    );
  }
}

class IngredientVisualPainter extends CustomPainter {
  final Ingredient ingredient;

  IngredientVisualPainter({required this.ingredient});

  int get _variant => ingredient.id.hashCode.abs() % 5;

  @override
  void paint(Canvas canvas, Size size) {
    if (ingredient.id == 'unknown') {
      _paintUnknown(canvas, size);
      return;
    }

    final center = Offset(size.width / 2, size.height / 2);
    final base = _elementTint(ingredient.element, ingredient.typeColor);
    final highlight = Color.lerp(base, Colors.white, 0.5)!;

    if (ingredient.rarity.index >= IngredientRarity.rare.index) {
      canvas.drawCircle(
        center,
        size.shortestSide * 0.42,
        Paint()
          ..color = ingredient.rarityColor.withValues(alpha: 0.28)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }

    switch (ingredient.type) {
      case IngredientType.mineral:
        _paintMineral(canvas, size, center, base, highlight);
      case IngredientType.plant:
        _paintPlant(canvas, size, center, base, highlight);
      case IngredientType.liquid:
        _paintLiquid(canvas, size, center, base, highlight);
      case IngredientType.creature:
        _paintCreature(canvas, size, center, base, highlight);
    }
  }

  void _paintMineral(Canvas canvas, Size size, Offset c, Color base, Color hi) {
    final r = size.shortestSide * 0.32;
    final points = List.generate(6 + _variant, (i) {
      final angle = -math.pi / 2 + (2 * math.pi * i / (6 + _variant));
      final wobble = 1.0 + (_variant % 3) * 0.06;
      return c + Offset(math.cos(angle) * r * wobble, math.sin(angle) * r * wobble);
    });
    final path = Path()..addPolygon(points, true);
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          colors: [hi, base, base.withValues(alpha: 0.8)],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  void _paintPlant(Canvas canvas, Size size, Offset c, Color base, Color hi) {
    final leaf = Path()
      ..moveTo(c.dx, c.dy - size.height * 0.34)
      ..quadraticBezierTo(
        c.dx + size.width * 0.28,
        c.dy,
        c.dx,
        c.dy + size.height * 0.28,
      )
      ..quadraticBezierTo(
        c.dx - size.width * 0.28,
        c.dy,
        c.dx,
        c.dy - size.height * 0.34,
      );
    canvas.drawPath(
      leaf,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [hi, base],
        ).createShader(Rect.fromCenter(center: c, width: size.width, height: size.height)),
    );
    canvas.drawLine(
      c + Offset(0, -size.height * 0.1),
      c + Offset(0, size.height * 0.22),
      Paint()
        ..color = base.withValues(alpha: 0.8)
        ..strokeWidth = 2,
    );
  }

  void _paintLiquid(Canvas canvas, Size size, Offset c, Color base, Color hi) {
    final flask = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: c,
        width: size.width * 0.42,
        height: size.height * 0.62,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(
      flask,
      Paint()..color = Colors.white.withValues(alpha: 0.15),
    );
    final fluidTop = c.dy + size.height * 0.02;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          c.dx - size.width * 0.16,
          fluidTop,
          c.dx + size.width * 0.16,
          c.dy + size.height * 0.24,
        ),
        const Radius.circular(6),
      ),
      Paint()
        ..shader = LinearGradient(
          colors: [hi, base],
        ).createShader(Rect.fromCenter(center: c, width: size.width, height: size.height)),
    );
    canvas.drawCircle(
      c + Offset(size.width * 0.08, -size.height * 0.18),
      size.width * 0.05,
      Paint()..color = hi.withValues(alpha: 0.8),
    );
  }

  void _paintCreature(Canvas canvas, Size size, Offset c, Color base, Color hi) {
    canvas.drawOval(
      Rect.fromCenter(center: c, width: size.width * 0.52, height: size.height * 0.38),
      Paint()
        ..shader = RadialGradient(
          colors: [hi, base, base.withValues(alpha: 0.7)],
        ).createShader(Rect.fromCircle(center: c, radius: size.shortestSide * 0.3)),
    );
    for (var i = 0; i < 3 + _variant % 2; i++) {
      final angle = -math.pi / 2 + i * 1.2;
      final tip = c +
          Offset(
            math.cos(angle) * size.width * 0.34,
            math.sin(angle) * size.height * 0.22,
          );
      canvas.drawLine(
        c,
        tip,
        Paint()
          ..color = hi.withValues(alpha: 0.85)
          ..strokeWidth = 2,
      );
    }
  }

  void _paintUnknown(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
      c,
      size.shortestSide * 0.28,
      Paint()..color = Colors.grey.withValues(alpha: 0.25),
    );
  }

  Color _elementTint(IngredientElement element, Color fallback) {
    final tint = switch (element) {
      IngredientElement.earth => const Color(0xFF8D6E63),
      IngredientElement.fire => const Color(0xFFFF7043),
      IngredientElement.water => const Color(0xFF42A5F5),
      IngredientElement.air => const Color(0xFF80CBC4),
      IngredientElement.light => const Color(0xFFFFF176),
      IngredientElement.dark => const Color(0xFF5E35B1),
    };
    return Color.lerp(tint, fallback, 0.45)!;
  }

  @override
  bool shouldRepaint(covariant IngredientVisualPainter oldDelegate) {
    return oldDelegate.ingredient.id != ingredient.id;
  }
}
