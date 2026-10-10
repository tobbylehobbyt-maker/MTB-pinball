-- Forest Cadet: execute once in the Supabase SQL Editor.
create table if not exists public.forest_scores (
  player_id uuid not null references auth.users(id) on delete cascade,
  mode text not null check (mode in ('arcade','classic')),
  pseudo text not null check (char_length(pseudo) between 2 and 20),
  score bigint not null check (score between 0 and 1000000000),
  updated_at timestamptz not null default now(),
  submitted_at timestamptz not null default now(),
  primary key (player_id, mode)
);
alter table public.forest_scores enable row level security;
revoke all on public.forest_scores from anon, authenticated;
create index if not exists forest_ranking on public.forest_scores (mode, score desc, updated_at);

create or replace function public.forest_top_scores(p_mode text)
returns table(pseudo text, score bigint)
language sql stable security definer set search_path = '' as $$
  select s.pseudo,s.score from public.forest_scores s
  where s.mode=p_mode order by s.score desc,s.updated_at asc limit 20;
$$;
revoke all on function public.forest_top_scores(text) from public;
grant execute on function public.forest_top_scores(text) to anon, authenticated;

create or replace function public.forest_submit_score(p_pseudo text,p_score bigint,p_mode text)
returns void language plpgsql security definer set search_path = '' as $$
declare uid uuid := auth.uid();
begin
  if uid is null then raise exception 'Authentication required'; end if;
  if p_mode not in ('arcade','classic') or p_score not between 1 and 1000000000
    or p_pseudo !~ '^[[:alnum:] _.-]{2,20}$' then raise exception 'Invalid score'; end if;
  insert into public.forest_scores(player_id,mode,pseudo,score)
  values(uid,p_mode,p_pseudo,p_score)
  on conflict(player_id,mode) do update set
    score=greatest(forest_scores.score,excluded.score),
    pseudo=excluded.pseudo,
    updated_at=case when excluded.score>forest_scores.score then now() else forest_scores.updated_at end,
    submitted_at=now()
  where forest_scores.submitted_at < now()-interval '10 seconds';
end;
$$;
revoke all on function public.forest_submit_score(text,bigint,text) from public;
grant execute on function public.forest_submit_score(text,bigint,text) to authenticated;
