=begin
 What we're going to do:
  We are going to build a sql database that consists of two tables: Lifting & Daily Macros

  The lifting table will consist of:
    Date, Bodyweight, Squats, Bench, Press, Deadlifts, Powercleans
  The FoodLog table will consist of:
    Date, Total Calories, Total Fat (in g), Total Carbs (in g), total Protein (in g)

  The ruby component of the programming is going to:
  1) Create the tables if they do not exist
  2) Allow a user to input either into the Lifting or FoodLog tables
  3) Once the tables are selected will prompt for each value
  4) Will execute one of two available methods for input, using the inputted values as arguments
  ext - User can also display the contents of one or both tables. (Provide 3 options, attached to integers, for initial inquiry to user?)

=end

#require gems
require 'sqlite3'

#create sqlite3 database
db = SQLite3::Database.new("training_log.db")

create_table_cmd_lifting = <<-COVFEFE
  CREATE TABLE IF NOT EXISTS lifting(
    id INTEGER PRIMARY KEY,
    date TIMESTAMP,
    body_weight INTEGER,
    squats INTEGER,
    bench_press INTEGER,
    overhead_press INTEGER,
    deadlifts INTEGER,
    power_cleans INTEGER,
    comments VARCHAR (255)
  )
COVFEFE

create_table_cmd_food = <<-COVFEFE2
  CREATE TABLE IF NOT EXISTS food_log(
    id INTEGER PRIMARY KEY,
    date TIMESTAMP,
    total_calories INTEGER,
    total_fat INTEGER,
    total_carbs INTEGER,
    total_protein INTEGER
    )
COVFEFE2

db.execute(create_table_cmd_lifting)
db.execute(create_table_cmd_food)

#This allows the user to input their lifting information
def add_lifts(db, body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments)
    db.execute("INSERT INTO lifting (body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments) VALUES (?, ?, ?, ?, ?, ?, ?)", [body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments])
end

#This allows the user to input their food_log information
def add_macros(total_calories, total_fat, total_carbs, total_protein)
  db.execute("INSERT INTO food_log (total_calories, total_fat, total_carbs, total_protein) VALUES (?, ?, ?, ?)", [total_calories, total_fat, total_carbs, total_protein])
end

#This diplays the food_log table to user
def display_food_log
end

#This displays the lifting table to user
def display_lifts
end

#This displays both tables to the user
def display_training
end
