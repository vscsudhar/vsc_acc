// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i13;
import 'package:vsc_acc/ui/views/add_form/add_form_view.dart' as _i11;
import 'package:vsc_acc/ui/views/available_fund/available_fund_view.dart'
    as _i8;
import 'package:vsc_acc/ui/views/donation_collection/donation_collection_view.dart'
    as _i4;
import 'package:vsc_acc/ui/views/expenses/expenses_view.dart' as _i6;
import 'package:vsc_acc/ui/views/fund_collection/fund_collection_view.dart'
    as _i5;
import 'package:vsc_acc/ui/views/home/home_view.dart' as _i2;
import 'package:vsc_acc/ui/views/rice_collection/rice_collection_view.dart'
    as _i7;
import 'package:vsc_acc/ui/views/sponsors/sponsors_view.dart' as _i9;
import 'package:vsc_acc/ui/views/startup/startup_view.dart' as _i3;
import 'package:vsc_acc/ui/views/total_fund/total_fund_view.dart' as _i10;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const donationCollectionView = '/donation-collection-view';

  static const fundCollectionView = '/fund-collection-view';

  static const expensesView = '/expenses-view';

  static const riceCollectionView = '/rice-collection-view';

  static const availableFundView = '/available-fund-view';

  static const sponsorsView = '/sponsors-view';

  static const totalFundView = '/total-fund-view';

  static const addFormView = '/add-form-view';

  static const all = <String>{
    homeView,
    startupView,
    donationCollectionView,
    fundCollectionView,
    expensesView,
    riceCollectionView,
    availableFundView,
    sponsorsView,
    totalFundView,
    addFormView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.donationCollectionView,
      page: _i4.DonationCollectionView,
    ),
    _i1.RouteDef(
      Routes.fundCollectionView,
      page: _i5.FundCollectionView,
    ),
    _i1.RouteDef(
      Routes.expensesView,
      page: _i6.ExpensesView,
    ),
    _i1.RouteDef(
      Routes.riceCollectionView,
      page: _i7.RiceCollectionView,
    ),
    _i1.RouteDef(
      Routes.availableFundView,
      page: _i8.AvailableFundView,
    ),
    _i1.RouteDef(
      Routes.sponsorsView,
      page: _i9.SponsorsView,
    ),
    _i1.RouteDef(
      Routes.totalFundView,
      page: _i10.TotalFundView,
    ),
    _i1.RouteDef(
      Routes.addFormView,
      page: _i11.AddFormView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.DonationCollectionView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.DonationCollectionView(),
        settings: data,
      );
    },
    _i5.FundCollectionView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.FundCollectionView(),
        settings: data,
      );
    },
    _i6.ExpensesView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ExpensesView(),
        settings: data,
      );
    },
    _i7.RiceCollectionView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.RiceCollectionView(),
        settings: data,
      );
    },
    _i8.AvailableFundView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.AvailableFundView(),
        settings: data,
      );
    },
    _i9.SponsorsView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.SponsorsView(),
        settings: data,
      );
    },
    _i10.TotalFundView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.TotalFundView(),
        settings: data,
      );
    },
    _i11.AddFormView: (data) {
      final args = data.getArgs<AddFormViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.AddFormView(value: args.value, key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddFormViewArguments {
  const AddFormViewArguments({
    required this.value,
    this.key,
  });

  final String value;

  final _i12.Key? key;

  @override
  String toString() {
    return '{"value": "$value", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AddFormViewArguments other) {
    if (identical(this, other)) return true;
    return other.value == value && other.key == key;
  }

  @override
  int get hashCode {
    return value.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i13.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDonationCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.donationCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFundCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.fundCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpensesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.expensesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRiceCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.riceCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAvailableFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.availableFundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSponsorsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sponsorsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTotalFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.totalFundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddFormView({
    required String value,
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addFormView,
        arguments: AddFormViewArguments(value: value, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDonationCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.donationCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFundCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.fundCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpensesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.expensesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRiceCollectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.riceCollectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAvailableFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.availableFundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSponsorsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sponsorsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTotalFundView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.totalFundView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddFormView({
    required String value,
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addFormView,
        arguments: AddFormViewArguments(value: value, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
