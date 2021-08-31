# timestamp date_trunc  
```sql
function date_trunc(value integer, unit text, ts timestamptz) returns timestamptz
```
**unit** may be second(s), minute(s) or hour(s).
```sql
select now(), date_trunc(10, 'seconds', now());
```
yields 2021-08-31 20:42:**33.613605**, 2021-08-31 20:42:**30.0**
