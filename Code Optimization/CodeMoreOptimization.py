while True:
	try:
		line = input()
		lst = line.strip().split(' ')
		if lst[0] != 'ifFalse':
			print(line)
			continue
		if lst[1] == "True":
			continue
		while True:
			try:
				line = input()
				if line.strip() == (lst[-1]+":"):
					break
			except:
				exit()
		print(line)
	except:
		exit()