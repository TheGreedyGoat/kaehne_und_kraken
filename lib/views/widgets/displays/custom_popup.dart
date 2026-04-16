import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {
  final Widget child;
  final Widget popupContent;
  const CustomPopup({
    super.key,
    required this.popupContent,
    required this.child,
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => dialog(widget.child),
        );
      },
      child: widget.child,
    );
  }

  Dialog dialog(Widget child) {
    return Dialog(
      semanticsRole: SemanticsRole.tooltip,
      shape: Border.all(),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/parchment_bg_dark.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.popupContent,
          ),
        ),
      ),
    );
  }
}
// class CustomPopup extends StatefulWidget {
//   final Widget child;
//   final Widget popupContent;
//   const CustomPopup({
//     super.key,
//     required this.popupContent,
//     required this.child,
//   });

//   @override
//   State<CustomPopup> createState() => _CustomPopupState();
// }

// class _CustomPopupState extends State<CustomPopup> {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//   bool _isPopupVisible = false;

//   void _showPopup() {
//     _overlayEntry = OverlayEntry(
//       builder: (context) => GestureDetector(
//         onTap: _hidePopup, // Dismiss on tap outside
//         behavior: HitTestBehavior.translucent,
//         child: Stack(
//           children: [
//             CompositedTransformFollower(
//               link: _layerLink,
//               showWhenUnlinked: false,
//               offset: const Offset(
//                 0,
//                 0,
//               ), // Adjust offset as needed, e.g., Offset(0, widget.child height)
//               child: Material(
//                 elevation: 4,
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth:
//                         MediaQuery.of(context).size.width *
//                         0.8, // Prevent unbounded width
//                     maxHeight:
//                         MediaQuery.of(context).size.height *
//                         0.6, // Prevent unbounded height
//                   ),
//                   child: IntrinsicHeight(
//                     child: IntrinsicWidth(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(
//                               'assets/images/parchment_bg_dark.png',
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         child: widget.popupContent,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     Overlay.of(context).insert(_overlayEntry!);
//     setState(() => _isPopupVisible = true);
//   }

//   void _hidePopup() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     setState(() {
//       _isPopupVisible = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _isPopupVisible ? _hidePopup : _showPopup,
//         child: widget.child,
//       ),
//     );
//   }
// }
