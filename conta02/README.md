# Conta Certa (MVP) - Sistema de Controle de Ponto

## . Nome do Projeto e Descrição

**Conta Certa** é um sistema de controle de ponto digital desenvolvido em Flutter para automatizar o processo de registro de horas trabalhadas em um escritório de contabilidade. O MVP substitui o controle manual de ponto, permitindo que funcionários registrem entradas e saídas, enquanto administradores gerenciam funcionários e extraem relatórios.

### Contexto do Cliente
O escritório de contabilidade Conta Certa enfrenta desafios com o controle manual de ponto. O RH precisa somar manualmente as horas no fim do mês, o que gera erros e perda de tempo. Este sistema digital resolve esse problema, oferecendo uma solução mobile intuitiva e eficiente.

##  Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento mobile cross-platform
- **Firebase Core**: Inicialização e configuração do Firebase
- **Firebase Auth**: Autenticação segura com email/senha e roles
- **Cloud Firestore**: Banco de dados NoSQL em tempo real
- **Provider**: Gerenciamento de estado reativo
- **Intl**: Formatação de datas e horas
- **Dart**: Linguagem de programação principal

Cada tecnologia foi escolhida por suas vantagens: Flutter para desenvolvimento rápido e nativo, Firebase para escalabilidade e segurança, Provider para gerenciamento de estado simples e eficiente.

## Instalação e Execução

Siga os passos abaixo para instalar e executar o projeto:

1. **Clone o repositório**:
   ```bash
   git clone <url-do-repositorio>
   cd conta02
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase** (veja seção 5):
   - Baixe o `google-services.json` do Firebase Console
   - Coloque o arquivo em `android/app/`

4. **Execute o aplicativo**:
   ```bash
   flutter run
   ```

O aplicativo será executado em um emulador ou dispositivo conectado. O servidor de desenvolvimento roda em modo debug por padrão.

##. Configuração de Variáveis de Ambiente

Para o Firebase funcionar corretamente, você precisa configurar o projeto no Firebase Console:

1. Acesse [Firebase Console](https://console.firebase.google.com/)
2. Crie um novo projeto ou selecione um existente
3. Habilite:
   - **Authentication** (Email/Password)
   - **Firestore Database**
4. Para Android:
   - Vá em Project Settings > General > Your apps
   - Baixe o `google-services.json`
   - Substitua o arquivo placeholder em `android/app/google-services.json`

**Nota**: O arquivo `google-services.json` contém chaves sensíveis e não deve ser commitado no repositório.

##  Perfis de Usuário

| Papel       | Permissões |
|-------------|------------|
| Admin (RH)  | CRUD de funcionários, relatórios completos, visualização geral |
| Funcionário | Registrar ponto (entrada/saída), visualizar histórico pessoal |

##  Funcionalidades Principais

### Autenticação
- Login com email e senha
- Roles: admin e funcionário
- Logout seguro

### CRUD de Funcionários (Admin)
- Campos: nome, email, senha, cargo, status
- Validação de dados obrigatórios

### Registro de Ponto (Funcionário)
- Campos: data, hora, tipo (Entrada/Saída), funcionárioID
- Sugestão automática do próximo tipo baseada no último registro
- Validação para evitar registros duplicados

### Histórico e Relatórios
- Funcionário: visualiza registros do dia/mês
- Admin: acessa relatórios completos de todos os funcionários

##  Interface e Navegação

### Páginas Principais
- **`/login`**: Tela de autenticação
- **`/dashboard`**: Dashboard com redirecionamento baseado no role
- **`/employees`**: Lista e CRUD de funcionários (apenas admin)
- **`/time_tracking`**: Registro de ponto (apenas funcionário)
- **`/history`**: Histórico de registros

### Navegação
- O dashboard redireciona automaticamente baseado no role do usuário
- Navegação protegida - usuários não autenticados são redirecionados para login
- Bottom navigation para acesso rápido às funcionalidades

## . Cálculo de Horas Trabalhadas

O sistema calcula automaticamente as horas trabalhadas por dia comparando os registros de entrada e saída:

- **Lógica**: Para cada dia, encontra pares entrada-saída e calcula a diferença
- **Validação**: Ignora registros sem par correspondente
- **Formato**: Horas e minutos trabalhados por dia
- **Relatórios**: Soma mensal das horas trabalhadas

##  Testes

### Testes de Funcionalidades
1. **Login**: Teste com credenciais válidas e inválidas
2. **CRUD Funcionários**: Criar, ler, atualizar e deletar funcionários
3. **Registro de Ponto**: Registrar entrada/saída e verificar sugestão automática
4. **Histórico**: Verificar cálculo correto de horas

### Testes de API (Firestore)
- Use Firebase Console para verificar dados em tempo real
- Teste queries de funcionários e registros de ponto

##  Decisões Técnicas

- **Provider**: Escolhido pela simplicidade e integração nativa com Flutter
- **Firebase**: Escalabilidade, segurança e tempo real sem servidor próprio
- **MVVM**: Separação clara de responsabilidades para manutenção
- **Material Design 3**: UI moderna e consistente
- **Padrões de Código**: Nomes descritivos, comentários em português, estrutura modular

##  Guia para Novos Desenvolvedores

### Fluxo Geral do Projeto
1. Usuário faz login → Firebase Auth valida credenciais
2. Dashboard carrega baseado no role → Navegação condicional
3. Funcionário registra ponto → Firestore salva em tempo real
4. Admin gerencia funcionários → CRUD completo com validações

### Como Contribuir
1. Crie uma branch para sua feature: `git checkout -b feature/nome-da-feature`
2. Siga os padrões de código existentes
3. Teste em múltiplos dispositivos
4. Faça commit com mensagens descritivas

### Adicionando Novas Funcionalidades
- **Nova tela**: Crie em `lib/screens/` e adicione rota em `main.dart`
- **Novo modelo**: Adicione em `lib/models/` com validações
- **Novo serviço**: Implemente em `lib/services/` seguindo o padrão existente

##  Créditos e Licença

Desenvolvido por DevSolutions © 2025.

Este projeto está licenciado sob a Licença MIT - veja o arquivo LICENSE para detalhes.
