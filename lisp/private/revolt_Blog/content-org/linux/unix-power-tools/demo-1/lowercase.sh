for i in `ls`;                                                                                                                    
# mv -i          prompt before overwriteing                                                                                       
do mv -i $i `echo $i | tr 'A-Z' 'a-z'`;                                                                                           
done
