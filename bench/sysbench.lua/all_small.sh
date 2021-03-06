ntabs=$1
nrows=$2
readsecs=$3
writesecs=$4
insertsecs=$5
engine=$6
setup=$7
cleanup=$8
client=$9
tableoptions=${10}
sysbdir=${11}

concurrency="1 2 4"

echo update-index
bash run.sh $ntabs $nrows $writesecs $engine $setup 0        update-index    100    $client $tableoptions $sysbdir $concurrency

echo update-nonindex
bash run.sh $ntabs $nrows $writesecs $engine 0      0        update-nonindex 100    $client $tableoptions $sysbdir $concurrency

echo delete
bash run.sh $ntabs $nrows $writesecs $engine 0      0        delete          100    $client $tableoptions $sysbdir $concurrency

echo write-only
bash run.sh $ntabs $nrows $writesecs $engine 0      0        write-only      100    $client $tableoptions $sysbdir $concurrency

echo read-write 100
bash run.sh $ntabs $nrows $writesecs $engine 0      0        read-write      100    $client $tableoptions $sysbdir $concurrency

echo read-write 10000
bash run.sh $ntabs $nrows $writesecs $engine 0      0        read-write    10000    $client $tableoptions $sysbdir $concurrency

for range in 10 100 1000 10000 ; do
echo read-only range $range
bash run.sh $ntabs $nrows $readsecs  $engine 0      0        read-only       $range $client $tableoptions $sysbdir $concurrency
done

echo point-query
bash run.sh $ntabs $nrows $readsecs  $engine 0      0        point-query     100    $client $tableoptions $sysbdir $concurrency

echo insert
bash run.sh $ntabs $nrows $insertsecs $engine 0     $cleanup insert          100    $client $tableoptions $sysbdir $concurrency
