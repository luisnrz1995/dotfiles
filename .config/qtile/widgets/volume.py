import subprocess

def volume():
    # Use "pamixer --get-mute" to check if the audio is muted, and store the result in the "mute" variable
    mute = subprocess.check_output(['pamixer', '--get-mute']).decode().strip()
    if mute == "true":
        # If the audio is muted, return the current volume with a muted icon
        return f' {subprocess.check_output(["pamixer", "--get-volume"]).decode().strip()}%'
    else:
        # If the audio is not muted, return the current volume with a normal volume icon
        return f' {subprocess.check_output(["pamixer", "--get-volume"]).decode().strip()}%'