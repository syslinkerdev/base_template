import 'package:flutter/material.dart';
import 'package:core/core.dart';

class ItemCard<T> extends StatelessWidget {
  const ItemCard({
    super.key,
    this.width,
    this.labelStyle,
    this.bg,
    this.gradient,
    required this.item,
    this.getImage,
    this.getTextInPlaceOfImage,
    required this.getLabel,
    this.noBorderAndBg,
    this.imgWidth,
    this.imgHeight,
    this.imageErrorBuilder,
    this.borderColor,
    this.borderWidth,
  });

  final T item;
  final double? width;
  final double? imgWidth;
  final double? imgHeight;
  final TextStyle? labelStyle;
  final Color? bg;
  final List<Color>? gradient;
  final bool? noBorderAndBg;

  /// 👇 Extract image URL from item
  final String Function(T)? getImage;

  /// 👇 Extract Image PlaceHolder or not image from item
  final String Function(T)? getTextInPlaceOfImage;

  /// 👇 Extract label from item
  final String Function(T) getLabel;
  final Widget Function(
          BuildContext context, Object error, StackTrace? stackTrace)?
      imageErrorBuilder;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      noBorderAndBg: noBorderAndBg,
      width: width,
      bg: bg,
      borderColor: borderColor,
      borderWidth: borderWidth,
      gradient: gradient == null
          ? null
          : LinearGradient(
              colors: gradient!,
              stops: const [0.01, 0.3],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (getImage.isNull && getTextInPlaceOfImage.isNotNull) ...[
              Center(
                  child: Container(
                      alignment: Alignment.center,
                      height: imgHeight ?? 64,
                      width: imgWidth ?? 64,
                      child: Text(getTextInPlaceOfImage!(item),
                          textAlign: TextAlign.center,
                          style: getTextInPlaceOfImage!(item).length > 2
                              ? TextStyles.h11Bold(context)
                              : TextStyles.h6Bold(context)))),
            ] else ...[
              Center(
                child: SizedBox(
                  height: imgHeight ?? 64,
                  width: imgWidth ?? 64,
                  child: FadeInImageX(
                      imagePath: getImage!(item),
                      imageErrorBuilder: imageErrorBuilder),
                ),
              ),
            ],
            Text(
              getLabel(item).toUpperCase(),
              textAlign: TextAlign.center,
              style: labelStyle ?? TextStyles.h8Bold(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicListController<T> {
  DynamicListController({T? initialValue})
      : selectedItem = ValueNotifier<T?>(initialValue);

  final ValueNotifier<T?> selectedItem;

  T? get value => selectedItem.value;

  void select(T item) => selectedItem.value = item;

  void clear() => selectedItem.value = null;

  void dispose() => selectedItem.dispose();
}

class DynamicList<T> extends StatefulWidget {
  const DynamicList(
      {super.key,
      required this.items,
      required this.onSelect,
      this.initialSelectedItem,
      this.isGridView = false,
      this.gridCrossAxisCount = 3,
      this.gridChildAspectRatio = 1,
      this.scrollDirection = Axis.vertical,
      this.itemBuilder,
      this.padding,
      this.spacing = 10.0,
      this.physics,
      this.controller,
      this.listSeparatorBuilder});

  final List<T> items;
  final T? initialSelectedItem;
  final bool isGridView;
  final int gridCrossAxisCount;
  final double gridChildAspectRatio;
  final Axis scrollDirection;
  final double spacing;
  final EdgeInsets? padding;
  final void Function(T item) onSelect;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      itemBuilder;
  final Widget Function(BuildContext context, int index)? listSeparatorBuilder;
  final ScrollPhysics? physics;
  final DynamicListController<T>? controller;

  @override
  State<DynamicList<T>> createState() => _DynamicListState<T>();
}

class _DynamicListState<T> extends State<DynamicList<T>> {
  late final DynamicListController<T> _internalController;
  late final bool _isUsingInternalController;

  DynamicListController<T> get controller =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _isUsingInternalController = widget.controller == null;

    if (_isUsingInternalController) {
      _internalController =
          DynamicListController<T>(initialValue: widget.initialSelectedItem);
    } else {
      if (widget.initialSelectedItem != null &&
          widget.controller?.value == null) {
        widget.controller!.select(widget.initialSelectedItem!);
      }
    }
  }

  @override
  void didUpdateWidget(covariant DynamicList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedItem != null &&
        controller.value != widget.initialSelectedItem) {
      controller.select(widget.initialSelectedItem!);
    } else {
      // //print('🔄 No change in initialSelectedItem or already selected');
      return;
    }
  }

  @override
  void dispose() {
    if (_isUsingInternalController) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isGridView
        ? _buildGridView(context)
        : _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      scrollDirection: widget.scrollDirection,
      padding: widget.padding,
      itemCount: widget.items.length,
      physics: widget.physics,
      shrinkWrap: true,
      separatorBuilder: (context, index) => widget.listSeparatorBuilder != null
          ? widget.listSeparatorBuilder!(context, index)
          : SizedBox(width: widget.spacing),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ValueListenableBuilder<T?>(
          valueListenable: controller.selectedItem,
          builder: (context, value, _) {
            final isSelected = value == item;

            return InkWell(
              onTap: () {
                controller.select(item);
                widget.onSelect.call(item);
              },
              child: widget.itemBuilder != null
                  ? widget.itemBuilder!(context, item, isSelected)
                  : _defaultItemBuilder(context, item, isSelected),
            );
          },
        );
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      padding: widget.padding,
      shrinkWrap: true,
      physics: widget.physics ?? const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.gridCrossAxisCount,
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.spacing,
        childAspectRatio: widget.gridChildAspectRatio,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ValueListenableBuilder<T?>(
          valueListenable: controller.selectedItem,
          builder: (context, value, _) {
            final isSelected = value == item;
            return InkWell(
              onTap: () {
                controller.select(item);
                widget.onSelect.call(item);
              },
              child: widget.itemBuilder != null
                  ? widget.itemBuilder!(context, item, isSelected)
                  : _defaultItemBuilder(context, item, isSelected),
            );
          },
        );
      },
    );
  }

  Widget _defaultItemBuilder(BuildContext context, T item, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        item.toString(),
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
