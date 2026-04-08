def convert_minutes(total_minutes):
    if not isinstance(total_minutes, int) or total_minutes < 0:
        return "Please enter a non-negative integer."

    hrs  = total_minutes // 60  
    mins = total_minutes % 60  

    if hrs == 0:
        return f"{mins} minutes"
    elif mins == 0:
        return f"{hrs} hrs"
    else:
        return f"{hrs} hrs {mins} minutes"

test_cases = [130, 110, 60, 45, 0, 200, 90]
for t in test_cases:
    print(f"{t:>4} mins  →  {convert_minutes(t)}")