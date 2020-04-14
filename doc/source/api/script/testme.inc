**testme-sh**
--------------------------------------------------------------

Setup requirements - run tests, from root folder run: ./testme.sh.

Globals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  **PROJECT_PATH**

      Path to the project used as source. Defaults to current path.

  **PYTHON_EXEC**

      Python executable to use: python or python3. Empty by default.

  **INSTALL_REQUIREMENT**

      Install requirements or not. Defaults to false.

  **DOCKER**

      Run inside a Docker container. Defaults to false.

  **DOCKER_IMAGE**

      Docker image to use. Defaults to *debian:stable-slim*.

  **TYPE**

      String indicating to run only tests of specific types.
      The allowed values are:
      - a: Bare metal Ansible tests.
      - b: Bats tests.
      - m: Molecule tests.
      - p: Pytest tests.
      - t. Tox tests.
      - y: Poetry tests.
      The full string is: abmpty

  **BECOME_PASS**

      Become root password to pass to Ansible roles. Empty by default.

  **COVERAGE_REPORT**

      Wheter to generate or not a Python coverage report. Defaults to false.

  **RECURSIVE**

      When set to true, enter recursively on each directory on project's
      root folder and execute every *testme.sh* script found.
      Defaults to *false*.

  **CLOCK**

      Show time report on stdout when finished.

  **PYTEST_EXECUTED**

      Internal flag to prevent executing pytest two times when
      running Ansible tests.

Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   **ansible_exist()**

      Determines if Ansible bare metal tests exists.

      This function tries:
      - Search .yml files on $test_path.
      - Search .yaml files on $test_path.
      - Search for the library folder.
      - Search for the test_plugins folder.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         true if ansible tests exists, false otherwise.

      :Return type:
         boolean

   **ansible_run()**

      Execute ansible tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.
         **$2** (*str*) – Optional become password. Empty by default.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **ansible_setup()**

      Setup ansible tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **ansible_setup_python()**

      Create symbolyc links for Ansible modules and plugins.

      Link the directories:
      - ./library
      - ./test_plugins

      To the locations:
      - $test_path/library
      - $test_path/test_plugins

      Each .py file found under those directories will be compiled.

      :Parameters:
         **$1** (*str*) – Source directory (i.e.: $project_path/library).
         **$2** (*str*) – Destination directory (i.e.: $test_path).

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **bats_exist()**

      Determines if Bats tests exists.

      This function tries:
      - Search .bats files on $test_path.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         true if ansible tests exists, false otherwise.

      :Return type:
         boolean

   **bats_run()**

      Execute bats tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **bats_setup()**

      Setup bats tests.

      :Parameters:
         This functions has no parameters.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **create_parameter_string()**

     Create a parameters string to pass to each recursively
     call of the testme.sh script.

     - *g* (coverage report).
     - *i* (install requirements).
     - *k* (clock report).
     - *K* (become password for Ansible roles).
     - *t* <type> (only tests of type).
     - *x* <python executable>.

      :Parameters:
         **$@** (*str*) – Bash arguments.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
        string. Prints the created parameter string.

   **docker_setup()**

     Setups Docker.

      :Parameters:
         This functions has no parameters.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **error_message()**

     Shows an error message.

      :Parameters:
         **$1** (*str*) – Error name: custom, execution, path, sudo, <name>.
         **$2** (*str*) – Optional text to use on error messages.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **get_parameters()**

      Get bash parameters.

      Accepts:
       - *d* (docker).
       - *D* (docker image).
       - *g* (coverage report).
       - *h* (help).
       - *i* (install requirements).
       - *k* (clock).
       - *K* (become password for Ansible roles).
       - *p* <path> (project_path).
       - *r* (recursive).
       - *t* <types> (only tests of type).
       - *x* (python executable).

      :Parameters:
         **$@** (*str*) – Bash arguments.

      :Returns:
         0 if successful, 1 on failure. Set globals.

      :Return type:
        int

   **get_python_exec()**

      Obtains the Python executable to use: python or python3.

      This function tries:
        - Use the $PYTHON_EXEC variable if not empty and like 'python'.
        - Use 'python3' if available.
        - Use 'python' if available.

      :Parameters:
         No arguments.

      :Returns:
         0 if successful, 1 on failure, echo project's name.

      :Return type:
         int

   **get_test_path()**

      Obtains the project's test directory.

      This function tries:
        - Search for the */tests* directory.
        - Default to */test* directory.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure, echo project's name.

      :Return type:
         int. Prints test directory path on stdout.

   **help()**

      Shows help message.

      :Parameters:
         Function has no arguments.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
        int

   **install_apt()**

      Installs Apt packages.

      :Parameters:
         **$1** (*str*) – List of packages name to install, must be
                          space-separated.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **install_pip()**

      Installs Python packages via pip.

      This function ensures that Python, Pip and Setuptools are installed
      and then installs all required packages.

      You can pass to this function:
      - A filepath to a requirements*.txt file to be installed.
      - A filepath to directory containing requirements*.txt files to install.
      - A single package name.

      If this function is called without passing any argument to it,
      it will search for requirements*.txt files on the to current path.

      This function expects that each requirements filename has the text
      'requirements' included on it and to have the .txt extension.

      This functions will always check for Python, Pip and Setuptools to be
      installed and will try to install them if not present.

      Each package will be checked to see if its installed, if not installed
      then this function proceeds to install it.

      :Parameters:
         **$1** (*str*) – Optional file path or single package name.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **main()**

     Setup requirements and run tests.

      :Parameters:
         **$@** (*str*) – Bash arguments.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
        int

   **molecule_exist()**

      Determines if molecule tests exists.

      This function tries:
      - Search for the molecule directory on $project_path.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         *true* if molecule tests exists, *false* otherwise.

      :Return type:
        bool

   **molecule_run()**

      Execute molecule tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **molecule_setup()**

      Setup molecule tests.

      :Parameters:
         This functions has no parameters.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **poetry_exist()**

      Determines if Poetry tests exists.

      This function tries:
      - Search for the pyproject.toml file on $project_path.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         *true* if poetry tests exists, *false* otherwise.

      :Return type:
        bool

   **poetry_run()**

      Execute Poetry tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **poetry_setup()**

      Setup Poetry tests.

      :Parameters:
         This functions has no parameters.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **pytest_coverage()**

      Generates coverage report using pytest (bare metal).

      Creates a .coverage file and a htmlcov folder.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **pytest_exist()**

      Determines if pytest tests exists.

      This function tries:
      - Search python files on $test_path.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         *true* if python tests exists, *false* otherwise.

      :Return type:
        bool

   **pytest_run()**

      Execute pytest tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **pytest_setup()**

      Setup pytest tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **sanitize()**

      Sanitize input.

      The applied operations are:

        - Trim.
        - Remove unnecesary slashes.

      :Parameters:
         **$1** (*str*) – Text to sanitize.

      :Returns:
         The sanitized input.

      :Return type:
         str

   **show_time()**

      Shows the time the test took on stdout.

      This function uses the global variable PROJECT_PATH as the project
      folder whose time is being measured.

      If the PROJECT_PATH variable is no defined, the current path will
      be used as project path.

      :Parameters:
         **$1** (*str*) – Initial time, if no passed zero is displayed.

   **tox_exist()**

      Determines if tox tests exists.

      This function tries:
      - Search for the tox.ini file on $project_path.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         *true* if poetry tests exists, *false* otherwise.

      :Return type:
        bool

   **tox_run()**

      Execute tox tests.

      :Parameters:
         **$1** (*str*) – Optional path to project. Default to current path.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **tox_setup()**

      Setup tox tests.

      :Parameters:
         This functions has no parameters.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **trim()**

      Trim whitespace at the beggining and end of a string.

      :Parameters:
         **$1** (*str*) – Text where to apply trim.

      :Returns:
         The trimmed input.

      :Return type:
         str

   **uninstall_apt()**

      Uninstall packages via apt.

      The packages must be space-separated: 'gedit hello pencil3d'.      
      
      :Parameters:
         **$1** (*str*) – Pacakge name or list of packages to install.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **uninstall_pip()**

      Uninstalls Python packages via pip.

      This function ensures that Python, Pip and Setuptools are installed
      and then installs all required packages.

      You can pass to this function:
      - A filepath to a requirements*.txt file to be uninstalled.
      - A path to a directory containing requirements*.txt files to uninstall.
      - A single package name.

      If this function is called without passing any argument to it,
      it will search for requirements*.txt files on the current directory.

      This function expects that each requirements filename has the text
      'requirements' included on it.

      Each package will be checked to see if its installed, if installed
      then this function proceeds to uninstall it.
      
      :Parameters:
         **$1** (*str*) – Optional filepath, path to dir or single package name.

      :Returns:
         0 if successful, 1 on failure.

      :Return type:
         int

   **validate()**

      Apply validations.

      The validation categories are:
        - install: Verifies if the current user is capable of installed the given requirement.
        - sudo: Verifies if the current user can obtain administrative permissions.
        - package-name: Verifies if a specific package is installed via apt or pip.

      This function assumes that everything that is not one of the categories
      is a package name.

      :Parameters:
         **$1** (*str*) – A category or a package name.

      :Returns:
         true if valid, false otherwise.

      :Return type:
         str

   **validate_apt()**

      Determines if a package is installed via Apt.

      :Parameters:
         **$1** (*str*) – The package name.

      :Returns:
         true if installed via apt, false otherwise.

      :Return type:
         str

   **validate_pip()**

      Determines if a package is installed via pip.

      :Parameters:
         **$1** (*str*) – The package name.

      :Returns:
         true if installed via pip, false otherwise.

      :Return type:
         str

   **validate_pip_installed()**

      Verifies if pip is installed.

      :Parameters:
         No arguments.

      :Returns:
         true if installed, false otherwise.

      :Return type:
         str