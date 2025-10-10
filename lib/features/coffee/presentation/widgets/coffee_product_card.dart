import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/coffee_product_model.dart';

/// Widget to display a single coffee product card with modern design
class CoffeeProductCard extends StatelessWidget {
  final CoffeeProductModel coffeeProduct;
  final VoidCallback? onTap;

  const CoffeeProductCard({super.key, required this.coffeeProduct, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        shadowColor: AppTheme.primaryBrown.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.surfaceWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image and Rating Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.primaryLightBrown.withValues(
                          alpha: 0.1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _buildSafeImage(coffeeProduct.imageUrl),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            coffeeProduct.name,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppTheme.textDark,
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),

                          // Origin
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppTheme.textLight,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                coffeeProduct.origin,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppTheme.textMedium),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Roast Level
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLightBrown.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              coffeeProduct.roastLevel,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppTheme.primaryBrown,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: AppTheme.accentAmber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.5', // TODO: Add rating to model
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.textMedium,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                ' (120)', // TODO: Add review count to model
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppTheme.textLight),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _getPriceDisplay(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppTheme.primaryBrown,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          _getPriceUnit(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textLight),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action Buttons Row
                Row(
                  children: [
                    // View Details Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.visibility, size: 18),
                        label: const Text(
                          'View Details',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBrown,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Favorite Button
                    IconButton(
                      onPressed: () {
                        // TODO: Implement favorite functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Favorite feature coming soon!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite_border),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.primaryLightBrown.withValues(
                          alpha: 0.1,
                        ),
                        foregroundColor: AppTheme.primaryBrown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a safe image widget with proper error handling
  Widget _buildSafeImage(String imageUrl) {
    // Handle empty or invalid URLs
    if (imageUrl.isEmpty || !Uri.tryParse(imageUrl)!.isAbsolute) {
      return _buildPlaceholder();
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image loading error for $imageUrl: $error');
        return _buildPlaceholder();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: AppTheme.primaryLightBrown.withValues(alpha: 0.1),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppTheme.primaryBrown,
              ),
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }

  /// Builds a placeholder widget for failed/missing images
  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.primaryLightBrown.withValues(alpha: 0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.coffee, size: 32, color: AppTheme.primaryBrown),
          const SizedBox(height: 4),
          Text(
            'Image\nUnavailable',
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.primaryBrown.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Get the correct price display based on available variants
  String _getPriceDisplay() {
    // Check if there's a 1kg variant
    final kgVariant = coffeeProduct.variants.firstWhere(
      (variant) => variant.size == '1kg',
      orElse: () => CoffeeVariant(size: '', price: 0, stock: 0),
    );

    if (kgVariant.size.isNotEmpty) {
      // Show 1kg price
      return 'AED ${kgVariant.price.toStringAsFixed(0)}';
    }

    // Check if there's a 500g variant
    final halfKgVariant = coffeeProduct.variants.firstWhere(
      (variant) => variant.size == '500g',
      orElse: () => CoffeeVariant(size: '', price: 0, stock: 0),
    );

    if (halfKgVariant.size.isNotEmpty) {
      // Calculate per kg price from 500g price (multiply by 2)
      final perKgPrice = halfKgVariant.price * 2;
      return 'AED ${perKgPrice.toStringAsFixed(0)}';
    }

    // If no variants, assume base price is for 500g and calculate per kg
    final perKgPrice = coffeeProduct.price * 2;
    return 'AED ${perKgPrice.toStringAsFixed(0)}';
  }

  /// Get the correct price unit display
  String _getPriceUnit() {
    // Check if there's a 1kg variant
    final kgVariant = coffeeProduct.variants.firstWhere(
      (variant) => variant.size == '1kg',
      orElse: () => CoffeeVariant(size: '', price: 0, stock: 0),
    );

    if (kgVariant.size.isNotEmpty) {
      return 'per kg';
    }

    // Always show per kg since we're calculating it
    return 'per kg';
  }
}
