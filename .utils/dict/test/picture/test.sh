for file in *.JPG *.jpeg
do mv -- "$file" "${file%.*}.jpg"
done
#

