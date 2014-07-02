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
                reversal = y
                y = []

for r,d,f in os.walk("."):
    for files in f:        
        if re.match(regex, files) is not None:            
            if files.endswith('.dat'):
                o = open(os.path.join(r,files))
                lines2 = o.readlines()[5:] #gets rid of header notes
                k = 0                 
                for line in lines2:                    
                    vals = line.split(' ')
                    count = len(vals)                    
                    for i in range(0,count):
                        x.append(vals[i])
                    spontaneous = x
                    compare = (spontaneous[6]).strip()
                    if compare == str(1):
                        x.append(reversal[k])
                        csv_out.writerows([x])                                             
                        k = k + 1                       
                    else:
                        #print("goodbye")
                        x.append("NaN")
                        csv_out.writerows([x])
                    o.close()
                    x = []                                                                   

                    
