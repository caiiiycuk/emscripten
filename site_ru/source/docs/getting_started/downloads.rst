.. _sdk-download-and-install:

====================
Загрузка и установка
====================

.. note:: Вы можете так же :ref:`собрать Emscripten из исходников<installing-from-source>`, если вы предпочитаете это бинарным сборкам из emsdk. 

.. note:: Есть несколько дополнительных путей установки Emscripten, отличных от приведенных ниже.
    Например с использованием brew на MacOS, пакетного менеджера linux, или c помощью Docker. 
    Тем не менее, emsdk единственный оффициально поддерживаем способ использования Emscripten, 
    и только он подвережен постоянному тестированию (
    `emsdk CI <https://github.com/emscripten-core/emsdk/blob/master/.circleci/config.yml>`_,
    `Emscripten GitHub CI <https://github.com/emscripten-core/emscripten/blob/master/.circleci/config.yml>`_,
    `Chromium CI <https://ci.chromium.org/p/emscripten-releases>`_). (Пока мы оффициально не поддерживаем
    другие способы получения Emscripten, мы определенно благодарны сторонним разработчикам
    `пакетов Emscripten <https://github.com/emscripten-core/emscripten/blob/incoming/docs/process.md#packaging-emscripten>`_
    и мы готовы помогать, пожалуйста будьте на связи если вы собираете пакет Emscripten!)

.. _sdk-installation-instructions:

Установка
=========

Прежде всего прочтите :ref:`Платформо-зависимую информацию <platform-notes-installation_instructions-SDK>` ниже и установите необходимые библиотеки.

Ядро Emscripten SDK (emsdk) это Python скрипт. Вы можете получить его с помощью

  ::

    # Получить emsdk репозиторий 
    git clone https://github.com/emscripten-core/emsdk.git

    # Перейти в директорию 
    cd emsdk

.. note:: Вы так же можете получить emsdk не используя git, используя кнопку "Clone or download => Download ZIP" на `странице emsdk GitHub <https://github.com/emscripten-core/emsdk>`_.

Выполните следующие команды :ref:`emsdk <emsdk>` что бы загрузить последний инструментарий и установить его в качестве :term:`активного <Active Tool/SDK>`:

  ::

    # Загрузить последнию версию emsdk (не нужно если вы только что склонировали репозиторий)
    git pull

    # Скачать и установить последний инструментарий SDK.
    ./emsdk install latest

    # Make the "latest" SDK "active" for the current user. (writes ~/.emscripten file)
    # Установить "последний" SDK как "активный" для текущего пользователя (записывает ~/.emscripten файл)
    ./emsdk activate latest

    # Активирует переменные окружения PATH и длруги для текущего теримнала
    source ./emsdk_env.sh

  .. note:: На Windows, используйте ``emsdk`` вместо ``./emsdk``, и ``emsdk_env.bat`` вместо ``source ./emsdk_env.sh``.

  .. note:: ``git pull`` загрузит текущий список версий, но самые свежие версии могут отствовать. Вы можете запустить ``./emsdk update-tags`` что бы обновить список версий напрямую. 

Если вы измените место нахождения SDK (например, возьмете с собой на другой компьютер на флэш накопителе), перезапустите команды ``./emsdk activate latest`` и ``source ./emsdk_env.sh``. 

Emsdk install targets
---------------------

In the description above we asked the emsdk to install and activate ``latest``, which is the latest tagged release. That is often what you want.

You can also install a specific version by specifying it, for example,

  ::

    ./emsdk install 1.38.45


.. note:: When installing old versions from before the build infrastructure rewrite (anything before ``1.38.33``), you need to write something like ``./emsdk install sdk-1.38.20-64bit`` (add ``sdk-`` and ``-64bit``) as that was the naming convention at the time.

You can also specify which backend you want to use, either ``fastcomp`` or ``upstream`` (without specifying the backend, the current default is used), for example,

  ::

    # Get a specific version using the upstream backend.
    ./emsdk install latest-upstream

    # Get a specific version using the fastcomp backend.
    ./emsdk install 1.38.45-fastcomp


