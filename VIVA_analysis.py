import os, csv, re
regex = "((\w{9}))"
csv_out = csv.writer(open('out.csv', 'w', newline=''), delimiter=',')#regex = "*.dat"

x = []
y = []

for r,d,f in os.walk("."):
    for files in f:        
        if re.match(regex, files) is not None:            
            if files.endswith('.trv'):
                l = open(os.path.join(r,files))
                lines = l.readlines()[5:] #gets rid of header notes
                for stuff in lines:
                    item = stuff.split(' ')
                    y.append(item[18])
                    #y.append(item[9])
                test = y
                #print(test)    
                #tester = y.index(test[1])
                #print(tester)
                y = []


#make a dictionary of the .trv files so I have an index and value. When I'm appending the final file, append the values

for r,d,f in os.walk("."):
    for files in f:        
        if re.match(regex, files) is not None:            
            if files.endswith('.dat'):
                #print(files)
                o = open(os.path.join(r,files))
                lines2 = o.readlines()[5:] #gets rid of header notes
                k = 0                 
                for line in lines2:                    
                    vals = line.split(' ')
                    count = len(vals)                    
                    for i in range(0,count):
                        #print(vals[i])
                        x.append(vals[i])
                    test2 = x                    
                    #print(test2)                               
                #    if vals[i] != float(599.983):
                #put if statement here (if filename is hte same and column X has a 1.. append some premade dictionary or array)
                #    for k in range(0,len(test)):
                    #tester = 
                    compare = (test2[6]).strip()
                    #print(compare) 
                    if compare == str(1):
                        print("hello")
                        x.append(test[k])
                        csv_out.writerows([x])                                             
                        k = k + 1                       
                    else:
                        #print("goodbye")
                        x.append("NaN")
                        csv_out.writerows([x])
                    o.close()
                    x = []                                                                   

                    
