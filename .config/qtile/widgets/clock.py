# Import the 'time' module
import time

# Define a function 'clock' that returns the current time in a specific format
def clock():
  # Using 'strftime' method of 'time' module to format the time
  current_time = time.strftime("%H:%M")
  # Returning the formatted time with an additional emoji
  return " " + current_time
