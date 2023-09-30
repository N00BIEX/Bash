#!/bin/bash

# Function to pad the branch code with leading zeros to ensure it has three digits
pad_3digit_code() {
    local branch_code=$1
    printf "%03d" $branch_code
}

# Prompt for user input
read -p "Choose Admit card or Result (R: Result, A: Admit card): " admit_result
admit_result=${admit_result,,}

read -p "Enter branch code: " branch_code
branch=$(pad_3digit_code $branch_code)

read -p "Enter batch: " batch
read -p "Enter starting roll number: " roll
read -p "Enter semester: " sem

# Set 1 as the default value for n
read -p "Enter how many roll numbers to process (default 1): " n
n=${n:-1}

read -p "Enter sleep time between requests (in seconds, default 0): " t
t=${t:-0}
read -p "Enter college code (default 08): " college

# Use default college code if not provided
college=${college:-08}

# Calculate the ending roll number
end=$((roll + n))

for ((i = roll; i < end; i++))
do
    f=$(pad_3digit_code $i)

    roll_no="30${college}${branch}${batch}${f}"
    year="${batch}"
    yearR=$((10#$year))
    year=$((yearR - 1))
    year=20
    if [ $((sem % 2)) -eq 0 ]; then
        yearR=$((yearR + sem/2))
        months="Apr-May"
    else
        yearR=$((yearR + (sem-1)/2))
        months="Nov-Dec"
    fi
    echo "$roll_no"
    if [ "$admit_result" == 'a' ]; then
        echo "Fetching Admit Card for Roll No: $roll_no"
        url="https://csvtu.digivarsity.online/WebApp/Examination/AdmitCard.aspx?RollNo=${roll_no}&ExamSession=${months}%20${year}${yearR}&Semester=${sem}%20SEMESTER"
    else
        echo "Fetching Result for Roll No: $roll_no"
        url="https://csvtu.digivarsity.online/WebApp/Result/SemesterResult.aspx?S=${sem}%20semester&E=${months}%20${year}${yearR}&R=${roll_no}&T=Regular"
    fi
    
    # Replace 'termux-open-url' with your appropriate command to open the URL in your environment.
    # For desktop, you can use 'xdg-open' or 'google-chrome', and for mobile, you can use 'termux-open-url'.
    # For this example, I'm using 'xdg-open' which works on most Linux systems.
    xdg-open "$url"
    sleep "$t"
done
