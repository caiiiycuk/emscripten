.. _Tutorial:

========
Обучение
========

**Использовать Emscripten на базов уровне достаточно просто. Это обучение расскажет о необходимых шагах для компиляции первого проекта из комнадной строки. Кроме того, объяснит как работать с файлами и использовать оптимизационные флаги компиляции.**

Первым делом
============

Убедитесь что вы :ref:`скачали и установили <sdk-download-and-install>` Emscripten (способ установки зависит от операционной системы: Linux, Windows, or Mac).

Emscripten доступен с использованием :ref:`emccdoc`. Этот скрипт запускает все другие утилиты необходимые для сборки вашего кода, и функционирует как прямая замена стандартного компилятора *gcc* или *clang*. Его можно вызвать используя команды ``./emcc`` или ``./em++``.

.. note:: В Windows используется другой синтаксис ``emcc`` или ``em++``. Остаток этого обучния использует Linux команды(``./emcc``).

В следующей главе вам потребуется открыть консоль:

- В  Linux или macOS, используйте *Terminal*.
- В Windows запустите :ref:`Emscripten Command Prompt <emcmdprompt>`, этот терминал уже настроен на использование :term:`активного <Active Tool/SDK>` инструментария Emscripten. Для получение доступа к терминалу, наберите **Emscripten** в стартовом экране Windows 8, и выберите **Emscripten Command Prompt**.

