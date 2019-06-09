import pandas
pandas.set_option('display.max_rows', 500)

dct = {}

while True:
	try:
		line = input()
		if line[0] != '\t':
			currentHeader = line.strip()
			dct[currentHeader] = []
		else:
			dct[currentHeader] += [line.strip().split(' ')]
	except:
		break


max_length = max([len(dct[key]) for key in dct])
for key in dct:
	dct[key] = dct[key] + (['']*(max_length - len(dct[key])))

df = pandas.DataFrame.from_dict(dct)
print(df)