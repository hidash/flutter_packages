/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:meta/meta.dart';

/// Information about a printer
@immutable
class Printer {
  /// Create a printer information
  Printer({
    required this.url,
    String? name,
    this.model,
    this.location,
    this.comment,
    bool? isDefault,
    bool? isAvailable,
  })  : name = name ?? url,
        isDefault = isDefault ?? false,
        isAvailable = isAvailable ?? true;

  /// Create an information object from a dictionnary
  factory Printer.fromMap(Map<dynamic, dynamic> map) => Printer(
        url: map['url'],
        name: map['name'],
        model: map['model'],
        location: map['location'],
        comment: map['comment'],
        isDefault: map['default'],
        isAvailable: map['available'],
      );

  /// The platform specific printer identification
  dynamic? url;

  /// The display name of the printer
  dynamic? name;

  /// The printer model
  dynamic? model;

  /// The physical location of the printer
  dynamic? location;

  /// A user comment about the printer
  dynamic? comment;

  /// Is this the default printer on the system
  bool isDefault;

  /// The printer is available for printing
  bool isAvailable;

  @override
  String toString() => '''$runtimeType $name
  url:$url
  location:$location
  model:$model
  comment:$comment
  isDefault:$isDefault
  isAvailable: $isAvailable''';

  Map<String, Object?> toMap() => {
        'url': url,
        'name': name,
        'model': model,
        'location': location,
        'comment': comment,
        'default': isDefault,
        'available': isAvailable,
      };
}
