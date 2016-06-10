import math

def mel2hz(melval):
    hzval =[]
    for val in melval:
        calculation = 700*(math.exp(val/1127.01028)-1)
        hzval.append(calculation)
    return hzval

