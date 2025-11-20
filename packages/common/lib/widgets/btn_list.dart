import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BtnList<T> extends HookConsumerWidget {
  const BtnList({
    super.key,
    required this.data,
    this.initItem,
    required this.onSelect,
    required this.builder,
  });

  final List<T> data;
  final T? initItem;
  final void Function(T item) onSelect;
  final Widget Function(BuildContext context, T item, bool isSelected) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🛡️ Handle empty list safely
    if (data.isEmpty) {
      // return Center(child: Text('No items'));
      return const SizedBox.shrink();
    }

    final initialItem = data.firstWhere(
      (item) => item == initItem,
      orElse: () => data.first,
    );

    final selectedItem = useState<T>(initialItem);

    useEffect(() {
      if (initialItem != selectedItem.value) {
        selectedItem.value = initialItem;
      }
      return null;
    }, [initialItem]);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final isSelected = selectedItem.value == item;

        return InkWell(
          onTap: () {
            selectedItem.value = item;
            onSelect(item);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6).copyWith(right: 6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(
                color: appColors
                    .cS(context)
                    .primary
                    .withValues(alpha: isSelected ? 1 : 0.5),
                width: isSelected ? 2 : 1.5,
              ),
            ),
            child: builder(context, item, isSelected),
          ),
        );
      },
    );
  }
}
