import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

extension OnContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  double get mWidth {
    return MediaQuery.of(this).size.width;
  }

  double get mHeight {
    return MediaQuery.of(this).size.height;
  }

  dynamic push(Widget widget) {
    return Navigator.push(
      this,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  // AppLocalizations? get localization => AppLocalizations.of(this);

  dynamic pushReplacement(Widget widget) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  dynamic pushAndRemoveUntil(Widget widget) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => widget),
      (_) => false,
    );
  }

  dynamic pushNamedAndRemoveUntil(String name, {dynamic arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      name,
      (_) => false,
      arguments: arguments,
    );
  }

  dynamic pushNamed(String screenName, {dynamic arguments}) {
    return Navigator.pushNamed(
      this,
      screenName,
      arguments: arguments,
    );
  }

  dynamic pushReplacementNamed(String screenName, {dynamic arguments}) {
    return Navigator.pushReplacementNamed(
      this,
      screenName,
      arguments: arguments,
    );
  }

  dynamic pop({dynamic data}) {
    return Navigator.pop(
      this,
      data,
    );
  }

  Future<bool> get maybePop async {
    return await Navigator.maybePop(this);
  }

  bool get canPop {
    return Navigator.canPop(this);
  }

  Orientation get mOrientation {
    return MediaQuery.of(this).orientation;
  }

  double get w => mWidth;
  double get h => mHeight;
  double get textMaxWidth => 450;
}

abstract class MainContext {
  late GlobalKey<NavigatorState> nav;
  BuildContext get context;
  void push(Widget widget);
  dynamic pop({dynamic data});
  void pushAndRemoveUntil(Widget widget);
  void pushNamed(String name);
  void pushReplacement(Widget widget);
  Future<bool> get maybePop;
  bool get canPop;
  Orientation get mOrientation;
  double get width;
  double get height;
  double get textMaxWidth => 450;
}

@Injectable(as: MainContext)
class Root implements MainContext {
  Root({required this.nav});

  @override
  GlobalKey<NavigatorState> nav;

  @override
  BuildContext get context => nav.currentContext!;

  @override
  void push(Widget widget) {
    context.push(widget);
  }

  @override
  dynamic pop({dynamic data}) {
    return context.pop(data: data);
  }

  @override
  void pushAndRemoveUntil(Widget widget) {
    context.pushAndRemoveUntil(widget);
  }

  @override
  void pushNamed(String name) {
    context.pushNamed(name);
  }

  @override
  void pushReplacement(Widget widget) {
    context.pushReplacement(widget);
  }

  @override
  Future<bool> get maybePop async {
    return await Navigator.maybePop(context);
  }

  @override
  bool get canPop {
    return Navigator.canPop(context);
  }

  @override
  Orientation get mOrientation {
    return MediaQuery.of(context).orientation;
  }

  @override
  double get width => context.mWidth;

  @override
  double get height => context.mHeight;

  @override
  double get textMaxWidth => 450;
}
