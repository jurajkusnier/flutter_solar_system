# Solar System

This app was developed for [**Flutter Create 5KB Contest**](https://flutter.dev/create) in 2019.

The **Flutter Create Campaign** (the “Contest”) is a skill contest where participants (“Participants” or “entrant”) must develop and submit 5KB or less of Dart code to generate a user interface built with Flutter that creates a novel user experience.
Dart code must appear in a file that has a filename ending in .dart. The total size of all Dart files in the project must be no more than 5,120 bytes as (for example) measured by the command `find . -name "*.dart" | xargs cat | wc -c`

![Screenshots](https://raw.githubusercontent.com/jurajkusnier/flutter_solar_system/main/screenshots/app.png)

**Solar System** app consists of two screens. The first screen contains a scrollable list of planets. When the user selects one planet is redirected to the second screen. The second screen shows basic information about the selected plant with a few images. All data are loaded from a local JSON file. A significant part of UI consists of a vector graphics I've created using [**Rive 1**](https://rive.app/) (previously Flare).
Dart source code in the repository is unpacked but you can pack it using a python script to see that the whole source code is actually less than 5kb.

```bash
$ find . -name "*.dart" | xargs cat | wc -c
    5116
$ flutter run --release
    Initializing gradle...                                              1.1s
    Resolving dependencies...                                           8.7s
    Launching lib/main.dart on Mi A2 Lite in release mode...
    Running Gradle task 'assembleRelease'...                                
    Running Gradle task 'assembleRelease'... Done                      60.3s
    Built build/app/outputs/apk/release/app-release.apk (10.0MB).
    Installing build/app/outputs/apk/app.apk...                         2.2s
    
    To quit, press "q".
    
    Application finished.
```
