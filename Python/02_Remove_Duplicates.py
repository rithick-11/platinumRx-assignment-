def remove_duplicates(s):
    result = ""
    for char in s:
        if char not in result:  
            result += char
    return result


test_strings = [
    "programming",
    "hello world",
    "aabbccdd",
    "abcabc",
    "PlatinumRx",
    "",
]

for ts in test_strings:
    print(f"Input : '{ts}'")
    print(f"Output: '{remove_duplicates(ts)}'")
    print()