Откройте директорию emscripten внутри SDK. Эта директория находится в корневой директории emsdk (:term:`emsdk root directory`), обычно **<emsdk root directory>/fastcomp/emscripten/** (для "fastcomp" реализации; для новой реализации upstream - **<emsdk root directory>/upstream/emscripten/**). Примеры ниже, будут использовать файлы относительно этой директории.

.. note:: В старых версиях emscripten стурктура каталогов другая: появляется номер версии, и исчезает реализация (fastcomp/upstream), т.е. каталог будет **<emsdk root directory>/emscripten/1.20.0/**.

Проверка установленной версии
=============================

Если вы не делали это ранее, запустите: ::

    ./emcc -v

Вывод может содержать предупреждения об отсутствии некоторых инструментов, см. :ref:`verifying-the-emscripten-environment` за помощью. Иначе, можете переходить к следующей секции, для сборки проекта.


Запуск Emscripten
=================

Теперь вы можете скомпилировать первый C/C++ файл в JavaScript.

Сперва, изучим файл который будет скомпилирован: **hello_world.c**. Это простейший тест в SDK, как вы можете видеть он всего лишь печатает "hello, world!" в консоль.

.. include:: ../../../../tests/hello_world.c
   :literal:


Что бы собрать JavaScript версию этого кода, просто укажите C/C++ файл после команды *emcc* (используйте *em++* что бы принудить компилировать C++): ::

  ./emcc tests/hello_world.c


Должна произойти генерация двух файлов: **a.out.js** и **a.out.wasm**. Второй это WebAssembly файл содержащий скомпилированный код. Первый файл предназначен для загрузки и выполнения WebAssembly кода. Вы можете запустить его  с помощью :term:`node.js`:

::

    node a.out.js

В консоле должно отобразится "hello, world!", как и ожидалось.

.. note:: Более старые версии node.js не имеют поддержки WebAssembly. В этом случае вы увидите подсказку рекомендующую выполнить сборку с флагом ``-s WASM=`` что бы выключить поддержку WebAssembly. В этом случае emscripten будет генерировать JavaScript код. Обычно, WebAssemlby лучший выбор, он имеет общирную поддержку браузеров, гораздо произовдительнее и генерирует файлы меньшего размера (поэтому emscripten использует его по умолчанию), но иногда может потребоваться запустить ваш код в окуржении не поддержвающем WebAssembly.

.. tip:: Если возникает ошибка в момент вызова *emcc*, запустите его с флагом ``-v`` для вывода более подробной информации.

.. note:: В этом разделе и далее, мы используем некоторые файлы из директории ``test/``. Этот каталог содержит файлы из тестового набора Emscripten. Некоторые могут быть использованы самостоятельно, другие с использованием утилиты тестирования, см. :ref:`emscripten-test-suite` для подробной информации. 



Генерация HTML
==============

Emscripten так же может генерировать HTML для тестирования. Для генерации HTML, используйте флаг ``-o`` (:ref:`output <emcc-o-target>`) и укажите имя целевого файла: ::

    ./emcc tests/hello_world.c -o hello.html

Теперь вы можете открыть ``hello.html`` в браузере.

.. note:: К сожалению некоторые барузеры (включая *Chrome*, *Safari*, и *Internet Explorer*) не поддерживает ``file://`` в :term:`XHR` запросах, и не могут загрузить дополнительные файлы необходимые для HTML (например, ``.wasm`` или упакованные данные, как объясняется ниже). Для таких барузеров Вам потребуется запустить веб сервер для отдачи этих файлов. Простейший способ использовать **SimpleHTTPServer** (в текущей директории выполните ``python -m SimpleHTTPServer 8080`` и откройте ``http://localhost:8080/hello.html``).

Когда HTML будет загружен в браузер, вы увидите текстовое поле отображающее вызов ``printf()`` из нативного кода.

HTML вывод не ограничен выводом только текста. Вы можете использовать SDL API для отображения разноцветного куба внутри ``<canvas>`` элемента (в браузерах которые поддерживают его). Соберите `hello_world_sdl.cpp <https://github.com/emscripten-core/emscripten/blob/master/tests/hello_world_sdl.cpp>`_ тест и обновите браузер: ::

    ./emcc tests/hello_world_sdl.cpp -o hello.html

Исходный код второго примера приведен ниже:

.. include:: ../../../../tests/hello_world_sdl.cpp
   :literal:


.. _tutorial-files:

Using files
===========

.. note:: Your C/C++ code can access files using the normal libc stdio API (``fopen``, ``fclose``, etc.)

JavaScript is usually run in the sandboxed environment of a web browser, without direct access to the local file system. Emscripten simulates a file system that you can access from your compiled C/C++ code using the normal libc stdio API.

Files that you want to access should be :ref:`preloaded <emcc-preload-file>` or :ref:`embedded <emcc-embed-file>` into the virtual file system. Preloading (or embedding) generates a virtual file system that corresponds to the file system structure at *compile* time, *relative to the current directory*.


The `hello_world_file.cpp <https://github.com/emscripten-core/emscripten/blob/master/tests/hello_world_file.cpp>`_ example shows how to load a file (both the test code and the file to be loaded shown below):

.. include:: ../../../../tests/hello_world_file.cpp
   :literal:

.. include:: ../../../../tests/hello_world_file.txt
   :literal:

.. note:: The example expects to be able to load a file located at **tests/hello_world_file.txt**: ::

    FILE *file = fopen("tests/hello_world_file.txt", "rb");

  We compile the example from the directory "above" **tests** to ensure that virtual filesystem is created with the correct structure relative to the compile-time directory.

The following command is used to specify a data file to :ref:`preload <emcc-preload-file>` into Emscripten's virtual file system — before running any compiled code. This approach is useful because Browsers can only load data from the network asynchronously (except in Web Workers) while a lot of native code uses synchronous file system access. Preloading ensures that the asynchronous download of data files is complete (and the file is available) before compiled code has the opportunity to access the Emscripten file system.

::

    ./emcc tests/hello_world_file.cpp -o hello.html --preload-file tests/hello_world_file.txt


Run the above command, then open **hello.html** in a web browser to see the data from **hello_world_file.txt** being displayed.

For more information about working with the file system see the :ref:`file-system-overview`, :ref:`Filesystem-API` and :ref:`Synchronous-virtual-XHR-backed-file-system-usage`.


Optimizing code
===============

Emscripten, like *gcc* and *clang*, generates unoptimized code by default. You can generate :ref:`slightly-optimized <emcc-O1>` code with the ``-O1`` command line argument: ::

    ./emcc -O1 tests/hello_world.cpp

The "hello world" code created in **a.out.js** doesn't really need to be optimized, so you won't see a difference in speed when compared to the unoptimized version.

However, you can compare the generated code to see the differences. ``-O1`` applies several minor optimizations and removes some runtime assertions. For example, ``printf`` will have been replaced by ``puts`` in the generated code.

The optimizations provided by ``-O2`` (see :ref:`here <emcc-O2>`) are much more aggressive. If you run the following command and inspect the generated code (**a.out.js**) you will see that it looks very different: ::

    ./emcc -O2 tests/hello_world.cpp

For more information about compiler optimization options see :ref:`Optimizing-Code` and the :ref:`emcc tool reference <emcc-compiler-optimization-options>`.


.. _running-emscripten-tests:

Emscripten Test Suite and Benchmarks
====================================

Emscripten has a comprehensive test suite, which covers virtually all Emscripten functionality. These tests are an excellent resource for developers as they provide practical examples of most features, and are known to build successfully on the master branch.

See :ref:`emscripten-test-suite` for more information.


General tips and next steps
===========================

This tutorial walked you through your first steps in calling Emscripten from the command line. There is, of course, far more you can do with the tool. Below are other general tips for using Emscripten:

- This site has lots more information about :ref:`compiling and building projects <compiling-and-running-projects-index>`, :ref:`integrating your native code with the web environment <integrating-porting-index>`, :ref:`packaging your code <packaging-code-index>` and publishing.
- The Emscripten test suite is a great place to look for examples of how to use Emscripten. For example, if you want to better understand how the *emcc* ``--pre-js`` option works, search for ``--pre-js`` in the test suite: the test suite is extensive and there are likely to be at least some examples.
- To learn how to use Emscripten in advanced ways, read :ref:`src/settings.js <settings-js>` and :ref:`emcc <emccdoc>` which describe the compiler options, and :ref:`emscripten-h` for details on JavaScript-specific C APIs that your C/C++ programs can use when compiled with Emscripten.
- Read the :ref:`FAQ`.
- When in doubt, :ref:`get in touch <contact>`!
