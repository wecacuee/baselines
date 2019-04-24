export PROJECT_NAME=floyd-warshall-rl/openai-baselines

THISFILE="${BASH_SOURCE[0]}"
if [[ -z "$THISFILE" ]]; then
    THISDIR=$(pwd)
else
    THISDIR=$(dirname $(readlink -m $THISFILE))
fi

# Prepend a path to environment variable only once
prependonce() {
    envname="$1";
    ppath="${2}";
    if [ ! -e "$ppath" ]; then
        echo "No such file/directory $ppath"
        return
    fi
    if [[ ":${!envname}:" != "*:$ppath:*" ]]; then
        eval ${envname}="${ppath}:${!envname}"
    fi
}

if [ -f /etc/profile.d/modules.sh ]; then
    . /etc/profile.d/modules.sh
    module use /z/home/dhiman/wrk/common/modulefiles/
    module load miniconda3 cuda/9.0 cudnn/9.0-v7.1.2 gflags/2.2.1 tensorflow/py3.6/1.9.0
fi

export MID_DIR=/z/home/dhiman/mid/
#PIPDIR=$MID_DIR/$PROJECT_NAME/build
PIPDIR=$THISDIR/build
mkdir -p $PIPDIR
PYPATH=$PIPDIR/lib/python3.6/site-packages/
mkdir -p "$PYPATH"
prependonce PYTHONPATH "$PYPATH"
mkdir -p "$PYPATH/bin"
prependonce PATH "$PIPDIR/bin"
. ${THISDIR}/setup-mujoco.sh

if [[ "$1" == "ENV" ]]; then
    prependonce PYTHONPATH "$THISDIR"
else
    PYTHONUSERBASE=$PIPDIR pip install --user --upgrade -e $THISDIR[test]
fi
