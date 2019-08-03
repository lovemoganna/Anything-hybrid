import os

f = open("Label.txt",'a') #读取label.txt文件，没有则创建，‘a’表示再次写入时不覆盖之前的内容
for i in range(29):
    f.write("hi")
    f.write('\n')
