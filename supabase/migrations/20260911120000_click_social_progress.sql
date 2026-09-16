-- Click & Social journey: learner profile, lesson badges, Instagram
-- setup, and the practice-feed post. One row per signed-in artisan.
-- Shot photographs stay in public.shots / the photos bucket.

create table if not exists public.learner_progress (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  display_name text,
  cluster_id text,
  language text not null default 'en',
  onboarded boolean not null default false,
  lesson_photo_done boolean not null default false,
  lesson_profile_done boolean not null default false,
  lesson_content_done boolean not null default false,
  lesson_strategy_done boolean not null default false,
  lesson_analytics_done boolean not null default false,
  ig_username text,
  ig_bio text[] not null default '{}',
  ig_category text,
  profile_photo_path text,
  post_caption text,
  post_tags text,
  post_user text,
  post_media_path text,
  post_media_is_video boolean not null default false,
  shoot_meta jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.learner_progress enable row level security;

drop policy if exists "Learner progress readable by owner" on public.learner_progress;
create policy "Learner progress readable by owner"
  on public.learner_progress for select
  using (auth.uid() = user_id);

drop policy if exists "Learner progress insertable by owner" on public.learner_progress;
create policy "Learner progress insertable by owner"
  on public.learner_progress for insert
  with check (auth.uid() = user_id);

drop policy if exists "Learner progress updatable by owner" on public.learner_progress;
create policy "Learner progress updatable by owner"
  on public.learner_progress for update
  using (auth.uid() = user_id);

drop policy if exists "Learner progress deletable by owner" on public.learner_progress;
create policy "Learner progress deletable by owner"
  on public.learner_progress for delete
  using (auth.uid() = user_id);
