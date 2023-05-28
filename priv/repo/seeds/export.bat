SET PATH=%PATH%;D:\Dev\Apps\PostgreSQL\10\bin

pg_dump --column-inserts --data-only --username=postgres --table=accounts yic_dev > accounts.sql
pg_dump --column-inserts --data-only --username=postgres --table=datadefs yic_dev > datadefs.sql
pg_dump --column-inserts --data-only --username=postgres --table=forms yic_dev > forms.sql
pg_dump --column-inserts --data-only --username=postgres --table=users yic_dev > users.sql
pg_dump --column-inserts --data-only --username=postgres --table=apis yic_dev > apis.sql