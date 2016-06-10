import math

def hz2mel(hzval):
    val = hzval/700
    melval = 1127.01028 * (math.log(1+val))
    return melval

