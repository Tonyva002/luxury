import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

abstract class Rust {
  Future<String> publishTaggedDataBlock(
      {required String tag, required String message, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kPublishTaggedDataBlockConstMeta;
}
