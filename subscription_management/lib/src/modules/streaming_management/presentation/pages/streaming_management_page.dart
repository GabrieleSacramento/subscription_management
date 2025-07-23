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
class StreamingManagementPage extends StatefulWidget {
  final StreamingEntity streaming;
  final bool newStreaming;
  const StreamingManagementPage({
    super.key,
    required this.newStreaming,
    required this.streaming,
  });

  @override
  State<StreamingManagementPage> createState() =>
      _StreamingManagementPageState();
}

class _StreamingManagementPageState extends State<StreamingManagementPage> {
  final strings = SubscriptionsManagementStrings();
  final TextEditingController _startsAtController = TextEditingController();
  final TextEditingController _renewalDateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _streamingCubit = GetIt.I.get<StreamingManagementCubit>();
  final ValueNotifier<bool> _isSavingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isCancelingNotifier = ValueNotifier<bool>(false);
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
        selection: TextSelection.collapsed(
          offset: formattedValue.length.clamp(0, formattedValue.length),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.newStreaming) {
      _nameController.text = widget.streaming.streamingName;

      if (widget.streaming.streamingValue != null) {
        _valueController.text = CurrencyFormatter.format(
          widget.streaming.streamingValue!,
        );
      }

      if (widget.streaming.startsAt != null) {
        _startsAtController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(widget.streaming.startsAt!);
      }

      if (widget.streaming.renewalDate != null) {
        _renewalDateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(widget.streaming.renewalDate!);
      }

      _selectedPaymentMethod = widget.streaming.paymentMethod;
    } else {
      _nameController.text = widget.streaming.streamingName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _startsAtController.dispose();
    _renewalDateController.dispose();
    _isSavingNotifier.dispose();
    _isCancelingNotifier.dispose();
    super.dispose();
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
          create: (context) => _streamingCubit,
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
                      if (widget.newStreaming == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.streaming.streamingName,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: const Color.fromRGBO(111, 86, 221, 1),
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
                                    color: const Color.fromRGBO(77, 77, 97, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(widget.streaming.streamingImage!),
                        ),
                      CustomForm(
                        hintText: strings.name,
                        isPrefixHint: true,
                        controller: _nameController,
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
                          _isSavingNotifier.value = false;
                          _isCancelingNotifier.value = false;
                          showActionSnackBarError(context);
                        }
                        if (state.isSuccess) {
                          _isSavingNotifier.value = false;
                          _isCancelingNotifier.value = false;
                          context.pushRoute(HomePageRoute());
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24.h,
                                right: 24.h,
                                bottom: widget.newStreaming ? 32.h : 16.h,
                                top: 32.h,
                              ),
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _isSavingNotifier,
                                builder: (context, isSaving, child) {
                                  return isSaving
                                      ? const LoadingButton(isLarge: true)
                                      : CustomButton(
                                        isLarge: true,
                                        textButton:
                                            widget.newStreaming
                                                ? strings.addSubscription
                                                : strings.save,
                                        onPressed: () {
                                          _isSavingNotifier.value = true;
                                          widget.newStreaming
                                              ? _streamingCubit.addStreaming(
                                                StreamingEntity(
                                                  streamingName:
                                                      _nameController.text,
                                                  streamingValue:
                                                      CurrencyFormatter.parse(
                                                        _valueController.text,
                                                      ),
                                                  startsAt:
                                                      _startsAtController
                                                              .text
                                                              .isNotEmpty
                                                          ? DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parse(
                                                            _startsAtController
                                                                .text,
                                                          )
                                                          : null,
                                                  renewalDate:
                                                      _renewalDateController
                                                              .text
                                                              .isNotEmpty
                                                          ? DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parse(
                                                            _renewalDateController
                                                                .text,
                                                          )
                                                          : null,
                                                  paymentMethod:
                                                      _selectedPaymentMethod,
                                                ),
                                              )
                                              : _streamingCubit.updateStreaming(
                                                StreamingEntity(
                                                  streamingId:
                                                      widget
                                                          .streaming
                                                          .streamingId,
                                                  streamingName:
                                                      _nameController.text,
                                                  streamingValue:
                                                      CurrencyFormatter.parse(
                                                        _valueController.text,
                                                      ),
                                                  startsAt:
                                                      _startsAtController
                                                              .text
                                                              .isNotEmpty
                                                          ? DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parse(
                                                            _startsAtController
                                                                .text,
                                                          )
                                                          : widget
                                                              .streaming
                                                              .startsAt,
                                                  renewalDate:
                                                      _renewalDateController
                                                              .text
                                                              .isNotEmpty
                                                          ? DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parse(
                                                            _renewalDateController
                                                                .text,
                                                          )
                                                          : widget
                                                              .streaming
                                                              .renewalDate,
                                                  paymentMethod:
                                                      _selectedPaymentMethod ??
                                                      widget
                                                          .streaming
                                                          .paymentMethod,
                                                ),
                                              );
                                        },
                                      );
                                },
                              ),
                            ),
                            widget.newStreaming == false
                                ? Padding(
                                  padding: EdgeInsets.only(
                                    left: 24.h,
                                    right: 24.h,
                                    bottom: 32.h,
                                  ),
                                  child: ValueListenableBuilder(
                                    valueListenable: _isCancelingNotifier,
                                    builder: (context, isCanceling, child) {
                                      return isCanceling
                                          ? const LoadingButton(
                                            isLarge: true,
                                            buttonColor: Color.fromRGBO(
                                              221,
                                              86,
                                              86,
                                              1,
                                            ),
                                          )
                                          : CustomButton(
                                            isLarge: true,
                                            textButton:
                                                strings.cancelSubscription,
                                            onPressed: () {
                                              _isCancelingNotifier.value = true;
                                              _streamingCubit.deleteStreaming(
                                                widget.streaming.streamingId ??
                                                    '',
                                              );
                                            },
                                            buttonColor: const Color.fromRGBO(
                                              221,
                                              86,
                                              86,
                                              1,
                                            ),
                                          );
                                    },
                                  ),
                                )
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    ),
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
