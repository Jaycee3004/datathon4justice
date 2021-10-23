import re
f = open("firstpage.txt", "r")

toggle=0
file_list=[]
temp_list=[]
for line in f:
    line=line[:-1]
    if line == "-seperation-":
        file_list.append(temp_list)
        temp_list=[]
    else:
        temp_list.append(line)
    #print(line)

file_list.append(temp_list)

for element in file_list:
    print("start report")
    for i in range(len(element)):
        print("Line "+str(i)+" "+ element[i])

    print("end report")