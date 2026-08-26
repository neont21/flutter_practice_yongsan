import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Icon _labelIcon;
  final Text _labelText;
  final Widget _info;
  final Color _bgColor;
  final Function()? _routeOnTap;

  const DashboardCard({
    super.key,
    required this._labelIcon,
    required this._labelText,
    required this._info,
    this._bgColor = Colors.white,
    this._routeOnTap,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _routeOnTap,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme.outlineVariant),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              _bgColor,
            ]
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_labelIcon, SizedBox(width: 4), _labelText],
              ),
            ),
            Expanded(child: _info),
          ],
        ),
      ),
    );
  }
}
