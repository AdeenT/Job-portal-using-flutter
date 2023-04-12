import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/spacing/spacing.dart';
import 'package:flutter_application_1/widgets/text/text.dart';

class JDataText extends StatelessWidget {
  const JDataText({
    Key? key,
    required this.rows,
    this.dataSpace = 20,
    this.lineSpace = 10,
    this.fontSize,
    this.labelFontWeight,
    this.valueFontWeight,
    this.valueColors,
    this.valueWidth = 400,
    this.valueSuffix,
    this.color,
    this.enableDoubleLine = false,
  }) : super(key: key);

  final List<JDataTextRow> rows;
  final double dataSpace;
  final double lineSpace;
  final double? fontSize;
  final FontWeight? labelFontWeight;
  final FontWeight? valueFontWeight;
  final Map<int, Color>? valueColors;
  final Map<int, Widget>? valueSuffix;
  final double valueWidth;
  final Color? color;
  final bool enableDoubleLine;

  @override
  Widget build(BuildContext context) {
    return enableDoubleLine ? _buildDoubleLine() : _buildSingleLine();
  }

  Widget _buildSingleLine() {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      // border: TableBorder.all(color: Colors.black),
      children: List.generate(rows.where((element) => element.visible).length,
          (index) {
        JDataTextRow row =
            rows.where((element) => element.visible).toList()[index];
        return TableRow(
          children: [
            // label text
            _buildLabelText(row),
            Center(
              child: Column(
                children: [
                  JText(
                    text: ':',
                    fontSize: fontSize,
                    fontWeight: labelFontWeight,
                    color: color,
                  ),
                  JSpace.vertical(lineSpace)
                ],
              ),
            ),
            // value text

            if (row.suffix != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: _buildValueText(row)),
                  JSpace.horizontal(20),
                  SizedBox(
                    child: row.suffix,
                  )
                ],
              )
            else
              _buildValueText(row),
          ],
        );
      }),
    );
  }

  Widget _buildDoubleLine() {
    var visibleList = rows.where((element) => element.visible).toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(visibleList.length, (index) {
        JDataTextRow row = visibleList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLabelText(row),
              if (row.suffix != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: _buildValueText(row)),
                    JSpace.horizontal(20),
                    SizedBox(
                      child: row.suffix,
                    )
                  ],
                )
              else
                _buildValueText(row),
            ],
          ),
        );
      }),
    );
  }

  JText _buildLabelText(JDataTextRow row) {
    return JText(
      text: "${row.label} ",
      fontSize: fontSize,
      fontWeight: labelFontWeight,
      color: color,
    );
  }

  JText _buildValueText(JDataTextRow row) {
    return JText(
      text: row.value,
      fontSize: fontSize,
      fontWeight: valueFontWeight,
      color: row.color ?? color,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
    );
  }
}

class JDataTextRow {
  final String label;
  final String value;
  final Color? color;
  final Widget? suffix;
  final bool visible;

  JDataTextRow({
    required this.label,
    required this.value,
    this.visible = true,
    this.color,
    this.suffix,
  });
}
