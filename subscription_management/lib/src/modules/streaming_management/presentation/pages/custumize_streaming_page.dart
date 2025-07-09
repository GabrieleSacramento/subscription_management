import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/widgets/dropdown_widget.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_button.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_form.dart';
import 'package:subscription_management/src/utils/app_strings.dart';
import 'package:subscription_management/src/utils/formatters.dart';

@RoutePage(name: 'CostumizeStreamingPageRoute')
class CostumizeStreamingPage extends StatefulWidget {
  const CostumizeStreamingPage({super.key});

  @override
  State<CostumizeStreamingPage> createState() => _CostumizeStreamingPageState();
}

class _CostumizeStreamingPageState extends State<CostumizeStreamingPage> {
  final strings = SubscriptionsManagementStrings();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(111, 86, 221, 1),
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(111, 86, 221, 1),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void format(String value) {
    String formattedValue = CurrencyFormatter.formatInput(value);

    if (formattedValue.isNotEmpty) {
      _valueController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color.fromRGBO(111, 86, 221, 1),
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              strings.costumizeYourSubscription,
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color.fromRGBO(111, 86, 221, 1),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    CustomForm(
                      hintText: strings.nome,
                      isPrefixHint: true,
                      controller: _nameController,
                      onChanged: (value) => format(value),
                    ),
                    CustomForm(
                      hintText: strings.value,
                      isPrefixHint: true,
                      controller: _valueController,
                      onChanged: (value) => format(value),
                      keyboardType: TextInputType.number,
                    ),
                    CustomForm(
                      hintText: strings.startsAt,
                      isPrefixHint: true,
                      suffixIcon: const Icon(Icons.calendar_month),
                      controller: _dateController,
                      isDatePicker: true,
                      onTap: () => _selectDate(context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: DropdownWidget(
                        options: [
                          strings.threeDays,
                          strings.sevenDays,
                          strings.fourteenDays,
                          strings.thirtyDays,
                        ],
                      ),
                    ),
                    DropdownWidget(
                      isPaymentMethod: true,
                      options: [
                        strings.debitCard,
                        strings.creditCard,
                        strings.pix,
                        strings.bankSlip,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.h,
                      right: 24.h,
                      bottom: 32.h,
                      top: 32.h,
                    ),
                    child: CustomButton(
                      isLarge: true,
                      textButton: strings.addSubscription,

                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
