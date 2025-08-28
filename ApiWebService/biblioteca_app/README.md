    *TERMINAL
        flutter create biblioteca_app --platform=android --empty   
        cd 
        code .

    *TERMINAL DO PROJETO 
         flutter pub add http
         flutter pub get 
         mkdir backend
         type nul > backend/db.json

    *ESTARTAR O BACO DE DADOS 
        npx json-server --watch backend/db.json --port 3009

    *TERMINAL A ESTRUTURA DO PROJETO
     mkdir lib/models
     mkdir lib/controllers
    lib/views       
<!-- ALSILIA NA CONEQUICAO  -->
    mkdir lib/services  

    type nul > lib/services/api_service.dart

    -ENTRA NA PASTA 
    -lib
    -services
    -api_service.dart
        ESCREVE DENTRO 

    *TERMINAL DO COMPUTADOR 
    ipconfig
     VAI NO 
     endereço IPv4
     COPIA
     api_service.dart 
     NA LINHA E COLOCA O 3009 QUE É O SEU

    *TERMINAL 
     type nul > lib/models/user_model.dart

     -ENTRA NA PATA 
     -models
     -user_model.dart
        ESCREVE DENTRO 

   ----------------------------------------------
        fazer sosinho
        *FIZ NO TERMINAL
        type nul > lib/models/book_model.dart
        type nul > lib/models/loans_model.dart


        -DENTRO DAS PASTAS 
        -book_model.dart
        -loans_model.dart
            ESCREVE DENTRO

    ----------------------------------------------

    *TERMINAL
    type nul > lib/controllers/user_controler.dart

    VAI NA PASTA
    -controllers
    user_controler.dart
        ESCREVE DENTRO
    -----------------------------------------------

        fazer controle livro e empretimo 

    -----------------------------------------------

    28.08.25
        
        VERIFIQUEI AS PASTAS 
        CORECAO DA PASTA QUE FEZ SOSINHA SO UMA 
        -book_model.dart

        CEIAR A PASTA 
        -controllers
        -book_controller.dart

        *TERMINAL
        mkdir /lib/views/user  
        mkdir /lib/views/book   
        mkdir /lib/views/loan     
        type nul > lib/views/home_view.dart  
        type nul > lib/views/user/user_list_view.dart 
        type nul > lib/views/user/user_form_view.dart 
        type nul > lib/views/book/book_form_view.dart  
        type nul > lib/views/book/book_list_view.dart
        type nul > lib/views/loan/loan_list_view.dart   
        type nul > lib/views/loan/loan_form_view.dart 

        VAI NA PASTA 
        -home_view.dart
        ESCREVE DENTRO 
        
        -main.dart
        ESCREVE 

        *TERMINAL 
        ESTARTA O TERMINAL 
        npx json-server --watch backend/db.json --port 3009
        flutter run 

        -ENTRA NA PASTA 
        -user_list_view.dart
        ESCREVE DENTRO

======================================================================
    SE DER ERRADO COMO DEU NO MEU O NOME NA PARTE DO "USUÁRIOS"  QUANDO RODA VERIFICA NO db.json SE ESTA name.
======================================================================
 
 --------------------------------------------------------------------------
     FAZ SOZINHO A PARTE PARA LIVROS 
    - book_list_view.dart

           <!-- DEU CERTO  -->
 --------------------------------------------------------------------------
       VAI NA PASTA
        user_list_view.dart
        ESCREVE DENTRO 
        user_form_view.dart
        ESCREVE DENTRO 

----------------------------------------------------------------------
        LIVROS
        EMPRESTIMO
----------------------------------------------------------------------

=====================================================================
ERROS ENCONTRADOS NAO APAGA O USUÁRIO
NÃO ATUALIZA 
E NA HORA QUE ATUALIZA ELE JOGA PARA A PAGINA LIVROS 
=====================================================================


