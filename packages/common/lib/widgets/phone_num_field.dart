import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';

class PhoneNumberField extends ConsumerWidget with SignInValidator {
  PhoneNumberField(
      {FocusNode? focusNode,
      required this.phoneNoController,
      this.onChanged,
      this.onTap,
      super.key,
      this.labelText,
      this.hintText = 'Enter your phone number',
      this.readOnly = false,
      this.border})
      : focusNode = focusNode ?? FocusNode();

  final String? labelText;
  final String? hintText;
  final OutlineInputBorder? border;
  final FocusNode focusNode;
  final TextEditingController phoneNoController;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;

  void _onTap() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var outlineInputBorder = border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(color: appColors.cS(context).surfaceTint, width: 2),
        );

    return TextFormField(
      controller: phoneNoController,
      focusNode: focusNode,
      readOnly: readOnly,

      onTap: () {
        if (onTap != null) {
          onTap!();
        }
        _onTap();
        focusNode.requestFocus(); // Ensures focus
      },
      keyboardType: TextInputType.phone,

      style: TextStyles.h8Bold(context),
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+91',
              style: TextStyles.h7Bold(context),
            ),
          ],
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: readOnly,
        fillColor: appColors.ms.readOnly(context),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        //debugPrint('Pressed forward arrow!');
      },

      onChanged: onChanged,
      validator: phoneNumberErrorText,
      onEditingComplete: () {
        //debugPrint('onEditingComplete');

        if (onChanged != null) {
          onChanged!('');
        }
        focusNode.unfocus();
      },
      // 🔽 DOWN ARROW CLOSE KEYBOARD (outside tap or hide key action)
      onTapOutside: (_) {
        //debugPrint('onTapOutside');

        focusNode.unfocus(); // Keyboard down arrow
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
    );
  }
}


// var _ageController = TextEditingController();
// var _heightController = TextEditingController();
// var _weightController = TextEditingController();
// final FocusNode _ageFocus = FocusNode();  
// final FocusNode _heightFocus = FocusNode();  
// final FocusNode _weightFocus = FocusNode();
// var _mainPartView = Container(
//   width: 380.0,
//   height: 240.0,
//   color: Colors.grey,
//   child: Column(
//     children: <Widget>[
//       TextFormField(
//         controller: _ageController,
//         keyboardType: TextInputType.number,
//         textInputAction: TextInputAction.next,
//         focusNode: _ageFocus,
//         onFieldSubmitted: (term){
//           _fieldFocusChange(context, _ageFocus, _heightFocus);
//         },
//         decoration: InputDecoration(
//           labelText: 'Age',
//           hintText: 'Age',
//           icon: Icon(Icons.person_outline),
//           fillColor: Colors.white,
//         ),
//       ),
//       TextFormField(
//         controller: _heightController,
//         keyboardType: TextInputType.number,
//         textInputAction: TextInputAction.next,
//         focusNode: _heightFocus,
//         onFieldSubmitted: (term) {
//           _fieldFocusChange(context, _heightFocus, _weightFocus);
//         },
//         decoration: InputDecoration(
//             labelText: _heightMessage,
//             hintText: _heightMessage,
//             icon: Icon(Icons.assessment),
//             fillColor: Colors.white,
//         ),
//       ),
//       TextFormField(
//         controller: _weightController,
//         keyboardType: TextInputType.number,
//         textInputAction: TextInputAction.done,
//         focusNode: _weightFocus,
//         onFieldSubmitted: (value){
//           _weightFocus.unfocus();
//           _calculator();
//         },
//         decoration: InputDecoration(
//             labelText: _weightMessage,
//             hintText: _weightMessage,
//             icon: Icon(Icons.menu),
//             fillColor: Colors.white
//         ),
//       ),
//       Padding(padding: EdgeInsets.all(4.5)),
//       Center(
//         child: RaisedButton(
//           onPressed: _calculator,
//           color: Colors.pinkAccent,
//           child: Text(
//             'Calculate',
//             style: TextStyle(fontSize: 16.9),
//           ),
//           textColor: Colors.white70,
//         ),
//       )
//     ],
//   ),
// );
// _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);  
// }