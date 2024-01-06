import 'package:flutter/material.dart';
import '../models/sudoku.dart';

class SudokuWidget extends StatefulWidget {
  const SudokuWidget({
    super.key,
    required this.sudoku,
    this.onSelected,
  });

  final void Function()? onSelected;
  final Sudoku sudoku;

  @override
  State<SudokuWidget> createState() => _SudokuWidgetState();
}

class _SudokuWidgetState extends State<SudokuWidget> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late Color unselectedColor = Color.alphaBlend(
    _colorScheme.primary.withOpacity(0.08),
    _colorScheme.surface,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected,
      child: Card(
        elevation: 0,
        color: unselectedColor,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SudokuHeadline(
              sudoku: widget.sudoku,
            ),
            SudokuContent(
              sudoku: widget.sudoku,
            ),
          ],
        ),
      ),
    );
  }
}

class SudokuContent extends StatefulWidget {
  const SudokuContent({
    super.key,
    required this.sudoku,
  });

  final Sudoku sudoku;

  @override
  State<SudokuContent> createState() => _SudokuContentState();
}

class _SudokuContentState extends State<SudokuContent> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  Widget get contentSpacer => const SizedBox(height: 2,);

  String get lastActiveLabel {
    final DateTime now = DateTime.now();
    if (widget.sudoku.lastViewed.isAfter(now)) throw ArgumentError();
    final Duration elapsedTime = widget.sudoku.lastViewed.difference(now).abs();

    if (elapsedTime.inSeconds < 60) return '${elapsedTime.inSeconds}s';
    if (elapsedTime.inMinutes < 60) return '${elapsedTime.inMinutes}m';
    if (elapsedTime.inHours < 60) return '${elapsedTime.inHours}h';
    if (elapsedTime.inDays < 365) return '${elapsedTime.inDays}d';
    throw UnimplementedError();
  }

  TextStyle? get contentTextStyle {
    return _textTheme.bodyMedium
        ?.copyWith(color: _colorScheme.onSurfaceVariant);
  }

  Widget getStatusIcon(){
    var icon = widget.sudoku.isComplete ? const Icon(Icons.access_time_rounded) : const Icon(Icons.check_circle_rounded);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: icon,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.sudoku.isScanned ? "Scanned" : "Generated",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: _textTheme.labelMedium
                            ?.copyWith(color: _colorScheme.onSurface),
                      ),
                      Text(
                        lastActiveLabel,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: _textTheme.labelMedium
                            ?.copyWith(color: _colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (constraints.maxWidth - 200 > 0) ...[
                  getStatusIcon()
                ]
              ],
            );
          }),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  "last viewed: ${widget.sudoku.lastViewed}",
                  style: const TextStyle(fontSize: 18)
                      .copyWith(color: _colorScheme.onSurface),
                ),
              contentSpacer,
              Text(
                "Added on: ${widget.sudoku.createdAt}",
                maxLines:  2,
                overflow: TextOverflow.ellipsis,
                style: contentTextStyle,
              ),
            ],
          ),
          // const SizedBox(width: 12),
          // widget.sudoku.attachments.isNotEmpty
          //     ? Container(
          //         height: 96,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8.0),
          //           image: DecorationImage(
          //             fit: BoxFit.cover,
          //             image: AssetImage(widget.sudoku.attachments.first.url),
          //           ),
          //         ),
          //       )
          //     : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class SudokuHeadline extends StatefulWidget {
  const SudokuHeadline({
    super.key,
    required this.sudoku,
  });

  final Sudoku sudoku;

  @override
  State<SudokuHeadline> createState() => _SudokuHeadlineState();
}

class _SudokuHeadlineState extends State<SudokuHeadline> {
  late final TextTheme _textTheme = Theme.of(context).textTheme;
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 84,
        color: Color.alphaBlend(
          _colorScheme.primary.withOpacity(0.05),
          _colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completed 10%",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    // Text(
                    //   '${widget.sudoku.replies.toString()} Messages',
                    //   maxLines: 1,
                    //   overflow: TextOverflow.fade,
                    //   style: _textTheme.labelMedium
                    //       ?.copyWith(fontWeight: FontWeight.w500),
                    // ),
                  ],
                ),
              ),
              // Display a "condensed" version if the widget in the row are
              // expected to overflow.
              if (constraints.maxWidth - 200 > 0) ...[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: _colorScheme.surface,
                    child: const Icon(Icons.delete_outline),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8.0)),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: FloatingActionButton(
                    onPressed: () {},
                    elevation: 0,
                    backgroundColor: _colorScheme.surface,
                    child: const Icon(Icons.more_vert),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
    });
  }
}