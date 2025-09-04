04.09.25        
        
         TERMINAL
 <!-- cria a pasta  -->
            mkdir Firebase 
            cd Firebase
            node -v
            npm install -g firebase-tools
            npx firebase login
            entra no link e coloca o email 


            npx firebase projects:list
            flutter create todo_list_firebase --platforms=android --empty
            cd .\todo_list_firebase\ 
<!--  abaixa as biblioteca  -->            
            flutter pub add firebase_core firebase_auth cloud_firestore  
            flutter pub get
            dart pub global activate flutterfire_cli

    ENTRA NO APP
        opia o linque 
        no meu caso deu esse 
        C:\Users\DevSESIB\AppData\Local\Pub\Cache\bin
        entra no Exporador de arquivo 
        cola la em cima o link
        da enter, pega a da( contro x )na pasta 
        entra no 
        Windows (C:)
        src
        flutter
        bin
        cola a pasta la 

        TERMONAL
        flutterfire configure
---------------------------------------------------------------------------
DEU ERRO
---------------------------------------------------------------------------
    ABAIXA
     https://nodejs.org/pt/download
    coloca na variavel de ambiente 

        TERMINAL 
            npm install -g firebase-tools
            firebase login
            flutterfire configure

---------------------------------------------------------------------------
DEU CERTO 
--------------------------------------------------------------------------
        TERMINAL
            flutter pub add firebase_core firebase_auth cloud_firestore
            flutterfire configure
            <!-- da um enter para colocar (id)  -->

    ENTRA NA PASTA 
        main.dart
        ESCREVE DENTRO 


