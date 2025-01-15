#!/bin/bash

DB_FILE="database.txt"

if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
fi

view_records() {
    if [ ! -s "$DB_FILE" ]; then
        echo "The database is empty."
    else
        echo "Database Records:"
        column -t -s, "$DB_FILE"
    fi
}

add_record() {
    echo "Enter a unique ID:"
    read -r id
    if grep -q "^$id," "$DB_FILE"; then
        echo "Record with ID $id already exists."
    else
        echo "Enter a name:"
        read -r name
        echo "Enter an age:"
        read -r age
        echo "$id,$name,$age" >> "$DB_FILE"
        echo "Record added successfully."
    fi
}

delete_record() {
    echo "Enter the ID of the record to delete:"
    read -r id
    if ! grep -q "^$id," "$DB_FILE"; then
        echo "Record with ID $id does not exist."
    else
        grep -v "^$id," "$DB_FILE" > temp.txt
        mv temp.txt "$DB_FILE"
        echo "Record deleted successfully."
    fi
}

while true; do
    echo "Mini Database Menu:"
    echo "1. View Records"
    echo "2. Add Record"
    echo "4. Delete Record"
    echo "5. Exit"
    echo "Enter your choice:"
    read -r choice
    case $choice in
        1) view_records ;;
        2) add_record ;;
        3) update_record ;;
        4) delete_record ;;
        5) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done