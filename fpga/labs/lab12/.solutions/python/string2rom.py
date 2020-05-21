#
# Example Python script to automatically generate ASCII hex values
# for all characters in a certain string. 
#
# Luca Pacher - pacher@to.infn.it
# Spring 2020
#

message = "Apologize for the bad lecture audio quality yesterday, sorry !!!"

f = open("ROM.hex", "w")

k = 0

for c in message :
	k = k + 1
	hexCode = hex(ord(c))[2:]
	f.write("%s\n" % hexCode)
	print("mem[%2d] = 8'h%s" % (k,hexCode))

print("\n\nROM depth must be at least %d\n\n" % (k))

f.close()
