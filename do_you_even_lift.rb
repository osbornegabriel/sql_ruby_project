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
db.results_as_hash = true

create_table_cmd_lifting = <<-COVFEFE
  CREATE TABLE IF NOT EXISTS lifting(
    id INTEGER PRIMARY KEY,
    date DATE ,
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
    date DATE,
    total_calories INTEGER,
    total_fat INTEGER,
    total_carbs INTEGER,
    total_protein INTEGER
    )
COVFEFE2

db.execute(create_table_cmd_lifting)
db.execute(create_table_cmd_food)

#This allows the user to input their lifting information
def add_lifts(db, date, body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments)
    db.execute("INSERT INTO lifting (date, body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [date, body_weight, squats, bench_press, overhead_press, deadlifts, power_cleans, comments])
end

#This allows the user to input their food_log information
def add_macros(db, date, total_calories, total_fat, total_carbs, total_protein)
  db.execute("INSERT INTO food_log (date, total_calories, total_fat, total_carbs, total_protein) VALUES (?, ?, ?, ?, ?)", [date, total_calories, total_fat, total_carbs, total_protein])
end

#This diplays the food_log table to user
def display_food_log(db)
  p db.execute("SELECT * FROM food_log")
end

#This displays the lifting table to user
def display_lifts(db)
  p db.execute("SELECT * FROM lifting")
end

#This displays both tables to the user
def display_training(db)
    training_data =  db.execute("SELECT food_log.date, food_log.total_calories, food_log.total_fat, food_log.total_carbs, food_log.total_protein, lifting.body_weight, lifting.squats, lifting.bench_press, lifting.overhead_press, lifting.deadlifts, lifting.power_cleans FROM food_log JOIN lifting ON food_log.date = lifting.date;")
    training_data.each do |training|
      print "On #{training['date']} you ate #{training['total_calories']} calories, #{training['total_fat']} grams of fat, #{training['total_carbs']} #{training['total_carbs']} grams of carbohydrates, and #{training['total_protein']} grams of protein."
      if training['body_weight'] != nil
        puts "You also trained that day! You weighed #{training['body_weight']}. These we're your lifts for the day:"
        puts "You squatted #{training['squats']}lbs " if training['squats'] != ""
        puts "You benched #{training['bench_press']} lbs" if training['bench_press'] != ""
        puts "You pressed #{training['overhead_press']} lbs" if training['overhead_press'] != ""
        puts "You deadlifted #{training['deadlifts']} lbs" if training['deadlifts'] != ""
        puts "You power cleaned #{training['power_cleans']} lbs" if training['power_cleans'] != ""
      end
    end
end


# ****Now we're going to create the methods that interact with the user****

#Gather's information from user, and uses to add entry to lifting table
def gather_lifts(db)
  new_session = nil
  until new_session == 'y' || new_session == 'n'
  puts "You want to add a new lifting session, is that correct?(y/n)"
    new_session = gets.chomp
  end
  if new_session == 'y'
    #gather data from user for lifting log entry
    correct = nil
    until correct == 'y'
      puts "What is the date for your entry? (Format as YYYY-MM-DD)"
      date = gets.chomp
      puts "What is your body weight?"
      weight = gets.chomp
      puts "How much did you squat? (leave blank if did not squat)"
      squats = gets.chomp
      puts "How much did you bench? (leave blank if did not bench)"
      bench = gets.chomp
      puts "How much did you press? (leave blank if did not overhead press)"
      press = gets.chomp
      puts "How much did you deadlift? (leave blank if did not deaflift)"
      deadlifts = gets.chomp
      puts "How much did you power clean? (leave blank if did not power clean)"
      cleans = gets.chomp
      puts "Do you have any additional comments? (leave blank if no comments)"
      comments = gets.chomp
      #check data is correct with user
      puts "This is what you inputted for #{date}:"
      puts "Body Weight: #{weight}"
      puts "Squats: #{squats}"
      puts "Bench: #{bench}"
      puts "Press: #{press}"
      puts "Deadlifts: #{deadlifts}"
      puts "Cleans: #{cleans}"
      puts "Comments: #{comments}"
      puts "Is this correct?(y/n)"
      correct = gets.chomp
    end
    add_lifts(db, date, weight, squats, bench, press, deadlifts, cleans, comments)
  else
    puts "Oh, nevermind then! Back to the menu we go!"
  end
end


#gathers information from user, and uses to create new entry to food_log table
def gather_macros(db)
  new_session = nil
  until new_session == 'y' || new_session == 'n'
    puts "You want to add a new entry to your food log, is that correct?(y/n)"
    new_session = gets.chomp
  end
  if new_session == 'y'
    #gather data from user for lifting log entry
    correct = nil
    until correct == 'y'
      puts "What is the date for your entry? (Format as YYYY-MM-DD)"
      date = gets.chomp
      puts "How many calories did you eat today?"
      calories = gets.chomp
      puts "How many grams of fat did you eat today?"
      fat = gets.chomp
      puts "How many grams of carbohydrates did you eat today?"
      carbs = gets.chomp
      puts "How many grams of protein did you eat today?"
      protein = gets.chomp
      #check that data is correct with user
      puts "This is what you inputted:"
      puts "You ate #{calories} calories"
      puts "You ate #{fat} grams of fat"
      puts "You ate #{carbs} grams of carbohydrates"
      puts "You ate #{protein} grams of protein"
      puts "Is this correct?(y/n)"
      correct = gets.chomp
    end
    add_macros(db, date, calories, fat, carbs, protein)
  else
    puts "Oh, nevermind then! Back to the menu we go!"
  end
end

#*****Now we're going to ask the user what they wish to do!!!
def user_interface(db)
  exit = nil
  until exit == true
    choice = 0
    until choice < 7 && choice > 0
      puts "What would you like to do today?"
      puts "Please select an option (by typing the matching integer):"
      puts "1 - View all training information"
      puts "2 - View food log"
      puts "3 - View lifting log"
      puts "4 - Add new entry into lifting log"
      puts "5 - Add new entry into food log"
      puts "6 - Exit"
      choice = gets.chomp.to_i
      case choice
      when 1
        display_training(db)
      when 2
        display_food_log(db)
      when 3
        display_lifts(db)
      when 4
        gather_lifts(db)
      when 5
        gather_macros(db)
      when 6
        exit = true
      else
        puts "You didn't choose any entries from 1-6. Let's try that again"
      end
    end
    wish_to_exit = nil
    until exit == true || wish_to_exit == 'y' || wish_to_exit == 'n'
      puts "Are you finished for today?(y/n)"
      wish_to_exit = gets.chomp
    end
    if wish_to_exit == 'n'
      exit = false
    else
      exit = true
    end
  end
  puts "Keep on training hard, have a great day!"
end

user_interface(db)