There are also "tip-of-tree builds", which are the very latest code that passes integration tests on `Chromium CI <https://ci.chromium.org/p/emscripten-releases>`_. This is updated much more frequently than tagged releases, but may be less stable (we `tag releases manually <https://github.com/emscripten-core/emscripten/blob/incoming/docs/process.md#minor-version-updates-1xy-to-1xy1>`_ using a more careful procedure). Tip-of-tree builds may be useful for continuous integration that uses the emsdk (as Emscripten's GitHub CI does), and you may want to use it in your own CI as well, so that if you find a regression on your project you can report it and prevent it from reaching a tagged release. Tip-of-builds may also be useful if you want to test a feature that just landed but didn't reach a release yet. To use a tip-of-tree build, use the ``tot`` target, and note that you must specify the backend explicitly,

  ::

    # Get a tip-of-tree using the upstream backend.
    ./emsdk install tot-upstream

    # Get a tip-of-tree using the fastcomp backend.
    ./emsdk install tot-fastcomp

(In the above examples we installed the various targets; remember to also ``activate`` them as in the full example from earlier.)

.. _platform-notes-installation_instructions-SDK:

Platform-specific notes
----------------------------

Windows
+++++++

#. Install Python 2.7.12 or newer (older versions may not work due to `a GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_).

  .. note:: Instead of running emscripten on Windows directly, you can use the Windows Subsystem for Linux to run it in a Linux environment.

macOS
+++++

If you use MacOS 10.13.3 or later then you should have a new enough version of Python installed (older versions may not work due to `a GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_). Otherwise you can manually install and use Python 2.7.12 or newer.

These instructions explain how to install **all** the :ref:`required tools <toolchain-what-you-need>`. You can :ref:`test whether some of these are already installed <toolchain-test-which-dependencies-are-installed>` on the platform and skip those steps.

#. Install the *Xcode Command Line Tools*. These are a precondition for *git*.

  -  Install Xcode from the `macOS App Store <http://superuser.com/questions/455214/where-is-svn-on-os-x-mountain-lion>`_.
  -  In **Xcode | Preferences | Downloads**, install *Command Line Tools*.

#. Install *git*:

  - `Make sure the OS allows installing git <https://support.apple.com/en-gb/HT202491>`_.
  - Install Xcode and the Xcode Command Line Tools (should already have been done). This will provide *git* to the system PATH (see `this stackoverflow post <http://stackoverflow.com/questions/9329243/xcode-4-4-command-line-tools>`_).
  - Download and install git directly from http://git-scm.com/.

#. Install *cmake* if you do not have it yet:

  -  Download and install latest CMake from `Kitware CMake downloads <http://www.cmake.org/download/>`_.

  .. _getting-started-on-macos-install-python2:

Linux
++++++++

.. note:: *Emsdk* does not install any tools to the system, or otherwise interact with Linux package managers. All file changes are done inside the **emsdk/** directory.

- *Python*, *CMake*, and *Java* are not provided by *emsdk*. The user is expected to install these beforehand with the *system package manager*:

  ::

    # Install Python
    sudo apt-get install python2.7

    # Install CMake (optional, only needed for tests and building Binaryen)
    sudo apt-get install cmake

    # Install Java (optional, only needed for Closure Compiler minification)
    sudo apt-get install default-jre

.. note:: You need Python 2.7.12 or newer because older versions may not work due to `a GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_).

.. note:: If you want to use your system's Node.js instead of the emsdk's, it may be ``node`` instead of ``nodejs``, and you can adjust the ``NODE_JS`` attribute of your ``~/.emscripten`` file to point to it.

- *Git* is not installed automatically. Git is only needed if you want to use tools from one of the development branches **emscripten-incoming** or **emscripten-master**:

  ::

    # Install git
    sudo apt-get install git-core


Verifying the installation
==========================

The easiest way to verify the installation is to compile some code using Emscripten.

You can jump ahead to the :ref:`Tutorial`, but if you have any problems building you should run through the basic tests and troubleshooting instructions in :ref:`verifying-the-emscripten-environment`.


.. _updating-the-emscripten-sdk:

Updating the SDK
================

.. tip:: You only need to install the SDK once! After that you can update to the latest SDK at any time using :ref:`Emscripten SDK (emsdk) <emsdk>`.

Type the following in a command prompt ::

  # Fetch the latest registry of available tools.
  ./emsdk update

  # Download and install the latest SDK tools.
  ./emsdk install latest

  # Set up the compiler configuration to point to the "latest" SDK.
  ./emsdk activate latest

  # Activate PATH and other environment variables in the current terminal
  source ./emsdk_env.sh

The package manager can do many other maintenance tasks ranging from fetching specific old versions of the SDK through to using the :ref:`versions of the tools on GitHub <emsdk-master-or-incoming-sdk>` (or even your own fork). Check out all the possibilities in the :ref:`emsdk_howto`.

.. _downloads-uninstall-the-sdk:

Uninstalling the Emscripten SDK
========================================================

If you want to remove the whole SDK, just delete the directory containing the SDK.

It is also possible to :ref:`remove specific tools in the SDK using emsdk <emsdk-remove-tool-sdk>`.
