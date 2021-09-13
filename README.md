# Postgresql interval date_trunc  
```sql
function date_trunc(trunc_period interval, ts timestamptz, base_ts timestamptz default '1970-01-01Z')
returns timestamptz;
```
### Demo
```sql
select now(), date_trunc(interval '10 seconds', now());
```
yields
```
2021-09-13 23:18:27.256826, 2021-09-13 23:18:20.0
