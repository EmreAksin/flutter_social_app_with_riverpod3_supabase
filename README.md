# Social App (Flutter + Supabase)

A modern social media app built with Flutter, Supabase, Riverpod 3.x, Freezed, and Clean Architecture. It supports real‑time feeds, likes, comments, profiles, image uploads, and follow relationships.

## Architecture

The project follows Clean Architecture with a strict separation of concerns:

```
lib/
├── core/                     # Cross-cutting concerns and app-wide utilities
│   ├── constants/            # App constants (e.g., Supabase URL/keys)
│   ├── providers/            # Global Riverpod providers (e.g., Supabase client)
│   ├── router/               # GoRouter configuration
│   ├── utils/                # Error handling, helpers
│   └── widgets/              # Reusable UI widgets (loading, empty, error)
└── features/
    ├── auth/                 # Authentication feature
    │   ├── domain/           # Entities & repository interfaces
    │   ├── data/             # Models, data sources, repository implementations
    │   └── presentation/     # Providers, screens, widgets
    ├── post/                 # Posts (CRUD, likes, comments, feed)
    └── profile/              # User profiles and follows
```

### Layer Responsibilities

1) Domain
- Entities: Immutable business models (Freezed)
- Repositories: Abstract interfaces the app depends on

2) Data
- Models: API/DB representations + JSON serialization
- Data Sources: Supabase queries/storage/RPC
- Repositories: Map data models to domain entities and implement domain contracts

3) Presentation
- Providers: Riverpod 3.x for DI, streams, and controllers
- UI: Screens and widgets consuming providers with `ref.watch/read/listen`

## Features

- Authentication (email/password)
- Real‑time feed with live updates
- Create/delete posts with optional image upload (Supabase Storage)
- Like/unlike posts with counts
- Add/delete comments with counts
- User profiles (view/edit, avatar upload)
- Follow/unfollow users

## Tech Stack

- State management: Riverpod 3.x (`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`)
- Codegen: Freezed, json_serializable, build_runner
- Backend: supabase_flutter (Auth, Postgres, Storage, Realtime)
- Navigation: go_router
- UI: Flutter Material 3, cached_network_image, image_picker, intl

Note: The app uses Riverpod 3.x idioms (generated `@riverpod` providers, `AsyncValue`, controllers invalidating read-only providers, and UI-side error handling).

## Setup

1) Install dependencies
```bash
flutter pub get
```

2) Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

3) Configure Supabase
Update your keys in `lib/core/constants/app_constants.dart`:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

4) Database setup (Supabase SQL)

In this repository, SQL helper scripts are provided to manage counts and RLS policies:

- `create_triggers.sql` — create triggers for like/comment counts
- `delete_all_triggers.sql` — drop triggers
- `fix_counts.sql`, `fix_rls_for_counts.sql`, `clean_and_fix.sql`, `emergency_fix.sql` — utility scripts for repairing counts/policies

Run the needed scripts in Supabase Dashboard → SQL Editor. Ensure tables exist:

- `profiles` (user profile info)
- `posts` (id, user_id, content, image_url, likes_count, comments_count, created_at, updated_at)
- `likes`, `comments`, `follows`

### Quick start SQL (copy/paste into Supabase SQL Editor)

Create required tables:

```sql
-- profiles
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  full_name text,
  bio text,
  avatar_url text,
  created_at timestamp with time zone default now()
);

-- posts
create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  content text not null,
  image_url text,
  likes_count int not null default 0,
  comments_count int not null default 0,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- likes
create table if not exists likes (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references posts(id) on delete cascade,
  user_id uuid not null references profiles(id) on delete cascade,
  created_at timestamp with time zone default now(),
  unique(post_id, user_id)
);

-- comments
create table if not exists comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references posts(id) on delete cascade,
  user_id uuid not null references profiles(id) on delete cascade,
  content text not null,
  created_at timestamp with time zone default now()
);

-- follows
create table if not exists follows (
  id uuid primary key default gen_random_uuid(),
  follower_id uuid not null references profiles(id) on delete cascade,
  following_id uuid not null references profiles(id) on delete cascade,
  created_at timestamp with time zone default now(),
  unique(follower_id, following_id)
);
```

Add counters (triggers) for likes and comments:

```sql
-- Likes +1/-1
create or replace function inc_likes_count() returns trigger as $$
begin
  update posts set likes_count = likes_count + 1 where id = new.post_id;
  return new;
end; $$ language plpgsql;

create or replace function dec_likes_count() returns trigger as $$
begin
  update posts set likes_count = greatest(likes_count - 1, 0) where id = old.post_id;
  return old;
end; $$ language plpgsql;

drop trigger if exists trg_inc_likes on likes;
create trigger trg_inc_likes after insert on likes
for each row execute function inc_likes_count();

drop trigger if exists trg_dec_likes on likes;
create trigger trg_dec_likes after delete on likes
for each row execute function dec_likes_count();

-- Comments +1/-1
create or replace function inc_comments_count() returns trigger as $$
begin
  update posts set comments_count = comments_count + 1 where id = new.post_id;
  return new;
end; $$ language plpgsql;

create or replace function dec_comments_count() returns trigger as $$
begin
  update posts set comments_count = greatest(comments_count - 1, 0) where id = old.post_id;
  return old;
end; $$ language plpgsql;

drop trigger if exists trg_inc_comments on comments;
create trigger trg_inc_comments after insert on comments
for each row execute function inc_comments_count();

drop trigger if exists trg_dec_comments on comments;
create trigger trg_dec_comments after delete on comments
for each row execute function dec_comments_count();
```

Enable minimal RLS policies (optional but recommended):

```sql
alter table profiles enable row level security;
alter table posts enable row level security;
alter table likes enable row level security;
alter table comments enable row level security;
alter table follows enable row level security;

create policy p_profiles_read on profiles for select using (true);
create policy p_profiles_self on profiles for update using (auth.uid() = id);

create policy p_posts_read on posts for select using (true);
create policy p_posts_insert on posts for insert with check (auth.uid() = user_id);
create policy p_posts_own_update on posts for update using (auth.uid() = user_id);
create policy p_posts_own_delete on posts for delete using (auth.uid() = user_id);

create policy p_likes_read on likes for select using (true);
create policy p_likes_insert on likes for insert with check (auth.uid() = user_id);
create policy p_likes_own_delete on likes for delete using (auth.uid() = user_id);

create policy p_comments_read on comments for select using (true);
create policy p_comments_insert on comments for insert with check (auth.uid() = user_id);
create policy p_comments_own_delete on comments for delete using (auth.uid() = user_id);

create policy p_follows_read on follows for select using (true);
create policy p_follows_insert on follows for insert with check (auth.uid() = follower_id);
create policy p_follows_own_delete on follows for delete using (auth.uid() = follower_id);
```

5) Storage buckets (Supabase Storage)

- `avatars` (public)
- `posts` (public)

## Run

```bash
flutter run
```

## Development Notes

- Controllers follow a stateless mutation pattern: they call repositories and then `ref.invalidate(...)` read-only providers to refresh UI. Errors are handled in UI using `try/catch` and a centralized `ErrorUtils.showErrorSnackBar`.
- Real‑time: Feeds and some queries use `.stream(...).order(...)`, and UI either watches `postsStreamProvider` or fetches a one‑time snapshot via `.first`.
- Profile and comments invalidate the corresponding providers after mutations to ensure the UI refreshes immediately.

## Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
# or in watch mode
dart run build_runner watch --delete-conflicting-outputs
```

If your IDE shows “blue arrows” or appears frozen, it’s usually the analyzer/indexer or build_runner doing heavy work. Prefer running `watch` only when needed.

## Troubleshooting

- UI not updating after like/comment/profile edit → ensure related providers are invalidated (e.g., `ref.invalidate(postsStreamProvider)`, `ref.invalidate(isPostLikedProvider(id))`, `ref.invalidate(postCommentsProvider(id))`, `ref.invalidate(currentUserProfileProvider)`).
- “Cannot use the Ref after it has been disposed” → avoid mutating `state` inside long async flows of controllers; prefer stateless mutations + invalidation and UI‑side error handling. Check `ref.mounted`/`context.mounted` after async gaps.
- Success snackbars are intentionally removed; show error snackbars only.

## Design Patterns

- Clean Architecture
- Repository Pattern
- Dependency Injection (Riverpod providers)
- MVVM‑like (controllers as view models)
- Immutability (Freezed)
- Streams for realtime
- Centralized error utilities

## License

MIT License

## Author

Built with Clean Architecture and best practices, focusing on testability, readability, and real‑time UX.
