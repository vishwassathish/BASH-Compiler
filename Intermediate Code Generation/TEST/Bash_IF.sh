#!/bin/bash

#$(( $(( 5 + 10 )) > $(( 5 + 15 )) ))

#if (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) )); then echo $((2 + 2)); fi;

# if (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) )); then echo $((2 + 2)); else echo $((4 * 1)); fi;

# if (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) )); then echo $((2 + 2)); else if (( $(( $(( 10 + 10 )) > $(( 25 + 15 )) )) )); then echo $((7 + 7)); else echo $((4 * 8)); fi;

# if (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) || $(( $(( 5 + 110 )) > $(( 5 + 125 )) ))  )); then echo $((2 + 2)); else if (( $(( $(( 10 + 10 )) > $(( 25 + 15 )) )) )); then echo $((7 + 7)); else echo $((4 * 8)); fi;

if (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) || $(( $(( 5 + 110 )) > $(( 5 + 125 )) )) ))
	then echo $((2 + 2))
	else if (( $(( $(( 10 + 10 )) > $(( 25 + 15 )) )) ))
	then echo $((7 + 7))
	else echo $((4 * 8))
fi;