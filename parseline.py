import re
import json
f=open("full.text1.txt","r")
f_temp = open("newfile2.txt", "w")

#Computations on the newfile.txt
file_contents=f.read()
f.seek(0)
#print(file_contents)
new_file_contents= re.sub("^.\\d-\\d", "-seperation-\\n", file_contents)
#print(new_file_contents)
f_temp.write(new_file_contents)
f_temp.close()





outfile= open("full.text1.csv","w")





pattern=["\d\d\d\d Initiated .*","Call Taker: .*","Location/Address:","Unit:\s\d\d","Vehicle:.+","Race:\s\w\sSex:\s\w","Operator: .+"]


def check_for_patterns(line,operator=True):
    
    if len(re.findall(pattern[0],line))!=0:
        result=line.split(" Initiated ")
        return [0]+result
    elif len(re.findall(pattern[1],line))!=0:
        result = line.split("Call Taker:")[1:]
        return [1]+result
    elif len(re.findall(pattern[2],line))!=0:
        result=line.split("Location/Address:")[1:]
        return [2]+result
    elif len(re.findall(pattern[3],line))!=0:
        result=line.split("Unit:")[1:]
        return [3]+result
    elif len(re.findall(pattern[4],line))!=0:
        result=line.split("Vehicle:")[1:]
        return [4]+result
    elif len(re.findall(pattern[5],line))!=0:
        new_line=str(re.findall(pattern[5],line))[1:-1]
        #print(new_line)
        result=new_line.split(" ")
        if(operator):
            return [5]+[result[1]]+[result[3]]
        else:
            return [7]+[result[1]]+[result[3]]
    elif len(re.findall(pattern[6],line))!=0:
        result=line.split("Operator:")[1:]
        operator=False
        return [6]+result
    return []

def string_maker(list):
    string=""
    for element in list:
        string+=str(element)+","
    return string[:-1]
        

toggle=0
file_list=[]
temp_list=[]

for line in f:
    print("going here")

    line=line[:-1]
    if line == "-seperation-":
        file_list.append(temp_list)
        temp_list=[]
    else:
        temp_list.append(line)
    print(line)

file_list.append(temp_list)
for call_details in file_list:
    extracted_detail=[]
    for line in call_details:
        extracted_detail.append(check_for_patterns(line))
    operator=True

    final_string=""
    for i in range(7):
        for item in extracted_detail:
            if(len(item)>0 and item[0]==i):
                final_string+=string_maker(item[1:])
                break
        final_string+=","

    outfile.write(final_string+"\n")

    
        

###
#with open('first_page.json', 'w') as outfile:
#    json.dump(file_list, outfile, indent=4)

## Iterating over file_list on different call numbers
