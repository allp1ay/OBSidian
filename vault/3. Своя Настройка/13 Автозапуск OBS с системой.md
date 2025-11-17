1. Перейди в Папку `OBS\bin\64bit`
2. Скопируй `obs64.exe`как путь.
3.  Создай файл `OBS StartUp.cmd` внутри папки 64bit и скопируй в него этот код
```batch
start /d "" "" obs64.exe -p --collection "" --profile "" --scene "" --startreplaybuffer --minimize-to-tray --disable-updater --disable-shutdown-check --disable-missing-files-check
```
4. Вставь в первые двойные кавычки ранее скопированный путь.
5. Создай ярлык для этого файла. 
6. Перенеси созданные ярлык в эту [папку](shell:startup).
==Тут папку поменял. На СИИИЛЬНО более короткую ссылку. Пользуйся))==

[[14 Установка коллекции сцен|Дальше]]
