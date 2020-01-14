cd ../emscripten-site-source/site_ru/
make -j4 html
cd ../../emscripten-site/
cp -r ../emscripten-site-source/site_ru/build/html/* ./

