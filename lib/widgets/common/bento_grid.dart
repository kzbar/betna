import 'package:flutter/material.dart';

class BentoGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;

  const BentoGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 4,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Determine column count based on width
        int columns = crossAxisCount;
        if (width < 600) {
          columns = 1;
        } else if (width < 900) {
          columns = 2;
        } else if (width < 1200) {
          columns = 3;
        }

        if (columns == 1) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: (context, index) => SizedBox(height: spacing),
            itemBuilder: (context, index) => children[index],
          );
        }

        // For desktop/tablet, we use a simple grid for now to maintain stability,
        // but we vary the aspect ratio or use a CustomScrollView for more complex layouts.
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 0.85, // Adjust for LuxuryCard
          ),
          itemCount: children.length,
          itemBuilder: (context, index) {
            return children[index];
          },
        );
      },
    );
  }
}
