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
  ext - User can also display the contents of one or both tables. (Provide 4 options, attached to integers, for initial inquiry to user?)

=end

#require gems
require 'sqlite3'

#create sqlite3 database
db = SQLite3::Database.new("training_log.db")

