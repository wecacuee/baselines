from setuptools import setup, find_packages
from functools import reduce
import sys

if sys.version_info.major != 3:
    print('This Python is only compatible with Python 3, but you are running '
          'Python {}. The installation will likely fail.'.format(sys.version_info.major))


extras = {
    'test': [
        'filelock', 
        'pytest'
    ]
}


all_deps = []
for group_name in extras:
    all_deps += extras[group_name]

extras['all'] = all_deps

setup(name='baselines',
      packages=[package for package in find_packages()
                if package.startswith('baselines')],
      install_requires=[
          'gym[mujoco,atari,classic_control,robotics]==0.10.5',
          'scipy',
          'tqdm==4.26.0',
          'joblib==0.12.5',
          'dill==0.2.8.2',
          'progressbar2==3.38.0',
          'mpi4py==3.0.0',
          'cloudpickle==0.5.6',
          'tensorflow==1.10.1',
          'click==6.7',
          'opencv-python==3.4.3.18'
      ],
      extras_require=extras,
      description='OpenAI baselines: high quality implementations of reinforcement learning algorithms',
      author='OpenAI',
      url='https://github.com/openai/baselines',
      author_email='gym@openai.com',
      version='0.1.5')
