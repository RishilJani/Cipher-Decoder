import 'package:cipher_decoder/utils/import_export.dart';

// ignore:must_be_immutable
class EncryptionDecryptionOptions extends StatefulWidget {
  EncryptionDecryptionOptions(
      {super.key,
      required this.controller,
      this.index,
      required this.encryptionDecryptionOptionController}) {
    txt =
        'Select method to ${controller is EncryptionController ? 'encrypt' : 'decrypt'}';
  }

  final dynamic controller;
  int? index;
  EncryptionDecryptionOptionsController encryptionDecryptionOptionController;
  String txt = '';

  @override
  State<EncryptionDecryptionOptions> createState() =>
      _EncryptionDecryptionOptionsState();
}

class _EncryptionDecryptionOptionsState
    extends State<EncryptionDecryptionOptions>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  double fieldSpacing = 20.0;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    int n = widget.encryptionDecryptionOptionController.options.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // region Method Heading With Delete button
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cyberpunkCyan.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(
                    color: cyberpunkCyan.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '> ${n > 1 ? '${widget.index! + 1}. ' : ''}${widget.txt.trim().toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00FFFF),
                    fontFamily: 'monospace',
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
            n > 1
                ? Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFFF0040), width: 1),
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF0040).withValues(alpha: 0.1),
                          const Color(0xFFFF0040).withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        widget.encryptionDecryptionOptionController
                            .removeWidget(
                                index: widget.index,
                                controller: widget.controller);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFFF0040),
                        size: 20,
                      ),
                      tooltip: 'DELETE Method',
                    ),
                  )
                : const SizedBox(height: 0),
          ],
        ),
        // endregion

        const SizedBox(height: 12.0),

        // region Cyberpunk Method Selector Button
        AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return GestureDetector(
              onTap: () => _showCyberpunkMethodDialog(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
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
                    color: const Color(0xFF00FF41)
                        .withValues(alpha: _glowAnimation.value),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FF41)
                          .withValues(alpha: _glowAnimation.value * 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            widget.encryptionDecryptionOptionController
                                .options[widget.index!].title!
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
                  ),
                ),
              ),
            );
          },
        ),
        //endregion

        // region Conditional Key Input Field
        Obx(() {
          EncryptionDecryptionModel obj = widget
              .encryptionDecryptionOptionController.options[widget.index!];
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: obj.requiresKey
                ? Container(
                    key: const ValueKey('conditionalField'),
                    margin: const EdgeInsets.only(top: 16),
                    child: myInputfield(
                      key: const ValueKey("conditionalField"),
                      context: context,
                      textTitle: "Enter Key:",
                      hintText: "Enter Integer Key... ",
                      controller: obj.keyController!,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        widget.encryptionDecryptionOptionController
                            .keyUpdateWidget(
                                index: widget.index,
                                controller: widget.controller);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                      ],
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('emptyConditional')),
          );
        }),
        //endregion

        Obx(
          () => Visibility(
            visible: !widget.encryptionDecryptionOptionController
                .options[widget.index!].requiresKey,
            child: SizedBox(
              height: fieldSpacing * 1.5,
            ),
          ),
        ),

        SizedBox(
          height: 8,
        )
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
                        '> SELECT CRYPTO PROTOCOL',
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
                  children: encryptionDecryptionMethods.map((method) {
                    EncryptionDecryptionModel encryptionDecryptionModel = getMethod(element: method);
                    bool isSelected = widget
                            .encryptionDecryptionOptionController
                            .options[widget.index!]
                            .title ==
                        encryptionDecryptionModel.title;

                    return _CyberpunkMethodCard(
                      title: encryptionDecryptionModel.title!,
                      isSelected: isSelected,
                      onTap: () {
                        widget.encryptionDecryptionOptionController
                            .updateWidget(
                          methodObj: encryptionDecryptionModel,
                          index: widget.index,
                          controller: widget.controller,
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
                      'SELECT ENCRYPTION ALGORITHM',
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

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }
}

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
                              .withValues(alpha: 0.2),
                          const Color(0xFF9D00FF)
                              .withValues(alpha: 0.15),
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
