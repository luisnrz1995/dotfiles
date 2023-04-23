import subprocess

def brightness():
    result = subprocess.run(['brightnessctl', '-m', '-d', 'intel_backlight'], capture_output=True, text=True)
    level = result.stdout.split(',')[3][:-1]

    level_int = int(level)
    if level_int >= 75:
        icon = ""
    elif level_int >= 50:
        icon = ""
    elif level_int >= 25:
        icon = ""
    else:
        icon = ""

    return f"{icon} {level}%"
