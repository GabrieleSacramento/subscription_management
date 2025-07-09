import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class DropdownWidget extends StatefulWidget {
  final bool isPaymentMethod;
  final List<String> options;
  const DropdownWidget({
    super.key,
    required this.options,
    this.isPaymentMethod = false,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  final strings = SubscriptionsManagementStrings();

  // Lista de opções de frequência

  // Valor selecionado no dropdown
  String? _selectedFrequency;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(37, 41, 84, 0.15),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Text(
                widget.isPaymentMethod
                    ? "${strings.paymentMethod}:"
                    : "${strings.renewAt}:",
                style: TextStyle(fontSize: 14.h, color: Colors.grey[600]),
              ),

              const SizedBox(width: 8),

              if (_selectedFrequency != null)
                Expanded(
                  child: Text(
                    ": $_selectedFrequency",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: const Color.fromRGBO(111, 86, 221, 1),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          value: null,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color.fromRGBO(111, 86, 221, 1),
          ),
          elevation: 16,
          style: TextStyle(
            color: const Color.fromRGBO(37, 41, 84, 1),
            fontSize: 14.h,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedFrequency = newValue;
            });
          },
          items:
              widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }
}
