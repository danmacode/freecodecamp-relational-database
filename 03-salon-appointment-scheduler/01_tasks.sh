#!/usr/bin/env bash
#
# this script completes the tasks outlined below the instructions

# create a database named salon
create_db() {
  PSQL="psql -U freecodecamp -d postgres --no-align --tuples-only -c"
  if [ "$(psql -U freecodecamp -d postgres -XtAc "SELECT 1 FROM pg_database WHERE datname='salon'")" = '1' ]; then
    printf "# Database salon already exists\n"
  else
    echo "$($PSQL "CREATE DATABASE salon")"
  fi
}

# then create tables named customers, appointments, and services
# each table should have a primary key column that automatically increments
create_tables() {
  # now we use the "salon" database
  PSQL="psql -U freecodecamp -d salon --no-align --tuples-only -c"

  psql -U freecodecamp -d salon <<EOF
CREATE TABLE IF NOT EXISTS appointments(appointment_id SERIAL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS customers(customer_id SERIAL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS services(service_id SERIAL PRIMARY KEY);
EOF

  IFNT="IF NOT EXISTS"
  # Your appointments table should have a customer_id foreign key that references the customer_id column from the customers table
  echo "$($PSQL "ALTER TABLE appointments ADD COLUMN $IFNT customer_id INT REFERENCES customers(customer_id);")"
  # Your appointments table should have a service_id foreign key that references the service_id column from the services table
  echo "$($PSQL "ALTER TABLE appointments ADD COLUMN $IFNT service_id INT REFERENCES services(service_id);")"
  # Your customers table should have phone that is a VARCHAR and must be unique
  echo "$($PSQL "ALTER TABLE customers ADD COLUMN $IFNT phone VARCHAR(30) UNIQUE;")"
  # Your customers and services tables should have a name column
  echo "$($PSQL "ALTER TABLE customers ADD COLUMN $IFNT name VARCHAR(30);")"
  echo "$($PSQL "ALTER TABLE services ADD COLUMN $IFNT name VARCHAR(30);")"
  # Your appointments table should have a time column that is a VARCHAR
  echo "$($PSQL "ALTER TABLE appointments ADD COLUMN $IFNT time VARCHAR(10);")"
}

# You should have at least three rows in your services table for the different services you offer, one with a service_id of 1
# 1) cut
# 2) color
# 3) perm
# 4) style
# 5) trim
insert_services() {
  PSQL="psql -U freecodecamp -d salon --no-align --tuples-only -c"

  $($PSQL "INSERT INTO services(service_id, name) VALUES(1,'cut');")
  $($PSQL "INSERT INTO services(service_id, name) VALUES(2,'color');")
  $($PSQL "INSERT INTO services(service_id, name) VALUES(3,'perm');")
  $($PSQL "INSERT INTO services(service_id, name) VALUES(4,'style');")
  $($PSQL "INSERT INTO services(service_id, name) VALUES(5,'trim');")
}

main() {
  create_db
  create_tables
  insert_services
}

# main entry point
main
