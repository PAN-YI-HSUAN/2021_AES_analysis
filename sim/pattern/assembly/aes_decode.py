d = { 'x0':0,'ra':1, 'sp':2,'gp':3,'tp':4,'t0':5,'t1':6,'t2':7,'s0':8,'s1':9,'a0':10,'a1':11,'a2':12,'a3':13,'a4':14,'a5':15,'a6':16,'a7':17,'s2':18,'s3':19,'s4':20,'s5':21,'s6':22,'s7':23,'s8':24,'s9':25,'s10':26,'s11':27,'t3':28,'t4':29,'t5':30,'t6':31}

f1 = open("aes_dencsm.s", "r")
f2 = open("inst", "r")
wf1 = open("aes_test_chan.s", "w")
wf2 = open("inst_RV32I_3.txt", "w")
lines = f1.readlines()
aes_inst = []

for line in lines:
    tmp = line.split()
    if (len(tmp)>0) and (tmp[0] == 'saes32_encsm'):
        rd = str(format(d[tmp[1][0:-1]],"b"))
        rs1 = str(format(d[tmp[2][0:-1]],"b"))
        rs2 = str(format(d[tmp[3][0:-1]],"b"))
        fn = str(format(int(tmp[4]),"b"))
        inst = "00000"+fn.zfill(2)+rs2.zfill(5)+rs1.zfill(5)+"000"+rd.zfill(5)+"0001011"
        inst_x = str(format(int(inst, 2),"x")).zfill(8)
        aes_inst.append(inst_x)
        wf1.write("    add     x0,     x0,     x0\n")

    elif (len(tmp)>0) and (tmp[0] == 'saes32_encs'):
        #print(tmp)
        rd = str(format(d[tmp[1][0:-1]],"b"))
        rs1 = str(format(d[tmp[2][0:-1]],"b"))
        rs2 = str(format(d[tmp[3][0:-1]],"b"))
        fn = str(format(int(tmp[4]),"b"))
        inst = "00001"+fn.zfill(2)+rs2.zfill(5)+rs1.zfill(5)+"000"+rd.zfill(5)+"0001011"
        inst_x = str(format(int(inst, 2),"x")).zfill(8)
        aes_inst.append(inst_x)
        wf1.write("    add     x0,     x0,     x0\n")
    elif (len(tmp)>0) and (tmp[0] == 'saes32_decsm'):
        rd = str(format(d[tmp[1][0:-1]],"b"))
        rs1 = str(format(d[tmp[2][0:-1]],"b"))
        rs2 = str(format(d[tmp[3][0:-1]],"b"))
        fn = str(format(int(tmp[4]),"b"))
        inst = "00010"+fn.zfill(2)+rs2.zfill(5)+rs1.zfill(5)+"000"+rd.zfill(5)+"0001011"
        inst_x = str(format(int(inst, 2),"x")).zfill(8)
        aes_inst.append(inst_x)
        wf1.write("    add     x0,     x0,     x0\n")
    elif (len(tmp)>0) and (tmp[0] == 'saes32_decs'):
        rd = str(format(d[tmp[1][0:-1]],"b"))
        rs1 = str(format(d[tmp[2][0:-1]],"b"))
        rs2 = str(format(d[tmp[3][0:-1]],"b"))
        fn = str(format(int(tmp[4]),"b"))
        inst = "00011"+fn.zfill(2)+rs2.zfill(5)+rs1.zfill(5)+"000"+rd.zfill(5)+"0001011"
        inst_x = str(format(int(inst, 2),"x")).zfill(8)
        aes_inst.append(inst_x)
        wf1.write("    add     x0,     x0,     x0\n")
    else:
        wf1.write(line)

print(aes_inst)
f1.close()
wf1.close()

lines = f2.readlines()
pos = 0
for line in lines:
    if (line == '0x00000033\n'):
        wf2.write(aes_inst[pos]+'\n')
        pos += 1
    else:
        wf2.write(line[2:])
f2.close()
wf2.close()
