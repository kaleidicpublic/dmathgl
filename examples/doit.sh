dmd simplesubplot.d ../source/kaleidic/api/mathgl/*.d -I../source -L-lmgl
rm -rf test.png
./simplesubplot
display test.png

