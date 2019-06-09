table = {}

f = []
while True:
	try:
		f.append(input())
	except:
		break

for line in f:
	if("=" in line):
		lst = [x.strip() for x in line.split(" = ")]
		lst1 = lst[1].split(" ")
		#a = 1
		if(lst1[0].isnumeric() and len(lst1) == 1 and (lst[0].isalpha())):
			table[lst[0]] = int(lst1[0])
			print(lst[0], "=", table[lst[0]])
			#print(table)
		
		#i = t1
		elif((lst[0] not in table) and (lst[0].isalpha()) and (not lst1[0].isnumeric()) and (lst1[0] in table) ):
			table[lst[0]] = table[lst1[0]]
			del table[lst1[0]]
		
		#t2 = t1 
		elif(len(lst1) == 1 and (not lst1[0].isnumeric()) and (lst1[0] in table) and (not lst[0].isnumeric()) and (lst[0] not in table) ):
			table[lst[0]] = table[lst1[0]]
			del table[lst1[0]]
			#print(table)

		# t1 = a + 5
		elif(lst1[0].isalpha and len(lst1) > 1 and lst1[0] in table and lst1[2].isnumeric() ):
			value = table[lst1[0]]
			lst[1] = str(value) + " " + lst1[1] + " " + lst1[2]
			table[lst[0]] = eval(lst[1])
			print(lst[0] ,"=", table[lst[0]])
			#print(table)
		
		# t1 = 5 + a
		elif(len(lst1) > 1 and lst1[2].isalpha and lst1[2] in table and lst1[0].isnumeric()):
			value = table[lst1[2]]
			lst[1] = lst1[0] + lst1[1] + str(value)
			table[lst[0]] = eval(lst[1])
			print(lst[0] ,"=", table[lst[0]])
			#print(table)

		#t1 = 2 + 2
		elif(lst1[0].isnumeric() and lst1[2].isnumeric()):
			table[lst[0]] = eval(lst[1])
			print(lst[0] ,"=", table[lst[0]])
			#print(table)

		

		#t3 = t1 + t2
		elif((not lst1[0].isnumeric()) and len(lst1) > 1 and (not (lst1[2].isnumeric())) and (lst1[0] in table) and (lst1[2] in table)):
			value1 = table[lst1[0]]
			value2 = table[lst1[2]]
			if(lst1[1] == "&&"):
				lst[1] = str(value1) + " and " + str(value2)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif(lst1[1] == "||"):
				lst[1] = str(value1) + " or " + str(value2)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif("<" in lst1[1] or ">" in lst1[1] or "<=" in lst1[1] or ">=" in lst1[1] or "==" in lst1[1]):
				lst[1] = str(value1) + " " + lst1[1] + " " + str(value2)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			else:
				lst[1] = str(value1) + " " + lst1[1] + " " + str(value2)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			#print(table)

		# t5 = t1 + 5
		elif((not lst1[0].isnumeric()) and len(lst1) > 1 and (lst1[2].isnumeric()) and (lst1[0] in table)):
			value = table[lst1[0]]
			if(lst1[1] == "&&" ):
				lst[1] = str(value) + " and " + lst1[2]
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif(lst1[1] == "||"):
				lst[1] = str(value) + " or " + lst1[2]
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif("<" in lst1[1] or ">" in lst1[1] or "<=" in lst1[1] or ">=" in lst1[1] or "==" in lst1[1]):
				lst[1] = str(value) + " " + lst1[1] + " " + lst1[2]
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			else:
				lst[1] = str(value) + " " + lst1[1] + " " + lst1[2]
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			#print(table)

		# t5 = 5 + t1
		elif(len(lst1) > 1 and (not lst1[2].isnumeric()) and (lst1[0].isnumeric()) and (lst1[2] in table)):
			value = table[lst1[2]]
			if("&&" in lst1[1] ):
				lst[1] = lst1[0] + " and "+ str(value)  
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif("||" in lst1[1]):
				lst[1] = lst1[0] + " or "+ str(value)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			elif("<" in lst1[1] or ">" in lst1[1] or "<=" in lst1[1] or ">=" in lst1[1] or "==" in lst1[1]):
				lst[1] = lst1[0] + lst1[1] + str(value)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			else:
				lst[1] = lst1[0] + lst1[1] + str(value)
				table[lst[0]] = eval(lst[1])
				print(lst[0] ,"=", table[lst[0]])
			#print(table)
		
	elif("if" in line):
		lst = line.split(" ")
		value = table[lst[1]]
		output = str(lst[0]) + " " + str(value) + " " + " ".join(lst[2:])
		print(output)
	elif("print" in line):
		print (line)
	elif("goto" in line):
		print(line)
	elif("L" in line[0]):
		print(line)