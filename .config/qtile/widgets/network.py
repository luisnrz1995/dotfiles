# Import the subprocess module for executing shell commands
import subprocess

# Define a function to check the network state
def network():
    try:
        # Check Ethernet connection state
        eth0_state = subprocess.check_output(['cat', '/sys/class/net/eth0/operstate']).decode().strip()
        
        # Check WLAN connection state
        wlan0_state = subprocess.check_output(['cat', '/sys/class/net/wlan0/operstate']).decode().strip()
        
        # Use match case to check the network state
        match (eth0_state, wlan0_state):
            case ("up", _):
                # Return "Online" if Ethernet is up
                return " Online"
            case (_, "up"):
                # Return "Online" if WLAN is up
                return "直 Online"
            case (_, _):
                # Return "Offline" if both Ethernet and WLAN are down
                return " Offline"
    except subprocess.CalledProcessError:
        # Return error message if subprocess check fails
        return "Error: Could not read network state."
