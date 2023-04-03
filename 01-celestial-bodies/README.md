# Celestial bodies database

What's the deal wih TEXT & VARCHAR, or NUMERIC, REAL, DECIMAL & INT ?

From [postgresql.org](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-NUMERIC-DECIMAL):

- The only difference between TEXT and VARCHAR(n) is that you can limit the maximum length of a VARCHAR column
- NUMERIC & DECIMAL are the same in Postgres:
  - numeric or numeric(p,s) is a real number with p precision digits & s scale number after the decimal point
  - for DECIMAL the implementation is allowed to allow more digits than requested to the left of the decimal point. Postgres doesn't exercise that freedom so there's no difference between these types for us.
- REAL or float8 is a 4-byte floating-point number

All numeric types can be found [here](https://www.postgresql.org/docs/current/datatype-numeric.html)
