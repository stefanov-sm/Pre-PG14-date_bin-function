## Postgresql date_bin function for versions prior to PG14  
#### Postgresql `date_trunc` by interval. Can be used for running interval aggregation in time series data scenarios. 
```sql
function date_bin(trunc_period interval, ts timestamptz, base_ts timestamptz default '1970-01-01Z')
returns timestamptz;
```
#### Demo
```sql
select now(), date_bin(interval '10 seconds', now());
```
yields  
2021-09-13 23:18:**27.256826**, 2021-09-13 23:18:**20.0**
