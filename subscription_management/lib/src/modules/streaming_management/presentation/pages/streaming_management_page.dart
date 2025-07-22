import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:subscription_management/src/modules/home/domain/enums/payment_method.dart';
import 'package:subscription_management/src/modules/shared/widgets/loading_button.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/cubit/streaming_management_cubit.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/widgets/dropdown_widget.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_button.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_form.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';
import 'package:subscription_management/src/utils/formatters.dart';

@RoutePage(name: 'StreamingManagementPageRoute')
class AddNewStreamingPage extends StatefulWidget {
  final StreamingEntity streaming;
  final bool newStreaming;
  const AddNewStreamingPage({
    super.key,
    required this.newStreaming,
    required this.streaming,
  });

  @override
  State<AddNewStreamingPage> createState() => _AddNewStreamingPageState();
}

class _AddNewStreamingPageState extends State<AddNewStreamingPage> {
  final strings = SubscriptionsManagementStrings();
  final TextEditingController _startsAtController = TextEditingController();
  final TextEditingController _renewalDateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _addStreamingCubit = GetIt.I.get<StreamingManagementCubit>();
  PaymentMethod? _selectedPaymentMethod;
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
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
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
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
              widget.newStreaming == false
                  ? strings.editSubscription
                  : strings.addSubscription,
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
        body: BlocProvider(
          create: (context) => _addStreamingCubit..addStreaming,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      widget.newStreaming == false
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.streaming.streamingName,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: const Color.fromRGBO(
                                      111,
                                      86,
                                      221,
                                      1,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.streaming.streamingValue != null
                                        ? CurrencyFormatter.format(
                                          widget.streaming.streamingValue!,
                                        )
                                        : '',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: const Color.fromRGBO(
                                        111,
                                        86,
                                        221,
                                        1,
                                      ),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.streaming.renewalDate != null
                                        ? DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(widget.streaming.renewalDate!)
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color.fromRGBO(
                                        77,
                                        77,
                                        97,
                                        1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : const SizedBox.shrink(),
                      CustomForm(
                        hintText: strings.name,
                        isPrefixHint: true,
                        controller:
                            widget.streaming.streamingName != ''
                                ? TextEditingController(
                                  text: widget.streaming.streamingName,
                                )
                                : _nameController,
                      ),
                      CustomForm(
                        hintText: strings.value,
                        isPrefixHint: true,
                        controller:
                            widget.streaming.streamingValue != null
                                ? TextEditingController(
                                  text: CurrencyFormatter.format(
                                    widget.streaming.streamingValue!,
                                  ),
                                )
                                : _valueController,
                        onChanged: (value) => format(value),
                        keyboardType: TextInputType.number,
                      ),
                      CustomForm(
                        hintText: strings.startsAt,
                        isPrefixHint: true,
                        suffixIcon: const Icon(Icons.calendar_month),
                        controller: _startsAtController,
                        isDatePicker: true,
                        onTap: () => _selectDate(context, _startsAtController),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomForm(
                          hintText: strings.renewAt,
                          isPrefixHint: true,
                          suffixIcon: const Icon(Icons.calendar_month),
                          controller: _renewalDateController,
                          isDatePicker: true,
                          onTap:
                              () =>
                                  _selectDate(context, _renewalDateController),
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
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod =
                                PaymentMethod.getPaymentMethodFromString(value);
                          });
                        },
                        selectedValue: PaymentMethod.getStringFromPaymentMethod(
                          _selectedPaymentMethod,
                        ),
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
                    BlocConsumer<
                      StreamingManagementCubit,
                      StreamingManagementState
                    >(
                      listener: (context, state) {
                        if (state.isFailure) {
                          showActionSnackBarError(context);
                        }
                        if (state.isSuccess) {
                          context.pushRoute(HomePageRoute());
                        }
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 24.h,
                              right: 24.h,
                              bottom: widget.newStreaming ? 32.h : 16.h,
                              top: 32.h,
                            ),
                            child: const LoadingButton(isLarge: true),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 24.h,
                            right: 24.h,
                            bottom: widget.newStreaming ? 32.h : 16.h,
                            top: 32.h,
                          ),
                          child: CustomButton(
                            isLarge: true,
                            textButton:
                                widget.newStreaming
                                    ? strings.addSubscription
                                    : strings.save,
                            onPressed: () {
                              _addStreamingCubit.addStreaming(
                                StreamingEntity(
                                  streamingName:
                                      widget.streaming.streamingName != ''
                                          ? widget.streaming.streamingName
                                          : _nameController.text,
                                  streamingValue: CurrencyFormatter.parse(
                                    _valueController.text,
                                  ),
                                  startsAt:
                                      _startsAtController.text.isNotEmpty
                                          ? DateFormat(
                                            'dd/MM/yyyy',
                                          ).parse(_startsAtController.text)
                                          : null,
                                  renewalDate:
                                      _renewalDateController.text.isNotEmpty
                                          ? DateFormat(
                                            'dd/MM/yyyy',
                                          ).parse(_renewalDateController.text)
                                          : null,
                                  paymentMethod: _selectedPaymentMethod,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    widget.newStreaming == false
                        ? Padding(
                          padding: EdgeInsets.only(
                            left: 24.h,
                            right: 24.h,
                            bottom: 32.h,
                          ),
                          child: CustomButton(
                            isLarge: true,
                            textButton: strings.cancelSubscription,
                            onPressed: () {},
                            buttonColor: const Color.fromRGBO(221, 86, 86, 1),
                          ),
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showActionSnackBarError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        strings.somethingWentWrong,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromRGBO(111, 86, 221, 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
