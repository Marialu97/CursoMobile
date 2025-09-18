        ENTRA NO 
        Firebase
        CRIA UM BANCO NA DENTRO 
        cine-favorito
        ENTRA NO Criação 
        Authentication
        Firestore Database 
        E MUDA 

        
        TERMINAL 
        flutter create formativa_cine_favorite --platform=android --empty
        cd .\formativa_cine_favorite\
        flutter pub add firebase_core firebase_authcloud_firestore http
        flutter pub get
        flutter configure 
        flutterfire configure
        DEPOIS DESE COMANDO SO DA ENTER DUAS VEZ 

=================================================================
                        FAZER SOZINHO
        CRIAR 
        lib 
        CRIA A TELA FAVORITE/LOGIN/REGISTRO
        lib/favorite_view.dart/login_view.dart/registro_view.dart
        ESCREVE DENTRO DAS TRES 

        TERMINAL 
         flutter run 
         PARA RODAR O PROJETO 

=================================================================
                        COREÇÃO
        PASTA 
        main.dart//favorite_view.dart/login_view.dart/registro_view.dart

        CURIOSIDADE 
        pubspec.yaml
        TODAS AS BIBLIOTECA QUE INSTALEI ESTA NELE
      
        DEU ERRADO FALTPU 
        TERMINAL
        flutter pub add firebase_storage 

        ENTRA 
        android/app/build.gradle.kts
        build.gradle.kts
        MUDA A LINHA PARA RODAR 
        minSdk = 23 

----------------------------------------------------------------------
        PARTE DO FILME 

        TERMINAL 
         mkdir lib/models
         mkdir lib/controllers
         type nul > lib/models/movie.dart

         ENTRA NA PASTA 
         models/movie.dart

         TERMINAL 
         type nul > lib/constrollers/tmdb_controller.dart

        ENTRA E ESCREVE DENTRO
        tmdb_controller.dart

        TERMINAL 
         type nul > lib/controllers/firestore_controller.dart

        ENTRA E ESCREVE DENTRO
        firestore_controller.dart

        TERMINAL
        flutter pub add path path_provider
        flutter pub get

        



