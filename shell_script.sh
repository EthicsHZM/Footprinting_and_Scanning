#!/usr/bin/bash
  echo "+----------------------------------------------------------------------------------+"
  printf "| %-80s |\n" "                        `date`"
  printf "| %-80s |\n"
  printf "| %-80s |\n" "                           Author : HAZEM ABU ADAIQ"
  printf "| %-80s |\n"
  printf "| %-80s |\n" "                  Email Address: Steganographyplus@gmail.com"
  printf "| %-80s |\n"
  printf "| %-80s |\n" "This script will extract all links from the provided web page address, and" 
  printf "| %-80s |\n" "then checks whether those web servers are alive or NOT"
  echo "|                                                                                  |"
  printf "|`tput bold` %-80s `tput sgr0`|\n" "$@"
  echo "+----------------------------------------------------------------------------------+"

# Ask the user for Website address

read -p 'Type your Target Website Address Here :' address;

wget --quiet  $address -O downld_file;

grep --colour=always  '<a href="http' downld_file | cut -d '/' -f 3 | grep -P '^.[^.]+\.[a-zA-Z0-9]*\.[a-zA-Z0-9]*$|^.[^.]+\.[a-zA-Z0-9]*'|uniq  > dns_names

for i in $(cat dns_names);
do host $i;
done | grep --colour=always -w "has address"  | cut -d ' ' -f 4 | uniq  > list_of_IPs;
nmap -sn -n -iL list_of_IPs;
