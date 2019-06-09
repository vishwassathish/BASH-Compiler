#!/bin/bash

echo $(( 2 + 2 ))

a = 10

if (( $(( $(( $a + 10 )) > $(( 5 + $a )) )) || $(( $(( 5 + 110 )) > $(( 5 + 125 )) )) ))
	then echo $((2 + 2))
	else if (( $(( $(( 10 + 10 )) > $(( 25 + 15 )) )) ))
	then echo $((7 + 7))
	else echo $((4 * 8))
fi

for i in ` seq 1 2 10 `
	do echo $((2 * 7))
done

while (( $(( $(( 5 + 10 )) > $(( 5 + 15 )) )) ))
	do echo $((2 + 2))
done

b = 5