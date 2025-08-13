# 🎬 App de Gerenciamento de Assinaturas

Aplicativo mobile para organizar e controlar seus serviços de **streaming** (e outras assinaturas), permitindo cadastrar do zero, escolher de uma lista pré-definida, **filtrar**, **atualizar**, **excluir** e acompanhar **quanto você já gastou** no período. Projeto com foco em uma experiência **clara, leve e intuitiva**.

---

## 🚀 Tecnologias Utilizadas

- **Flutter & Dart** → desenvolvimento mobile multiplataforma
- **Firebase Authentication** → login, cadastro e logout
- **Cloud Firestore** → armazenamento das assinaturas, perfis e métricas
- **Firebase Crashlytics** → monitoramento de erros em produção

> **Arquitetura:** Camadas **datasource → repository → usecase → cubit (Flutter Bloc)**, facilitando testes, manutenção e desacoplamento.

---

## 📱 Funcionalidades Principais

- **Autenticação completa**
  - Criar conta, fazer **login**, **cadastro** e **logout** com Firebase Auth
- **Gestão de assinaturas**
  - **Adicionar do zero**: informe nome, valor, data de cobrança, método de pagamento
  - **Selecionar de catálogo**: lista de serviços populares (Netflix, Disney+, Spotify, etc.)
  - **Atualizar**: editar valor, data de renovação
  - **Excluir**: remova assinaturas que não usa mais
- **Controle de gastos**
  - **Total gasto no período** (mês)
- **Filtros e busca**
  - Filtrar por **categoria**

---

## 🧭 Estrutura do Projeto

```
subscription_management/
├── assets/
│   ├── images/
│   │   └── subscription_management_logo.png
│   └── strings.json
│
├── lib/
│   ├── main.dart                 # Ponto de entrada, configuração do GetIt
│   └── src/
│       ├── app.dart                  # Widget principal com MaterialApp.router
│       │
│       ├── modules/                # Pasta principal para os módulos/features
│       │   ├── login/
│       │   │   ├── domain/
│       │   │   │   ├── entities/
│       │   │   │   └── use_cases/
│       │   │   ├── data/
│       │   │   ├── external/
│       │   │   └── presentation/
│       │   │       ├── cubit/
│       │   │       │   └── user_authentication_cubit.dart
│       │   │       └── pages/
│       │   │           └── login_page.dart
│       │   │
│       │   ├── home/
│       │   │   └── presentation/
│       │   │       ├── pages/
│       │   │       │   └── home_page.dart
│       │   │       └── widgets/
│       │   │
│       │   ├── splash_screen/
│       │   │   └── splash_screen.dart
│       │   │
│       │   ├── streaming_management/
│       │   │   ├── domain/
│       │   │   ├── data/
│       │   │   ├── external/
│       │   │   │   └── datasources/
│       │   │   │       └── streaming_datasource_impl.dart
│       │   │   └── presentation/
│       │   │       └── widgets/
│       │   │           └── cancel_subscription_modal_content.dart
│       │   │
│       │   └── shared/                 # Widgets e lógicas compartilhados
│       │       └── widgets/
│       │           ├── app_error_widget.dart
│       │           └── custom_button.dart
│       │
│       ├── routes/                   # Configuração de navegação
│       │   ├── router.dart             # Definição das rotas (AutoRoute)
│       │   └── router.gr.dart          # Arquivo gerado pelo AutoRoute
│       │
│       └── utils/                    # Utilitários gerais
│           ├── app_strings.dart        # Classe de strings gerada
│           └── widgets/
│               └── custom_snack_bar_widget.dart
│
├── pubspec.yaml
└── .gitignore
```

---

## 🛠 Como Rodar o Projeto

### 1) Clone o repositório

```bash
git clone https://github.com/GabrieleSacramento/subscription_management.git
cd subscription_management
```

### 2) Instale as dependências

```bash
flutter pub get
```

### 3) Configure o Firebase

- Crie um projeto no **Firebase Console**
- Adicione os apps **iOS** e **Android**
- Siga a documentação do **FlutterFire** para gerar e adicionar o `firebase_options.dart`
- Habilite **Authentication (Email/Senha)** e **Firestore**

### 4) Execute o aplicativo

```bash
flutter run
```

---



## 🤝 Contribuição

Contribuições são muito bem-vindas! Abra uma **issue** ou envie um **pull request** com melhorias e sugestões. Se quiser bater um papo, me chama no **LinkedIn**: [https://www.linkedin.com/in/gabriele--sacramento/](https://www.linkedin.com/in/gabriele--sacramento/)

---

## 📄 Licença

Este projeto é distribuído sob a licença **MIT**. Veja o arquivo `LICENSE` para mais detalhes.

---

Feito com ❤️ usando **Flutter** + **Firebase** e arquitetura limpa.

