import '../../core/config.dart';
import 'loading_indicator.dart';

enum ButtonType { normal, outline }

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.child,
    this.loading = false,
    this.type = ButtonType.normal,
    this.borderRadius = 5.0,
    this.borderWidth = 1,
    this.borderColor,
    this.textColor,
    this.color,
    this.elevation = 0,
    this.fontSize = 16,
    this.height = 48,
    this.textHeight = 1.4,
    this.width,
    this.fontWeight = FontWeight.w500,
    this.maxLines,
    this.padding,
    this.size,
    this.maximumSize,
    this.minimumSize,
    this.alignment = Alignment.center,
    this.style,
    this.letterSpacing,
    this.wordSpacing,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String? text;
  final bool loading;
  final int? maxLines;
  final ButtonType type;
  final Widget? child;
  final Color? borderColor, textColor, color;
  final double fontSize, height;
  final double? borderRadius,
      borderWidth,
      elevation,
      width,
      textHeight,
      letterSpacing,
      wordSpacing;
  final FontWeight fontWeight;
  final EdgeInsets? padding;
  final Size? maximumSize, minimumSize, size;
  final Alignment alignment;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final s = size ?? Size(width?.w ?? double.infinity, height.h);
    final label = text?.isEmpty ?? true
        ? const SizedBox()
        : FittedBox(
            child: Text(
              text ?? '',
              style: style ??
                  TextStyle(
                    fontSize: fontSize.sp,
                    color: textColor,
                    fontWeight: fontWeight,
                    height: textHeight,
                    letterSpacing: letterSpacing,
                    wordSpacing: wordSpacing,
                  ),
              maxLines: maxLines,
            ),
          );
    switch (type) {
      case ButtonType.outline:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: elevation,
            backgroundColor: color,
            foregroundColor: textColor ?? colorScheme.primary,
            disabledForegroundColor: colorScheme.onBackground,
            disabledBackgroundColor: const Color(0xffE1E8ED),
            padding: padding,
            minimumSize: minimumSize ?? s,
            maximumSize: maximumSize ?? s,
            side: BorderSide(
              color: borderColor ?? theme.dividerColor,
              width: borderWidth ?? 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
            alignment: alignment,
          ),
          onPressed: loading ? null : onPressed,
          child: loading ? const LoadingIndicator() : child ?? label,
        );
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: elevation,
            disabledForegroundColor: colorScheme.onBackground,
            disabledBackgroundColor: const Color(0xffE1E8ED),
            backgroundColor: color ?? colorScheme.onBackground,
            foregroundColor: textColor ?? Colors.white,
            padding: padding,
            minimumSize: minimumSize ?? s,
            maximumSize: maximumSize ?? s,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
            alignment: alignment,
          ),
          onPressed: loading ? null : onPressed,
          child: loading ? const LoadingIndicator() : child ?? label,
        );
    }
  }
}
