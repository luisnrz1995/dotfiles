# Import the subprocess module for executing shell commands
import subprocess

# Define a function named 'battery'
def battery():
  # Read battery status and capacity data from the '/sys/class/power_supply/BAT0/' directory
  status = subprocess.check_output(['cat', '/sys/class/power_supply/BAT0/status']).decode('utf-8').strip()
  capacity = int(subprocess.check_output(['cat', '/sys/class/power_supply/BAT0/capacity']).decode('utf-8').strip())

  # Determine which icon to display based on battery status and capacity
  if status in ["Charging", "Full"]:
    # If the battery is charging or full, return a charging or full battery icon with the capacity percentage
    return f" {capacity}%"
  elif capacity >= 95:
    # If the battery is above 95%, return a full battery icon
    return f"  {capacity}%"
  elif 60 <= capacity <= 94:
    # If the battery is between 60% and 94%, return a battery icon with 4 bars and the capacity percentage
    return f"  {capacity}%"
  elif 35 <= capacity <= 59:
    # If the battery is between 35% and 59%, return a battery icon with 3 bars and the capacity percentage
    return f"  {capacity}%"
  elif 10 <= capacity <= 34:
    # If the battery is between 10% and 34%, return a battery icon with 2 bars and the capacity percentage
    return f"  {capacity}%"
  else:
    # If the battery is below 10%, return a battery icon with 1 bar and the capacity percentage
    return f"  {capacity}%"
