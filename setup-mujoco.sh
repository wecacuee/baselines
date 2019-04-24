MJPATH=$HOME/.mujoco/mjpro150/bin
prependonce LD_LIBRARY_PATH $MJPATH
prependonce LD_LIBRARY_PATH $(ls -d /usr/lib/nvidia-???/ | sort -r)
if [[ ! -f "/usr/bin/patchelf" ]]; then
    sudo apt install patchelf
fi
if [[ ! -f "/usr/lib/x86_64-linux-gnu/libGLEW.so" ]]; then
    sudo apt install libglew-dev
fi
# Install mujoco in a machine specific directory
MUJOCOPIPDIR=$PIPDIR/$(hostname)
mkdir -p $MUJOCOPIPDIR
MPYPATH=$MUJOCOPIPDIR/lib/python3.6/site-packages/
prependonce PYTHONPATH "$MPYPATH"
prependonce PATH "$MUJOCOPIPDIR/bin"
prependonce LD_PRELOAD "/usr/lib/x86_64-linux-gnu/libGLEW.so"

#PYTHONUSERBASE=$MUJOCOPIPDIR pip install --user --upgrade mujoco-py==1.50.1.1
if [ ! -d $PIPDIR/src/mujoco-py ]; then
    mkdir -p $PIPDIR/src && \
        git clone --depth 1 --branch 1.50.1.1 https://github.com/openai/mujoco-py.git $PIPDIR/src/mujoco-py
fi

if [ -f ${THISDIR}/setup-mujoco-private.sh ]; then
    . ${THISDIR}/setup-mujoco-private.sh
fi

PYTHONUSERBASE=$PIPDIR pip install --user -e $PIPDIR/src/mujoco-py


