MNIST_NAME=( cifar10 ); PARTIAL_LIST=( $(seq 1.00000 0.00100 1.00000) $(seq 0.00050 0.00050 0.00450) $(seq 0.00500 0.00500 0.04500) $(seq 0.05000 0.05000 0.45000) )
MNIST_NAME=( cifar10lt ); PARTIAL_LIST=( $(seq 1.00000 0.00100 1.00000) $(seq 0.00200 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( bloodmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00100 1.00000) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( breastmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00500 0.00500 0.09500) $(seq 0.10000 0.05000 0.95000) )
MNIST_NAME=( dermamnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( octmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00010 0.00005 0.00095) $(seq 0.00100 0.00050 0.00950) $(seq 0.01000 0.00500 0.09500) $(seq 0.10000 0.05000 0.95000) )
MNIST_NAME=( organamnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00050 0.00010 0.00090) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( organcmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( organsmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( pathmnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00015 0.00005 0.00095) $(seq 0.00100 0.00050 0.00950) $(seq 0.01000 0.00500 0.09500) $(seq 0.10000 0.05000 0.95000) )
MNIST_NAME=( pneumoniamnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00100 0.00100 0.00900) $(seq 0.01000 0.01000 0.09000) $(seq 0.10000 0.10000 0.90000) )
MNIST_NAME=( tissuemnist ); PARTIAL_LIST=( $(seq 1.00000 0.00005 1.00000) $(seq 0.00010 0.00005 0.00095) $(seq 0.00100 0.00050 0.00950) $(seq 0.01000 0.00500 0.09500) $(seq 0.10000 0.05000 0.95000) )

ACTIVE_ARRAY=( uncertainty bald consistency coreset margin vaal easy hard gt_easy gt_hard )

for init in imagenet; do for run in {1..10}; do for task in "${MNIST_NAME[@]}"; do for act in "${ACTIVE_ARRAY[@]}"; do for partial in "${PARTIAL_LIST[@]}"; do while true; do if [ $(myjobs | wc -l) -lt 999 ]; then if [ ! -f logs/$task-$run-p$partial-$act.out ]; then sbatch --error=logs/$task-$run-p$partial-$act.out --output=logs/$task-$run-p$partial-$act.out hg.sh $run $task $partial $init $act; echo "logs/$task-$run-p$partial-$act.out"; break; else line="$(tail -n 1 logs/$task-$run-p$partial-$act.out)"; if [[ "$line" != *"AVERAGE"* ]] && [[ "$line" != *"reraise"* ]] && [[ "$line" != *"Sample larger than population"* ]]; then sbatch --error=logs/$task-$run-p$partial-$act.out --output=logs/$task-$run-p$partial-$act.out hg.sh $run $task $partial $init $act; echo "logs/$task-$run-p$partial-$act.out"; break; else break; fi; fi; fi; sleep 10s; done; done; done; done; done; done
