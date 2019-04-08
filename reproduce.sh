echo 1 > test.json

for i in {1..10}
do
ab -T 'application/json' -H 'accept: application/json' -n 1000 -c 1  -p test.json http://127.0.0.1:3000/echo 2>&1 | grep "across"
done
