
def salas(sala,filas, lugares_fila):
    for y in range(1,filas+1):
        for x in range(1,lugares_fila+1):
            print("INSERT INTO Lugar (sala,fila,numero,VIP) values (" + str(sala) + "," + str(y) + "," + str(x) + ", 0);"  )

salas(8,15,18);
