// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postRemoteDataSource)
const postRemoteDataSourceProvider = PostRemoteDataSourceProvider._();

final class PostRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PostRemoteDataSource,
          PostRemoteDataSource,
          PostRemoteDataSource
        >
    with $Provider<PostRemoteDataSource> {
  const PostRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PostRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PostRemoteDataSource create(Ref ref) {
    return postRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRemoteDataSource>(value),
    );
  }
}

String _$postRemoteDataSourceHash() =>
    r'955a4d7bde1745c99f524be88fc130c649cea650';

@ProviderFor(postRepository)
const postRepositoryProvider = PostRepositoryProvider._();

final class PostRepositoryProvider
    extends $FunctionalProvider<PostRepository, PostRepository, PostRepository>
    with $Provider<PostRepository> {
  const PostRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostRepository create(Ref ref) {
    return postRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRepository>(value),
    );
  }
}

String _$postRepositoryHash() => r'4f44e6bfda77b6767a31dc2ee9ecd578177ec674';

@ProviderFor(postsStream)
const postsStreamProvider = PostsStreamProvider._();

final class PostsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostEntity>>,
          List<PostEntity>,
          Stream<List<PostEntity>>
        >
    with $FutureModifier<List<PostEntity>>, $StreamProvider<List<PostEntity>> {
  const PostsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<PostEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<PostEntity>> create(Ref ref) {
    return postsStream(ref);
  }
}

String _$postsStreamHash() => r'ba59a07f92ab04bd43678d5b5d64ee271a134cdd';

@ProviderFor(posts)
const postsProvider = PostsProvider._();

final class PostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostEntity>>,
          List<PostEntity>,
          FutureOr<List<PostEntity>>
        >
    with $FutureModifier<List<PostEntity>>, $FutureProvider<List<PostEntity>> {
  const PostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostEntity>> create(Ref ref) {
    return posts(ref);
  }
}

String _$postsHash() => r'a428259e4e80da7ecb9ab734fb96d3fb8c5be8b7';

@ProviderFor(userPosts)
const userPostsProvider = UserPostsFamily._();

final class UserPostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostEntity>>,
          List<PostEntity>,
          FutureOr<List<PostEntity>>
        >
    with $FutureModifier<List<PostEntity>>, $FutureProvider<List<PostEntity>> {
  const UserPostsProvider._({
    required UserPostsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userPostsHash();

  @override
  String toString() {
    return r'userPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PostEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return userPosts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userPostsHash() => r'c0f8cec71d795b036f059806635bbdb1b547004f';

final class UserPostsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<PostEntity>>, String> {
  const UserPostsFamily._()
    : super(
        retry: null,
        name: r'userPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserPostsProvider call(String userId) =>
      UserPostsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userPostsProvider';
}

@ProviderFor(isPostLiked)
const isPostLikedProvider = IsPostLikedFamily._();

final class IsPostLikedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const IsPostLikedProvider._({
    required IsPostLikedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isPostLikedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isPostLikedHash();

  @override
  String toString() {
    return r'isPostLikedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return isPostLiked(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPostLikedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isPostLikedHash() => r'0fd044a3f54c57a2acd2e66c681d7acfef845825';

final class IsPostLikedFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const IsPostLikedFamily._()
    : super(
        retry: null,
        name: r'isPostLikedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsPostLikedProvider call(String postId) =>
      IsPostLikedProvider._(argument: postId, from: this);

  @override
  String toString() => r'isPostLikedProvider';
}

@ProviderFor(postComments)
const postCommentsProvider = PostCommentsFamily._();

final class PostCommentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommentEntity>>,
          List<CommentEntity>,
          FutureOr<List<CommentEntity>>
        >
    with
        $FutureModifier<List<CommentEntity>>,
        $FutureProvider<List<CommentEntity>> {
  const PostCommentsProvider._({
    required PostCommentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'postCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postCommentsHash();

  @override
  String toString() {
    return r'postCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CommentEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommentEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return postComments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsHash() => r'8a5839e2a0be0e608632422e594b595ce37774b7';

final class PostCommentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CommentEntity>>, String> {
  const PostCommentsFamily._()
    : super(
        retry: null,
        name: r'postCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostCommentsProvider call(String postId) =>
      PostCommentsProvider._(argument: postId, from: this);

  @override
  String toString() => r'postCommentsProvider';
}

@ProviderFor(PostController)
const postControllerProvider = PostControllerProvider._();

final class PostControllerProvider
    extends $AsyncNotifierProvider<PostController, void> {
  const PostControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postControllerHash();

  @$internal
  @override
  PostController create() => PostController();
}

String _$postControllerHash() => r'32f0265b81acdf2363f7ecd051f870ff6bd43c11';

abstract class _$PostController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
