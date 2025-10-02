        TERMINAL
        flutter create sa_localizacao_mapa --platforms=android --empty
        cd .\sa_localizacao_mapa\
        flutter pub add geolocator  

        ENTRO NA PASTA 
         android/app/src/debug/AndroidManifest.xml
         AndroidManifest.xml
         ESCREVE DENTRO

         app/build.gradle.kts
         build.gradle.kts
         MUDA UMA LINHA

         ENTRA NA PASTA 
         lib/main.dart
         main.dart

         TERMINAL 
         mkdir lib/models
        mkdir lib/controllers
        mkdir lib/views
        type nul > lib/models/location_point.dart

        ENTRA DENTRO DA PASTA 
        lib/models/location_point.dart
        location_point.dart
        ESCREVE DENTRO

        TERMINAL
        flutter pub add latlong
        >>>MAIS DEU ERRO EM TA, FIZEMOS SEM ELA MESMO<<<

         type nul > lib/controllers/map_controller.dart

         ENTRA DENTRO
         lib/controllers/map_controller.dart
         map_controller.dart
         ESCREVO DENTRO

         TERMINAL ABAIXA
         flutter pub add intl

         CRIA NO TERMINAL
         type nul > lib/views/map_view.dart

         ENTRA
         lib/views/map_view.dart
         map_view.dart
         ESCREVE DENTRO

         TERMINAL 
        flutter pub add flutter_map

        




