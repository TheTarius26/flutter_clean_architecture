// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:clean_architecture/bootstrap.dart';
import 'package:clean_architecture/src/app/app.dart';

void main() {
  bootstrap(() => const App());
}
