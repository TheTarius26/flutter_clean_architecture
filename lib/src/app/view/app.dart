// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:clean_architecture/l10n/l10n.dart';
import 'package:clean_architecture/src/config/routes/route.dart';
import 'package:clean_architecture/src/config/themes/app_theme.dart';
import 'package:clean_architecture/src/core/utils/constants.dart';
import 'package:clean_architecture/src/injector.dart';
import 'package:clean_architecture/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => injector()..add(const GetArticles()),
      child: MaterialApp(
        theme: AppTheme.light,
        title: kMaterialAppTitle,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
