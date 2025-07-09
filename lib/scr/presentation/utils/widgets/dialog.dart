import 'package:moger_web/scr/configs/app/export.dart';

class EDialog extends StatelessWidget {
  const EDialog({super.key, required this.child, required this.width});
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final _width = width > 700 ? 400.0 : width - 60;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding:  const EdgeInsets.all(9.0),
        child: Container(
            width: _width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: child),
      ),
    );
  }
}
