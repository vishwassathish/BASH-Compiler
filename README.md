# Compiler-For-Bash

What is bash?
Bash is a shell scripting language or command language interpreter, for the GNU operating system. Just like a script of a play which tells the actors what to do this tells the computer what to do. Shell Script is series of command written in plain text file. Shell script is just like batch file is MS-DOS but have more power than the MS-DOS batch file. Anything you can run normally on the command line can be put into a script and it will do exactly the same thing. Similarly, anything you can put into a script can also be run normally on the command line and it will do exactly the same thing. Bash is largely compatible with sh and incorporates useful features from the Korn shell ksh and the C shell csh. While the GNU operating system provides other shells, including a version of csh, Bash is the default shell.

Language Syntax and Semantics

Assignment
To assign values to variables in bash we do not need to specify a data type. We can simply assign a number character or an string to a variable. We do not even need to declare a variable. Simply assigning a value to its reference will create it.
STR="Hello World!"
The above statement assigns the string “Hello World!” to the variable STR. Although assignment to a variable can be done without any operator, to use the value of the variable, we need to use a dereferencing operator ‘$’.
echo $STR
The above statement will print “Hello World!” onto the output screen. If we say echo STR without the dereferencing operator it will not work.

Expression
There are several types of expressions in any language. All of them have different purposes. Some of the types of expressions we deal with are relational and arithmetic. Arithmetic expressions are mainly used to evaluate results using operators. The 6 arithmetic operators we consider are ‘+’, ‘-’, ‘*’, ‘/’, ‘^’ and ‘=’. All the arithmetic operators are used to evaluate the expressions except for the ‘=’ operator which is used to assign the values to its right hand side to the variable on its left hand side. The arithmetic operators have an order of priorities in which they get executed. And to take care of this very reason we cannot cover them under the same variable in our yacc file. Just like arithmetic expressions we have the relational operators. These operators are mainly used in conditional statements and looping constructs. They return a boolean value. There are 6 relational operators we are taking care of. They are ‘<’, ‘>’, ‘<=’, ‘>=’, ‘!=’ and ‘==’. All of them serve their respective purposes.

Conditional Statements
Conditional statements can have many forms. The most basic form is: if expression then statement where 'statement' is only executed if 'expression' evaluates to true. Conditionals have other forms such as: if expression then statement1 else statement2. Here 'statement1' is executed if 'expression' is true,otherwise 'statement2' is executed. Yet another form of conditionals is: if expression1 then statement1 else if expression2 then statement2 else statement3. In this form there's added only the "ELSE IF 'expression2' THEN 'statement2'" which makes statement2 being executed if expression2 evaluates to true. And if neither is true then the else part is executed. After is any number of else if statements can be added until else but all of them must have their specific expressions to check for correctness.

First type of Conditional Statements:-

	if (( "foo" == "foo" )); then
        echo expression evaluated as true
    fi

Second Type of Conditional Statements:-

	if (( "foo" == "foo" )); then
        echo expression evaluated as true
    else
        echo expression evaluated as false
    fi

Third Type of Conditional Statements:-

	if (( "foo" == "foo" )); then
        echo expression evaluated as true
    else if (( “” = ”” )); then
        echo expression evaluated as true
    else
        echo expression if all others are evaluated as false
    fi

Looping

Two types of loops implemented by us for bash are for and while. The for loop is a little bit different from other programming languages.Basically, it let's you iterate over a series of 'words' within a string. The while executes a piece of code if the control expression is true, and only stops when it is false or an explicit break is found within the executed code.
There are two ways of implementing loops one similar to python and one to C. An example of python type for loops:-
	for i in $( x ); do
        echo item: $i
    done
This would print all the values contained in ‘x’. An example of C type for loops:-
	for i in `seq 1 10`;
    do
        echo $i
    done
This would print values from 1 to 10 in order. An example of while loops:-
	COUNTER=0
    while [  $COUNTER -lt 10 ]; do
        echo The counter is $COUNTER
        let COUNTER=COUNTER+1 
    done
This would print values from 0 to 9. The statements between the loop starting and done can be increased according to the users requirements and desires.

Approach to Symbol Table, AST, ICG and Code optimisation

Symbol table

A symbol table is an implementation of a data structure used by a compiler or interpreter, where each lexeme (symbol) in a program's source code is associated with information relating to its declaration or appearance in the code. The table is used to store various entities such as variable names, function names, objects, classes, interfaces, etc. There are various uses of a symbol table such as:-
To store the names of all entities in a structured form at one place.
1) To verify if a variable has been declared.
2) To implement type checking, by verifying assignments and expressions in the source code are semantically correct.
3) To determine the scope of a lexeme.
The basic functions of a symbol table are inserting and check (cross-referencing if a new lexeme has been encountered or has it been seen before).
Different symbol tables have different ways to be implemented. The method we use is to form a linked list of linked lists. The reason for use of such a data structure is because it saves space and is easy to traverse through.

Abstract Syntax Tree

Our code produces an AST in 2 parts. First it runs through the code and produce a .json format output and finally inputs the .json format file into a python code to receive an AST. The code is propagated to the very first production of the yacc file in a bottom up fashion. The output that we receive is in the .json format which our python code accepts as input and produces a very well formed Tree.

Intermediate Code Generation

We are generating our intermediate code in the 3-address format, which goes with the notation that there can be only 3 addresses that can be accessed in an instruction, with only 1 operand and 1 assignment possible. We have implemented this in our parser itself (YACC). We have implemented in an eager manner, which would generate the required code when an instruction requires execution rather than the lazy manner of taking the whole code to the top of the parse tree and then producing the code. We make use of L-attributed semantic grammars, whose non terminals rely on values of its left siblings. This enables easy passage of data from one part of the code to another. What is being passed on upwards, by being assigned to the top of stack, is the string containing either the new temporary created during evaluation of a statement, or a new label created during a branch statement.

Code Optimization

There are multiple forms of code optimisations the forms we use are Constant folding and constant propagation. Constant folding is the process of recognizing and evaluating constant expressions at compile time rather than computing them at runtime. Sometimes constant propagation is also applied to expressions. Some examples of Constant folding:-
    i=10*20 would directly be counted as i=200.
    Code such as “what”+”else” will be replaced by “whatelse”
Constant propagation is the process of replacing the values of the variables that we already know. Like x=3; y=x+4 will be replaced by y=3+4;
Sometimes the optimisation is even more effective when constant folding and constant propagation are applied together, making the code much faster.

Instructions for execution : ./bashc Bash_TEST.sh



