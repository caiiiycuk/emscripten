:orphan:

.. _documentation-home:

=======================
Документация Emscripten 
=======================
 
Данная документация содержит все необходимые сведения об Emscripten.
 
**Введение:**

- :ref:`introducting-emscripten-index` объясняет как Emscripten используется, почему он нужен, его ограничения и данные о лицензии. Эта глава поможет понять нужен ли вам Emscripten.
- :ref:`getting-started-index` установка и использование Emscripten SDK. 
 
**Основы Emscripten:**
 
- :ref:`integrating-porting-index` демонстрирует основные различия между нативным окружением и Emscripten, так же объясняет изменения которые нужно внести в C/C++ код для Web. 
- :ref:`Optimizing-Code` рекомендации по оптимизации кода для уменьшения размера и увеличения производительности. 
- :ref:`Optimizing-WebGL` оптимизация производительности WebGL. 
- :ref:`compiling-and-running-projects-index` способы интеграции Emscripten в существующие сборочные системы. 

**Внести свой вклад:**

- :ref:`contributing-to-emscripten-index` объясняет как внести свой вклад в проект. 
- :ref:`installing-from-source` способы сборки Emscripten из исходников на GitHub (полезно для разработчиков проекта). 
- :ref:`about-this-site` описание инструментов и конвенций используемых при разработке этого сайта. 

**Справочник:**

- :ref:`api-reference-index` справочник по API Emscripten. 
- :ref:`tools-reference` справочник по инструментам Emscripten. 
- :ref:`CyberDWARF` способы использования отладочной системы CyberDWARF.
- :ref:`Sanitizers` отладка с использованием 'sanitizers' 

Полный список статей (включая статьи второго уровня):

.. toctree::
  :maxdepth: 2

  introducing_emscripten/index
  getting_started/index
  porting/index
  optimizing/Optimizing-Code
  optimizing/Optimizing-WebGL
  optimizing/Profiling-Toolchain
  compiling/index
  building_from_source/index
  contributing/index
  api_reference/index
  tools_reference/index
  debugging/CyberDWARF
  debugging/Sanitizers
  site/index
