// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_art_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedArtStyle)
const selectedArtStyleProvider = SelectedArtStyleProvider._();

final class SelectedArtStyleProvider
    extends $NotifierProvider<SelectedArtStyle, String> {
  const SelectedArtStyleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedArtStyleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedArtStyleHash();

  @$internal
  @override
  SelectedArtStyle create() => SelectedArtStyle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$selectedArtStyleHash() => r'da9173028f99061589e2b3e5c431f482f20d2c49';

abstract class _$SelectedArtStyle extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
