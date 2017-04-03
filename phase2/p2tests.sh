
for element in array fib hello malloc params sum; do
	./scc < examples/$element.c > p2tests/$element.out
	if [$(diff "p2tests/$element.out" "examples/$element.out") == ""] 
	then
		echo "Success on $element"
	else
		echo "Failure on $element"  
	fi
done

