// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneratedHistory)
const generatedHistoryProvider = GeneratedHistoryProvider._();

final class GeneratedHistoryProvider
    extends $NotifierProvider<GeneratedHistory, dynamic> {
  const GeneratedHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generatedHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generatedHistoryHash();

  @$internal
  @override
  GeneratedHistory create() => GeneratedHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$generatedHistoryHash() => r'205cca916adfd31100f0a7f080815969e736b5b2';

abstract class _$GeneratedHistory extends $Notifier<dynamic> {
  dynamic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<dynamic, dynamic>,
              dynamic,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
