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

----------------------------------------------------------------------
DEU CERTO 
-----------------------------------------------------------------------
        TERMINAL
            flutter pub add firebase_core firebase_auth cloud_firestore
            flutterfire configure
            <!-- da um enter para colocar (id)  -->

    ENTRA NA PASTA 
        main.dart
        ESCREVE DENTRO 


11.09.25

        ENTRA NO LINK
        https://home.openweathermap.org/api_keys
        COLOCA SEU EMAI

            TERMINAL  DO COMPUTADOR 
                node -v
                npm -v
                --version
                firebase login
                RETORNAR O EMAIL 

            TERMINAL  DO PROJETO
            cd .\Firebase\
            cd .\todo_list_firebase\
            mkdir lib/view                
            cd .\lib\
            type nul > autenticacao_view.dar // ESSE DEU ERRADO E FIZ MANUALMENTE 
            
        ENTRA NA PASTA 
        view
        autenticacao_view.dart
        ESCREVE DENTRO

            SE NAO TIVER INDO O CODIGO ISTALA NO TERMINAL 
            flutter pub add firebase_auth firebase_core cloud_firestore
            <!-- AS BIBLIOTECA  -->

            TERMINAL
            type nul >lib/view/tarefas_view.dart
            type nul >lib/view/login_view.dart

        ENTRA NA TELA 
        login_view.dart
        ESCREVE DENTRO 
 <!-- SO QUE NO autenticacao_view.dart TEM QUE IMPORTAR AS TELAS PARA TIRA O ERRO -->

            TERMINAL 
            type nul >lib/view/registro_view.dart

            VAI PARA PASTA 
            registro_view.dart
            ESCREVE DENTRO

<!-- SO QUE NO login_view.dart TEM QUE IMPORTAR A TELA registro_view.dart PARA TIRA O ERRO -->

            VAI PARA PASTA
            tarefas_view.dart
            ESCREVE DENTRO

            VAI NAS PASRA E DA IMPORTE 

            TERMINAL 
            flutter run 

            NA PASTA 
            android
            app
            build.gradle.kts
            MUDA A LINHA 30  PARA 
            minSdk = 23
            COLOCA PARA RODA 

            CONTINUIDADE DO CODIGO 
                 TAREFAS 

            ENTRA NA PASTA 
            tarefas_view.dart
            ESCREVE DENTRO 

======================================================================
            FAZER SOSINHO
<!-- método para atualizar status da tareda  -->
 <!-- metodo para deletar tarefa -->
===================================================================