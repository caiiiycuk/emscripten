.. _about-emscripten:

============
О Emscripten
============

Emscripten это компилятор LLVM в JavaScript с :ref:`открытым исходным кодом <emscripten-license>`. Он позволяет:

- Компилировать C и C++ код в JavaScript
- Компилировать любой другой код который может быть транслирован в LLVM байт код в JavaScript.
- Компилировать C/C++ **среду выполнения** других языков в JavaScript, и затем *косвенно* запускать код на этих языках (это было сделано для Python и Lua)! 

.. tip:: Emscripten делает нативный код немедленно доступным в Web: платформу которая стандартизированна, имеет несколько независисых реализаций, и работает везде на PC и iPad.

  Вместе с Emscripten, C/C++ разработчики получают возможность бытсро портировать проект в JavaScript, вместо того что бы писать проект с нуля на новом языке (JavaScript). Web разработчики тоже получают преимущества, теперь разработчики могут использовать сотни существующих нативных билиотек и утилит.

На практике любая **переносимая** кодовая база C или С++ может быть скомпилирована в JavaScript с использованием Emscripten, от высоко производительных игр, воспроизводящих графику и звук, вплоть до полноценных фреймворков как Qt. С помощью Emscripten преобразовано `множество проектов <https://github.com/emscripten-core/emscripten/wiki/Porting-Examples-and-Demos>`_ в JavaScript, включая очень большие проекты как *CPython*, `Poppler <https://github.com/coolwanglu/emscripten/tree/master/tests/poppler#readme>`_ и `Bullet Physics Engine <http://kripken.github.io/ammo.js/examples/new/ammo.html>`_, коммерческие проекты `Unreal Engine 4 <https://blog.mozilla.org/blog/2014/03/12/mozilla-and-epic-preview-unreal-engine-4-running-in-firefox/>`_ и `Unity <http://www.unity3d.com>`_. Например, два проекта на базе Unity:

.. figure:: angrybots.png
  :alt: Angrybots game logo
  :target: http://beta.unity3d.com/jonas/AngryBots/
  :align: left

.. figure:: DEAD-TRIGGER-2-Icon1.png
  :alt: Dead Trigger 2 Game logo
  :target: http://beta.unity3d.com/jonas/DT2/
  :align: left

.. raw:: html

  <div style="clear:both;"></div>

Ссылки на другие проекты `смотри в wiki <https://github.com/emscripten-core/emscripten/wiki/Porting-Examples-and-Demos>`_.

Emscripten генерирует быстрый код. По умолчанию генерируется WebAssembly или `asm.js <http://asmjs.org>`_. WebAssembly новый форма исполнения кода в Web, он исполняется со скоростью близкой к нативной (`текущие результаты тестов производительности <http://arewefastyet.com/#machine=11&view=breakdown&suite=asmjs-ubench>`_ или запустите :ref:`тесты <benchmarking>` самостоятельно). Оптимизированный код так же имеет близкий размер к нативному коду (при использовании gzip сжатия).

Для лучшего понимания на сколько быстр может быть код Emscripten, запустите `Dead Trigger 2 <http://beta.unity3d.com/jonas/DT2/>`_ или `Angrybots <http://beta.unity3d.com/jonas/AngryBots/>`_.

.. _about-emscripten-toolchain:

Инструментарий Emscripten
=========================

Обобщенный взгляд на инструментарий Emscripten приведен ниже. Основная утилита :ref:`emccdoc`. Это полная замена стандартного компилятора типа *gcc*.

.. image:: EmscriptenToolchain.png

*Emcc* использует :term:`Clang` и LLVM для компиляции в wasm или asm.js. Emscripten производит JavaScript который способен запустить скомпилированный код и предоставляет необходимую среду выполнения. Этот JavaScript может быть выполнен в :term:`node.js`, или внутри HTML в браузере.

:ref:`emsdk` используется для управления несколькими SDK и инструментами, и для указания определенной версии SDK/набора инструментов используемых для компиляции кода (:term:`Active Tool/SDK`). В том числе он может установить (скачать и построить) последний инструментарий с GitHub!

*Emsdk* записывает "активную" конфигурацию в :ref:`compiler-configuration-file`. Этот файл используется *emcc* для определения текущего инструментария для сборки.

Несколько других пока не задокументированы, например, Java может быть использована *emcc* для запуска :term:`closure compiler`, который может ещё больше уменьшить размер файла.

Полный инструментарий поставляется в составе :ref:`Emscripten SDK <sdk-download-and-install>`, и может быть использован в Linux, Windows or macOS.

.. _about-emscripten-porting-code:

Подготовка кода к портированию с  Emscripten
============================================

Emscripten поддерживает **переносимый** C/C++ код. Поддерживаются: стандартная библиотека C и С++, С++ исключения, и пр. Поддержка `SDL <https://www.libsdl.org/>`_ достаточная для запуска большинства проектов. Отличная поддержка :ref:`OpenGL-support` для OpenGL ES 2.0, и приемлемая для других версий.

Есть несколько различий между нативным и :ref:`emscripten-runtime-environment` окружением, что предполагает что некоторый изменения нужно внести в нативный код. Для большинства приложений достаточно лишь изменить способ организации основного цикла программы, и :ref:`работы с файлами <file-system-overview>` что бы соответствовать ограничениям браузера/JavaSCript.


Если придерживаться некоторых правил ref:`code-portability-guidelines`, то можно значительно упросить процесс портирования.


