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
  static const _backgroundColor = Color.fromRGBO(243, 243, 243, 1);
  static const _primaryColor = Color.fromRGBO(111, 86, 221, 1);
  static const _deleteColor = Color.fromRGBO(221, 86, 86, 1);
  static const _dateFormat = 'dd/MM/yyyy';

  final strings = SubscriptionsManagementStrings();
  final _streamingCubit = GetIt.I.get<StreamingManagementCubit>();

  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _startsAtController = TextEditingController();
  final _renewalDateController = TextEditingController();

  final _isSavingNotifier = ValueNotifier<bool>(false);
  final _isDeletingNotifier = ValueNotifier<bool>(false);
  final _isFormValidNotifier = ValueNotifier<bool>(false);
  PaymentMethod? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _initializeFields();
    _setupFormValidation();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeFields() {
    _nameController.text = widget.streaming.streamingName;

    if (!widget.newStreaming) {
      _initializeEditFields();
    }
  }

  void _initializeEditFields() {
    if (widget.streaming.streamingValue != null) {
      _valueController.text = CurrencyFormatter.format(
        widget.streaming.streamingValue!,
      );
    }

    if (widget.streaming.startsAt != null) {
      _startsAtController.text = DateFormat(
        _dateFormat,
      ).format(widget.streaming.startsAt!);
    }

    if (widget.streaming.renewalDate != null) {
      _renewalDateController.text = DateFormat(
        _dateFormat,
      ).format(widget.streaming.renewalDate!);
    }

    _selectedPaymentMethod = widget.streaming.paymentMethod;
  }

  void _disposeControllers() {
    _nameController.dispose();
    _valueController.dispose();
    _startsAtController.dispose();
    _renewalDateController.dispose();
    _isSavingNotifier.dispose();
    _isDeletingNotifier.dispose();
    _isFormValidNotifier.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) => _buildDatePickerTheme(child!),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat(_dateFormat).format(picked);
      });
      _validateForm();
    }
  }

  void _formatCurrency(String value) {
    final formattedValue = CurrencyFormatter.formatInput(value);
    if (formattedValue.isNotEmpty) {
      _valueController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(
          offset: formattedValue.length.clamp(0, formattedValue.length),
        ),
      );
    }
  }

  // ✅ Método para configurar listeners de validação
  void _setupFormValidation() {
    _nameController.addListener(_validateForm);
    _valueController.addListener(_validateForm);
    _startsAtController.addListener(_validateForm);
    _renewalDateController.addListener(_validateForm);

    // Validação inicial
    _validateForm();
  }

  // ✅ Método para validar o formulário
  void _validateForm() {
    final isNameValid = _nameController.text.trim().isNotEmpty;
    final isValueValid = _valueController.text.trim().isNotEmpty;
    final isStartsAtValid = _startsAtController.text.trim().isNotEmpty;
    final isRenewalDateValid = _renewalDateController.text.trim().isNotEmpty;
    final isPaymentMethodValid = _selectedPaymentMethod != null;

    final isFormValid =
        isNameValid &&
        isValueValid &&
        isStartsAtValid &&
        isRenewalDateValid &&
        isPaymentMethodValid;

    _isFormValidNotifier.value = isFormValid;
  }

  dynamic _onPaymentMethodChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedPaymentMethod = PaymentMethod.getPaymentMethodFromString(
          value,
        );
      });
      _validateForm();
    }
  }

  Future<void> _onSavePressed() async {
    _isSavingNotifier.value = true;
    final entity = _buildStreamingEntity();

    if (widget.newStreaming) {
      await _streamingCubit.addStreaming(entity);
    } else {
      await _streamingCubit.updateStreaming(entity);
    }
  }

  Future<void> _onDeletePressed() async {
    _isDeletingNotifier.value = true;
    await _streamingCubit.deleteStreaming(widget.streaming.streamingId ?? '');
  }

  StreamingEntity _buildStreamingEntity() {
    return StreamingEntity(
      streamingId: widget.newStreaming ? null : widget.streaming.streamingId,
      streamingName: _nameController.text,
      streamingValue: CurrencyFormatter.parse(_valueController.text),
      startsAt:
          _parseDate(_startsAtController.text) ??
          (widget.newStreaming ? null : widget.streaming.startsAt),
      renewalDate:
          _parseDate(_renewalDateController.text) ??
          (widget.newStreaming ? null : widget.streaming.renewalDate),
      paymentMethod: _selectedPaymentMethod ?? widget.streaming.paymentMethod,
    );
  }

  DateTime? _parseDate(String dateText) {
    if (dateText.isEmpty) return null;
    try {
      return DateFormat(_dateFormat).parse(dateText);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildBackButton(),
      title: _buildAppBarTitle(),
      backgroundColor: _backgroundColor,
      elevation: 0,
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: const Icon(Icons.arrow_back_ios_new, color: _primaryColor),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Text(
        widget.newStreaming
            ? strings.addSubscription
            : strings.editSubscription,
        style: TextStyle(
          fontSize: 20.sp,
          color: _primaryColor,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => _streamingCubit,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(children: [_buildHeader(), _buildForm()]),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (widget.newStreaming) {
      return _buildNewStreamingHeader();
    } else {
      return _buildEditStreamingHeader();
    }
  }

  Widget _buildNewStreamingHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child:
          widget.streaming.streamingImage?.isNotEmpty == true
              ? Image.asset(
                widget.streaming.streamingImage!,
                errorBuilder:
                    (context, error, stackTrace) => const SizedBox.shrink(),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildEditStreamingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildStreamingName(), _buildStreamingInfo()],
    );
  }

  Widget _buildStreamingName() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        widget.streaming.streamingName,
        style: TextStyle(
          fontSize: 24.sp,
          color: _primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStreamingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.streaming.streamingValue != null)
          Text(
            CurrencyFormatter.format(widget.streaming.streamingValue!),
            style: TextStyle(
              fontSize: 24.sp,
              color: _primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (widget.streaming.renewalDate != null)
          Text(
            DateFormat(_dateFormat).format(widget.streaming.renewalDate!),
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color.fromRGBO(77, 77, 97, 1),
            ),
          ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        CustomForm(
          hintText: strings.name,
          isPrefixHint: true,
          controller: _nameController,
        ),
        CustomForm(
          hintText: strings.value,
          isPrefixHint: true,
          controller: _valueController,
          onChanged: _formatCurrency,
          keyboardType: TextInputType.number,
        ),
        CustomForm(
          hintText: strings.startsAt,
          isPrefixHint: true,
          suffixIcon: const Icon(Icons.calendar_month),
          controller: _startsAtController,
          isDatePicker: true,
          onTap: () => _selectDate(_startsAtController),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: CustomForm(
            hintText: strings.renewAt,
            isPrefixHint: true,
            suffixIcon: const Icon(Icons.calendar_month),
            controller: _renewalDateController,
            isDatePicker: true,
            onTap: () => _selectDate(_renewalDateController),
          ),
        ),
        _buildPaymentMethodDropdown(),
      ],
    );
  }

  Widget _buildPaymentMethodDropdown() {
    return DropdownWidget(
      isPaymentMethod: true,
      options: [strings.debitCard, strings.creditCard, strings.pix],
      onChanged: _onPaymentMethodChanged,
      selectedValue: PaymentMethod.getStringFromPaymentMethod(
        _selectedPaymentMethod,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocConsumer<StreamingManagementCubit, StreamingManagementState>(
          listener: _handleBlocState,
          builder:
              (context, state) => Column(
                children: [
                  _buildSaveButton(),
                  if (!widget.newStreaming) _buildDeleteButton(),
                ],
              ),
        ),
      ],
    );
  }

  void _handleBlocState(BuildContext context, StreamingManagementState state) {
    if (state.isFailure) {
      final wasDeleting = _isDeletingNotifier.value;
      _resetLoadingStates();

      String errorMessage;
      if (wasDeleting) {
        errorMessage = strings.errorToCancelSubscription;
      } else if (widget.newStreaming) {
        errorMessage = strings.errorToCreateSubscription;
      } else {
        errorMessage = strings.errorToUpdateSubscription;
      }

      _showErrorSnackBar(errorMessage);
    }
    if (state.isSuccess) {
      final wasDeleting = _isDeletingNotifier.value;
      _resetLoadingStates();

      String successMessage;
      if (wasDeleting) {
        successMessage = strings.subscriptionCanceled;
      } else if (widget.newStreaming) {
        successMessage = strings.subscriptionCreated;
      } else {
        successMessage = strings.subscriptionUpdated;
      }

      _showSuccessSnackBar(successMessage);
      context.pushRoute(HomePageRoute());
    }
  }

  void _resetLoadingStates() {
    _isSavingNotifier.value = false;
    _isDeletingNotifier.value = false;
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: widget.newStreaming ? 32.h : 16.h,
        top: 32.h,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isSavingNotifier,
        builder: (context, isSaving, child) {
          if (isSaving) {
            return const LoadingButton(isLarge: true);
          }

          return ValueListenableBuilder<bool>(
            valueListenable: _isFormValidNotifier,
            builder: (context, isFormValid, child) {
              return CustomButton(
                isLarge: true,
                textButton:
                    widget.newStreaming
                        ? strings.addSubscription
                        : strings.save,
                onPressed: () => isFormValid ? _onSavePressed() : null,
                buttonColor: isFormValid ? _primaryColor : Colors.grey.shade400,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 32.h),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isDeletingNotifier,
        builder: (context, isDeleting, child) {
          return isDeleting
              ? const LoadingButton(isLarge: true, buttonColor: _deleteColor)
              : CustomButton(
                isLarge: true,
                textButton: strings.cancelSubscription,
                onPressed: _onDeletePressed,
                buttonColor: _deleteColor,
              );
        },
      ),
    );
  }

  Widget _buildDatePickerTheme(Widget child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: _primaryColor,
        colorScheme: const ColorScheme.light(primary: _primaryColor),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: child,
    );
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 194, 81, 81),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(String message) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 74, 183, 85),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
