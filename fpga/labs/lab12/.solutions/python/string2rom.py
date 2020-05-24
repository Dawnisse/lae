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

print("// Verilog code starts here")
print("initial begin")

for c in message :
	k = k + 1
	hexCode = hex(ord(c))[2:]
	f.write("%s\n" % hexCode)
	print("   mem[%2d] = 8'h%s ;" % (k,hexCode))

print("end")
print("// Verilog code ends here")


print("\n\nROM depth must be at least %d-slots deep.\n\n" % (k))

f.close()
