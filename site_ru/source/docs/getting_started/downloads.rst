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

Emsdk варианты устновки 
-----------------------

В инструкции выше, мы использовали emsdk для установки и активации ``latest`` версии, которая является последней выпущенной версией. Чаще всего это то что вам нужно.

Однако, вы можете установить определенную версию указав её, например,

  ::

    ./emsdk install 1.38.45


.. note:: Когда устанавливаются версии выпущенные до выпуска актуальной системы сборки (версии старше ``1.38.33``), необходимо испозовать ``./emsdk install sdk-1.38.20-64bit`` (добавьте ``sdk-`` и ``-64bit``) таковы текущие соглашения по установке старых версий.

Вы можете выбирать между ``fastcomp`` и ``upstream`` реализацией (без явного указания будет использоваться реализация по умолчанию),

  ::

    # Использовать upstream 
    ./emsdk install latest-upstream

    # Использовать fastcomp 
    ./emsdk install 1.38.45-fastcomp


Кроме того, можно использовать "tip-of-tree" сборку, которая основана на самом последнем коде который прошел интеграционные тесты `Chromium CI <https://ci.chromium.org/p/emscripten-releases>`_. Она обновляется гораздо чаще чем выпуски версий, но может быть менее стабильной (`версии выпускаются вручную <https://github.com/emscripten-core/emscripten/blob/incoming/docs/process.md#minor-version-updates-1xy-to-1xy1>`_ и проверяются более тщательно). Такие сборки могут быть полезны при использовании непрерывной интеграции на базе emsdk (например, как Emscripten's GitHub CI), Вы так же можете захотеть использовать их в Вашем CI, таким образом, если вы обнаружите регрессию в Вашем проекте, то Вы можете сообщить об этом остановив выпуск текущей версии. Возможно, Вы захотите использовать эту сборку что бы проверить новую функцию, которая только появилась и ещё не была выпущена. Что бы использовать сборку "tip-of-tree" укажите ``tot`` в качестве цели,

  ::

    # Получить tip-of-tree upstream сборку.
    ./emsdk install tot-upstream

    # Получить tip-of-tree fastcomp сборку.
    ./emsdk install tot-fastcomp

(В примере выше устанавливается множество вариантов сборок; не забудьте так же ``активировать (activate)`` их, как в полном примере выше.)

.. _platform-notes-installation_instructions-SDK:

Платформо-зависимая информация
------------------------------

Windows
+++++++

#. Установите Python 2.7.12 или новее (старшие версии могут не работать из за `GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_).

  .. note:: Вместо того что бы запускать emscripten напрямую в Windows, Вы можете использовать Windows Subsystem for Linux для запуска его в Linux окружении.

macOS
+++++

Если вы используете MacOS 10.13.3 или старше, тогда Ваша версия Python должна подойти (более старые версии могут не работать из за `GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_). Иначе, установите Python 2.7.12 или новее.

Эти инструкции объясняют как установить **все** :ref:`необходимые инструменты <toolchain-what-you-need>`. Вы можете :ref:`проверить есть ли уже установленные инструменты <toolchain-test-which-dependencies-are-installed>` и пропустить соответствующие шаги.

#. Установите *Xcode Command Line Tools*. Это необходимо для *git*.

  -  Установите Xcode из `магазина приложений macOS <http://superuser.com/questions/455214/where-is-svn-on-os-x-mountain-lion>`_.
  -  В **Xcode | Preferences | Downloads**, установите *Command Line Tools*.

#. Установите *git*:

  - `Убедитесь что ОС позволяет установить git <https://support.apple.com/en-gb/HT202491>`_.
  - Установите Xcode и Xcode Command Line Tools (см. пункт выше). Таким образом *git* будет добавлен в PATH системы (см. `stackoverflow <http://stackoverflow.com/questions/9329243/xcode-4-4-command-line-tools>`_).
  - Скачайте и установите напрямую с http://git-scm.com/.

#. Установите *cmake*:

  -  Скачайте и установите последний CMake с `Kitware CMake downloads <http://www.cmake.org/download/>`_.

  .. _getting-started-on-macos-install-python2:

Linux
++++++++

.. note:: *Emsdk* не устанавливает новых инструментов в систему, и не взаимодествует с поакетными менеджерами Linux. Вместо этого все изменения происходя в директории **emsdk/**.

- *Python*, *CMake*, и *Java* не предоставляются *emsdk*. Пользователь должен установить их самостоятельно с помощью **пакетного менеджера системы**:

  ::

    # Установить Python
    sudo apt-get install python2.7

    # Установить CMake (не обязательно, необходимо для тестирования и сборки Binaryen)
    sudo apt-get install cmake

    # Установите Java (не обязательно, необходимо для использования Closure Compiler)
    sudo apt-get install default-jre

.. note:: Вам нужен Python 2.7.12 или новее, потому что более старые весрии могут не работаь из за `GitHub change with SSL <https://github.com/emscripten-core/emscripten/issues/6275>`_).

.. note:: Если вы хотите использовать систменую весрию Node.js вместо версии из emsdk, то вам нужно задать ``NODE_JS`` атрибут в файле ``~/.emscripten`` указывающим на системную версию. 

- *Git* не устанавливается автоматически. Git нужен только в случае если вы хотите использовать инструменты из разрабатываемых веток **emscripten-incoming** или **emscripten-master**:

  ::

    # Установить git
    sudo apt-get install git-core


Проверка установленной версии
=============================

Самый простой способ проверить установленную версию, - скомпилировать код с Emscripten.

Вы можете перейти в раздел :ref:`Tutorial`, но если у вас возникнут какие-то проблемы или трудности, то следует запустить базовые тесты и прочесть решение проблем в :ref:`verifying-the-emscripten-environment`.


.. _updating-the-emscripten-sdk:

Обновление SDK
==============

.. tip:: Устанавилвать SDK необходио единожды! После этого Вы можете обновлять версию SDK в любой момент:ref:`Emscripten SDK (emsdk) <emsdk>`.

Используйте следующие команды ::

  # Получить реестр доступных инструментов.
  ./emsdk update

  # Скачать и устновить последние инструменты SDK.
  ./emsdk install latest

  # Установить конфигурацию компилятора на "latest" SDK.
  ./emsdk activate latest

  # Изменить переменные окружения и PATH в текущем терминале.
  source ./emsdk_env.sh

Пакетный менеджер может делать множество других задач от загрузки указанных старых версий, до установки :ref:`инструментов из репозитория GitHub <emsdk-master-or-incoming-sdk>` (или даже из вашего форка). Узнайте больше из раздела :ref:`emsdk_howto`.

.. _downloads-uninstall-the-sdk:

Удаление инструментов Emscripten SDK
====================================

Если вы хотите удалить полностью SDK, просто удалите директорию его содержащею.

Так же можно :ref:`удалить определенную утилиту в составе SDK <emsdk-remove-tool-sdk>`.
