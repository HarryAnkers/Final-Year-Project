x = muladd((33//34),(3),(0.5938))
print(x)
print('\n')

tmpLog = open(string("/Users/harrisonankers/Documents/UNI/Year 4/FYP/Src/test_files/bug_files/log_files/log",(ARGS[1]),".txt"), "w")
write(tmpLog, string(x,"\n"))
close(tmpLog)
