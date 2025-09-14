import 'package:cipher_decoder/utils/import_export.dart';

class _CyberpunkMethodCard extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CyberpunkMethodCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CyberpunkMethodCard> createState() => _CyberpunkMethodCardState();
}

class _CyberpunkMethodCardState extends State<_CyberpunkMethodCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            onTapDown: (_) {
              // setState(() => _isHovered = true);
              _hoverController.forward();
            },
            onTapUp: (_) {
              // setState(() => _isHovered = false);
              _hoverController.reverse();
            },
            onTapCancel: () {
              // setState(() => _isHovered = false);
              _hoverController.reverse();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.isSelected
                    ? LinearGradient(
                        colors: [
                          const Color(0xFF00FF41).withValues(alpha: 0.3),
                          const Color(0xFF00FFFF).withValues(alpha: 0.2),
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          const Color(0xFF00FFFF)
                              .withValues(alpha: _isHovered ? 0.2 : 0.1),
                          const Color(0xFF9D00FF)
                              .withValues(alpha: _isHovered ? 0.15 : 0.1),
                        ],
                      ),
                border: Border.all(
                  color: widget.isSelected
                      ? const Color(0xFF00FF41)
                      : (_isHovered
                          ? const Color(0xFF00FFFF)
                          : const Color(0xFF00FFFF).withValues(alpha: 0.5)),
                  width: widget.isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: widget.isSelected || _isHovered
                    ? [
                        BoxShadow(
                          color: widget.isSelected
                              ? const Color(0xFF00FF41).withValues(alpha: 0.4)
                              : const Color(0xFF00FFFF).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isSelected)
                      const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF00FF41),
                        size: 16,
                      ),
                    if (widget.isSelected) const SizedBox(height: 4),
                    Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: widget.isSelected
                            ? const Color(0xFF00FF41)
                            : const Color(0xFF00FFFF),
                        fontFamily: 'monospace',
                        letterSpacing: 0.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }
}

class EncodeDecodeOptions extends StatelessWidget {
  EncodeDecodeOptions({
    super.key,
    required this.controller,
    required this.encodeDecodeOptionController,
  }) {
    txt =
        'Select method to ${controller is EncodeController ? 'encode' : 'decode'}';

  }

  final dynamic controller;
  final EncodeDecodeOptionController encodeDecodeOptionController;
  late final String txt;
  final double fieldSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // region Cyberpunk Header with delete button
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00FFFF).withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF00FFFF).withValues(alpha: 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  txt.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00FFFF),
                    fontFamily: 'monospace',
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12.0),

        // region Cyberpunk Method Selector Button
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1500),
          tween: Tween(begin: 0.7, end: 1.0),
          curve: Curves.easeInOut,
          builder: (context, glowValue, child) {
            return GestureDetector(
              onTap: () => _showCyberpunkMethodDialog(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00FF41).withValues(alpha: 0.1),
                      const Color(0xFF00FFFF).withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF00FF41).withValues(alpha: glowValue),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFF00FF41).withValues(alpha: glowValue * 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '> ACTIVE PROTOCOL:',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF00FFFF),
                              fontFamily: 'monospace',
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            encodeDecodeOptionController
                                .selectedMethod.value.title!
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00FF41),
                              fontFamily: 'monospace',
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF00FF41).withValues(alpha: 0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF00FF41).withValues(alpha: 0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF00FF41),
                          size: 20,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
        //endregion

        SizedBox(height: fieldSpacing * 1.5),
      ],
    );
  }

  void _showCyberpunkMethodDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A0A0A),
                Color(0xFF1A0B2E),
                Color(0xFF16213E),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF00FF41),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF41).withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF00FFFF).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '> SELECT CIPHER PROTOCOL',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FFFF),
                          fontFamily: 'monospace',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFF0040),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFFFF0040),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Method Grid
              SizedBox(
                width: double.maxFinite,
                height: 200,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: encodeDecodeMethods.map((method) {
                    EncodeDecodeModel encodeDecodeModel =
                        getMethod(element: method);
                    bool isSelected = encodeDecodeOptionController
                            .selectedMethod.value.title ==
                        encodeDecodeModel.title;
                    return _CyberpunkMethodCard(
                      title: encodeDecodeModel.title!,
                      isSelected: isSelected,
                      onTap: () {
                        encodeDecodeOptionController.updateWidget(
                          methodObj: encodeDecodeModel,
                          controller: controller,
                        );
                        Get.back();
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Footer
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00FF41).withValues(alpha: 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00FF41).withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF00FFFF),
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'SELECT ENCODING ALGORITHM',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF00FFFF),
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.8),
    );
  }
}
