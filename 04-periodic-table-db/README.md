To run the PostgreSQL files, I use the option (-a all echo).

```shell
# 1st database dump
pg_dump -cC --inserts -U freecodecamp periodic_table >periodic_table_initial.sql

psql -U freecodecamp -d periodic_table -a -f 10_frst.sql

# 2nd database dump
pg_dump -cC --inserts -U freecodecamp periodic_table >periodic_table_10.sql
```

Then, run the next sql files

```shell
psql -U freecodecamp -d periodic_table -a -f 11_scnd.sql
# 3rd database dump
pg_dump -cC --inserts -U freecodecamp periodic_table >periodic_table_11.sql

```

```shell
psql -U freecodecamp -d periodic_table -a -f 12_thrd.sql
# 3rd database dump
pg_dump -cC --inserts -U freecodecamp periodic_table >periodic_table_12.sql

```

Then we create the folder and the git repo:

```shell
mkdir periodic_table && cd periodic_table
touch element.sh
chmod a+x element.sh # give it execute permissions
git init; git checkout -b main
git add element.sh
git status
git commit -m "Initial commit"


```
