create or replace function date_bin
  (trunc_period interval, ts timestamptz, base_ts timestamptz default '1970-01-01Z')
  returns timestamptz language sql immutable as
$function$
select
  base_ts
  + floor(extract(epoch from ts - base_ts) / extract(epoch from trunc_period))::bigint
  * trunc_period;
$function$;
