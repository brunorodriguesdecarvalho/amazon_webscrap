import json, csv

with open('search_results_output.jsonl', 'r') as json_file:
    json_list = list(json_file)

pre_resultado={}
resultado = ()
pos_resultado = []

for json_str in json_list:
    pre_resultado = json.loads(json_str)
    #print("resultado: {}".format(pre_resultado))
    #print("preco: {}".format(pre_resultado['title']))
    #print("preco: {}".format(pre_resultado['price']))
    resultado = (pre_resultado['title'], pre_resultado['price'])
    pos_resultado.append(resultado)

#print(pos_resultado)

data_file = open('data_file.csv', 'w')
csv_writer = csv.writer(data_file)
count = 0

for x in pos_resultado:   
    # Writing data of CSV file 
    csv_writer.writerow(x) 
  
data_file.close() 



