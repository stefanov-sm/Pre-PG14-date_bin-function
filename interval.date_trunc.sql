create or replace function util.date_trunc(value integer, unit text, ts timestamptz)
returns timestamptz language plpgsql immutable as
$function$
declare
    higher_unit text;
    dynsql_template constant text := $SQL$ 
   	SELECT date_trunc('__HIGHER_UNIT__', $1) + 
	 (extract(__UNIT__ from $1)::integer/__VALUE__) * __VALUE__  * interval '1 __UNIT__';$SQL$;
    dynsql text;
    retval timestamptz;
begin
    higher_unit := case
        when unit = 'second' or unit = 'seconds' then 'minute'
        when unit = 'minute' or unit = 'minutes' then 'hour'
        when unit = 'hour'   or unit = 'hours'   then 'day'
        else null end;

    if higher_unit is null then
        raise 'Timestamp unit "%" unknown or not supported. Use "seconds", "minutes" or "hours".', unit;
    end if;

    dynsql := replace(dynsql_template, '__UNIT__', unit);
    dynsql := replace(dynsql, '__HIGHER_UNIT__', higher_unit);
    dynsql := replace(dynsql, '__VALUE__', value::text);

    execute dynsql using ts into retval;
    return retval;
end;
$function$;
