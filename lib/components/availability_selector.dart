import 'dart:ffi';

import 'package:flutter/material.dart';

enum Availability { online, offline }

class AvailabilitySelector extends StatefulWidget {
  final ValueChanged<bool> onChanged; // callback to parent
  final bool initialValue;

  const AvailabilitySelector({
    super.key,
    required this.onChanged,
    this.initialValue = true,
  });

  @override
  State<AvailabilitySelector> createState() => _AvailabilitySelectorState();
}

class _AvailabilitySelectorState extends State<AvailabilitySelector> {
  late bool _availability;

  @override
  void initState() {
    super.initState();
    _availability = widget.initialValue;
  }

  void _updateAvailability(bool value) {
    setState(() {
      _availability = value;
    });
    widget.onChanged(value); // notify parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<bool>(
          title: const Text("Online"),
          value: true,
          groupValue: _availability,
          onChanged: (value) => _updateAvailability(value!),
        ),
        RadioListTile<bool>(
          title: const Text("Offline"),
          value: false,
          groupValue: _availability,
          onChanged: (value) => _updateAvailability(value!),
        ),
        const SizedBox(height: 12),
        Text(
          "Selected: ${_availability ? "Online" : "Offline"}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
