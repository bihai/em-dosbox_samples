color 14
dim as string s= "Hello BASIC!!!"
dim as integer i
randomize timer
for i= 1 to len(s)
	color rnd *15+1
	print mid(s,i,1);
next i
