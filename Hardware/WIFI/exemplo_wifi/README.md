        TERMINAL
        cd Hardware
        mkdir WIFI
         cd .\WIFI\
         flutter create exemplo_wifi --platforms=android --empty
         cd .\exemplo_wifi\ 
         flutter pub add connectivity_plus

        PARA LIBERA O COMANDO 
        VA NA PASTA 
        android/app/src/debug/AndroidManifest.xml
        AndroidManifest.xml 
        ESCREVE DENTRO 

        ENTRA NA PASTA E ESCERVE 
        lib/main.dart
        main.dart