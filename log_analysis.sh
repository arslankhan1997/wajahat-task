#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <log_file>"
    exit 1
}

# Check if the file is provided
if [ $# -ne 1 ]; then
    usage
fi

LOG_FILE=$1

# Check if the file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi

# Initialize counters
ERROR_COUNT=0
WARNING_COUNT=0
INFO_COUNT=0
OTHER_COUNT=0

# Process the log file line by line
while IFS= read -r line; do
    if [[ "$line" == *"ERROR"* ]]; then
        ((ERROR_COUNT++))
    elif [[ "$line" == *"WARNING"* ]]; then
        ((WARNING_COUNT++))
    elif [[ "$line" == *"INFO"* ]]; then
        ((INFO_COUNT++))
    else
        ((OTHER_COUNT++))
    fi
done < "$LOG_FILE"

# Output the results
echo "========================"
echo "Log Analysis Results"
echo "========================"
echo
echo "Summary:"
echo "--------"
printf "  %-20s : %d\n" "Total ERROR entries" "$ERROR_COUNT"
printf "  %-20s : %d\n" "Total WARNING entries" "$WARNING_COUNT"
printf "  %-20s : %d\n" "Total INFO entries" "$INFO_COUNT"
printf "  %-20s : %d\n" "Other lines" "$OTHER_COUNT"
echo
echo "Details:"
echo "--------"
if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "  ⚠️  Errors were found in the log file."
else
    echo "  ✅ No errors were found in the log file."
fi

if [ "$WARNING_COUNT" -gt 0 ]; then
    echo "  ⚠️  There are warnings to review."
else
    echo "  ✅ No warnings were found in the log file."
fi

if [ "$INFO_COUNT" -gt 0 ]; then
    echo "  📄 The log contains informational entries."
else
    echo "  ℹ️ No informational entries were found in the log file."
fi
echo
echo "End of Report."