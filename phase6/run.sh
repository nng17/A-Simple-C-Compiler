#/bin/bash

echo "phase 6 test cases"
echo "left my output, right the expected output"
echo ""

echo "Testing calc"
./scc < examples/calc.c > sfiles/calc.s 2> /dev/null
gcc -m32 sfiles/calc.s
./a.out < examples/calc.in > outputs/calc.txt
output=$(diff outputs/calc.txt examples/calc.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing fib"
./scc < examples/fib.c > sfiles/fib.s 2> /dev/null
gcc -m32 sfiles/fib.s
./a.out < examples/fib.in > outputs/fib.txt
output=$(diff outputs/fib.txt examples/fib.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing global"
./scc < examples/global.c > sfiles/global.s 2> /dev/null
gcc -m32 sfiles/global.s
./a.out < examples/global.in > outputs/global.txt
output=$(diff outputs/global.txt examples/global.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing hello"
./scc < examples/hello.c > sfiles/hello.s 2> /dev/null
gcc -m32 sfiles/hello.s
./a.out < examples/hello.in > outputs/hello.txt
output=$(diff outputs/hello.txt examples/hello.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing int"
./scc < examples/int.c > sfiles/int.s 2> /dev/null
gcc -m32 sfiles/int.s
./a.out < examples/int.in > outputs/int.txt
output=$(diff outputs/int.txt examples/int.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing matrix"
./scc < examples/matrix.c > sfiles/matrix.s 2> /dev/null
gcc -m32 sfiles/matrix.s
./a.out < examples/matrix.in > outputs/matrix.txt
output=$(diff outputs/matrix.txt examples/matrix.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing qsort"
./scc < examples/qsort.c > sfiles/qsort.s 2> /dev/null
gcc -m32 sfiles/qsort.s
./a.out < examples/qsort.in > outputs/qsort.txt
output=$(diff outputs/qsort.txt examples/qsort.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""

echo "Testing tree"
./scc < examples/tree.c > sfiles/tree.s 2> /dev/null
gcc -m32 sfiles/tree.s
./a.out < examples/tree.in > outputs/tree.txt
output=$(diff outputs/tree.txt examples/tree.out)
if  [ "$output" != "" ]
then
	echo "$output"
else
	echo "success"
fi
echo ""
