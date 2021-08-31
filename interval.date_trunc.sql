create or replace function date_trunc(value integer, unit text, ts timestamptz)
returns timestamptz language plpgsql immutable as
$function$
declare
    higher_unit text;
    dynsql_template constant text := $SQL$ 
   	SELECT date_trunc('__HIGHER_UNIT__', $1) + 
	 (extract(__UNIT__ from $1)::integer/__VALUE__) * __VALUE__  * interval '1 __UNIT__';$SQL$;
    retval timestamptz;
begin
    higher_unit := 
    case
      when unit in ('second', 'seconds') then 'minute'
      when unit in ('minute', 'minutes') then 'hour'
      when unit in ('hour', 'hours') then 'day'
    end;

    if higher_unit is null then
        raise 'date_trunc: timestamp unit "%" unknown or not supported. Use "seconds", "minutes" or "hours".', unit;
    end if;

    execute replace(replace(replace(dynsql_template,'__UNIT__',unit),'__HIGHER_UNIT__',higher_unit),'__VALUE__',value::text) using ts into retval;
    return retval;
end;
$function$;
