
First create a folder, a script in it and give exec. permissions.

Then, 

```shell
mkdir number_guessing_game && cd number_guessing_game
touch number_guess.sh && chmod a+x number_guess.sh
git init; git checkout -b main
git add .
git status
git commit -m "Initial commit"
```

Then we create the database

```shell
psql -U freecodecamp -d postgres -a -f 00_createdb.sql
```
