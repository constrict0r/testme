If you want to use a virtual enviroment install follow the next steps:

- Ensure **virtualenviroment** is installed:

 .. code-block:: bash

  python3 -m pip install virtualenv

- Create a virtual enviroment for your project:

 .. code-block:: bash

  python3 -m virtualenv /home/username/my-project

- Activate the virtual enviroment:

 .. code-block:: bash

  source /home/username/my-project/bin/activate

- Run the tests:

 .. code-block:: bash

  ./testme.sh

- Deactivate the virtual enviroment when you are finish:

 .. code-block:: bash

  deactivate