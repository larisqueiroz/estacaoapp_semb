from firebase import firebase
import random
import time

FBConn = firebase.FirebaseApplication('https://sembtrainee.firebaseio.com/', None)
count = 0
lista = []
op = 0

sensores = FBConn.get('/sembtrainee', None)
print(sensores)
def leituras(tipo, nome, key, status):
    if tipo == "digital" or tipo == "Digital":
        status1 = status
        if status1 == 'on':
            count = 1
            num1 = round(random.randint(20,25))
            result1 = FBConn.post(f'/sembtrainee/{key}/Leitura', str(num1))
            if count != 0:
                result_novo1 = FBConn.put(f'/sembtrainee/{key}/', 'Leitura', str(num1))
            print(f'dados {tipo} postados, sensor {nome}')
            #print(key)

    if tipo == "analógico" or tipo == "analogico" or tipo == "Analógico" or tipo == "Analogico":
        status2 = status
        if status2 == 'on':
            count = 1
            num2 = round(random.randint(500, 1024))
            result2 = FBConn.post(f'/sembtrainee/{key}/Leitura', str(num2))
            if count != 0:
                result_novo2 = FBConn.put(f'/sembtrainee/{key}/', 'Leitura', str(num2))
            print(f'dados {tipo} postados, sensor {nome}')
            #print(key)

    print('_________________________')

while True:
    sensores = FBConn.get('/sembtrainee', None)
    for key, item in sensores.items():
        k = key
        tipo = item['Tipo']
        nome = item['Nome']
        status = item['Status']
        leituras(tipo,nome, k, status)
        time.sleep(1)
