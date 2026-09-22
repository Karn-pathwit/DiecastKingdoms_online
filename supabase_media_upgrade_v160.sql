-- Diecast Kingdoms V1.6.0
-- Adds multi-image and short-video fields without removing existing data.

alter table public.projects
    add column if not exists images jsonb not null default '[]'::jsonb,
    add column if not exists video_url text,
    add column if not exists video_after_url text;

-- Some earlier builds already created images_after as TEXT.
-- Convert it in place while preserving any JSON-array text already stored there.
do $convert_images_after$
begin
    if exists (
        select 1
        from information_schema.columns
        where table_schema = 'public'
          and table_name = 'projects'
          and column_name = 'images_after'
          and data_type = 'text'
    ) then
        alter table public.projects
            alter column images_after drop default;
        alter table public.projects
            alter column images_after type jsonb
            using coalesce(nullif(btrim(images_after), ''), '[]')::jsonb;
    elsif not exists (
        select 1
        from information_schema.columns
        where table_schema = 'public'
          and table_name = 'projects'
          and column_name = 'images_after'
    ) then
        alter table public.projects
            add column images_after jsonb;
    end if;
end
$convert_images_after$;

update public.projects
set images_after = '[]'::jsonb
where images_after is null;

alter table public.projects
    alter column images_after set default '[]'::jsonb,
    alter column images_after set not null;

update public.projects
set images = jsonb_build_array(image_preview)
where image_preview is not null
  and image_preview <> ''
  and jsonb_array_length(images) = 0;

update public.projects
set images_after = jsonb_build_array(image_after_preview)
where image_after_preview is not null
  and image_after_preview <> ''
  and jsonb_array_length(images_after) = 0;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
    'project-media',
    'project-media',
    true,
    20971520,
    array['image/jpeg', 'image/png', 'image/webp', 'video/mp4']
)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

do $$
begin
    if not exists (
        select 1
        from pg_policies
        where schemaname = 'storage'
          and tablename = 'objects'
          and policyname = 'Allow project media uploads'
    ) then
        create policy "Allow project media uploads"
        on storage.objects
        for insert
        to anon, authenticated
        with check (bucket_id = 'project-media');
    end if;
end
$$;
