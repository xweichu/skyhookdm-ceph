set -e

pool=$1
nobjs=$2
nthreads=$3
nruns=$4
cls=$5
echo "usage: ./qf.sh <pool> <nobjs> <nthreads> <nruns> [--use-cls]"
echo "--pool=$pool"
echo "--num-objs=$nobjs"
echo "--nthreads=$nthreads"
echo "--nruns=$nruns"
echo "--use-cls=$cls"
#
## ========
# QUERY: f
# regex text search
# ========
#
# selectivity 100810/1000000 = 10%
# select * from lineitem1m where l_comment ilike '%uriously%';
q="run-query --num-objs $nobjs --pool $pool --nthreads $nthreads --query f --comment_regex uriously --quiet $cls"
for i in `seq 1 $nruns`;
do
    echo $q
    t1=`date --utc "+%s.%N"`
    $q
    t2=`date --utc "+%s.%N"`
    res=0$(echo "$t2 - $t1"|bc);
    echo "qf selectivity=10% pool=$pool nthreads=$nthreads cls=$cls run$i=$res"
done
#

