# Formulário de Cadastro de Usuário — Flutter

Atividade prática da disciplina **Desenvolvimento Mobile (Flutter e Dart)** — tema *Formulários e Validações no Flutter*.

Tela de cadastro com captura de dados, filtros de entrada, validação campo a campo e feedback visual ao usuário, com tema personalizado em Material 3.

## Funcionalidades

| Campo | Regra |
|---|---|
| Nome completo | Obrigatório |
| E-mail | Obrigatório, deve conter `@` e passar na validação por `RegExp` |
| CPF | Obrigatório, apenas números, 11 dígitos (`TextInputType.number`) |
| Telefone | Obrigatório, apenas números, 10 ou 11 dígitos (`TextInputType.phone`) |
| Senha | Obrigatória, mínimo de 6 caracteres |
| Confirmar senha | Obrigatória, deve ser igual à senha |

- Botão **CADASTRAR** aciona `_formKey.currentState!.validate()`.
- Erros exibidos logo abaixo de cada campo inválido.
- **SnackBar verde** quando o cadastro é válido.

### Desafios implementados
- [x] Campo de confirmação de senha
- [x] Botão para mostrar/ocultar a senha (nos dois campos)
- [x] Validação de e-mail com `RegExp`
- [x] **SnackBar vermelho** ao tentar cadastrar com campos inválidos

## Estrutura da tela

```
Scaffold
└── Form(key: _formKey)
    └── SingleChildScrollView
        └── Column
            ├── Cabeçalho (ícone, título e subtítulo)
            ├── TextFormField (nome)
            ├── TextFormField (e-mail)
            ├── TextFormField (CPF)
            ├── TextFormField (telefone)
            ├── TextFormField (senha)
            ├── TextFormField (confirmar senha)
            └── ElevatedButton (CADASTRAR)
```

## Design
- `ThemeData` próprio com Material 3 e cor primária índigo.
- `InputDecorationTheme` com bordas arredondadas (`OutlineInputBorder`) e ícones de prefixo em todos os campos.
- Botão com 56 px de altura, cantos arredondados e texto em destaque.
- `SingleChildScrollView` evita overflow quando o teclado abre.

## Como executar

```bash
flutter pub get
flutter run -d chrome
```

Para rodar em Android/iOS, gere as pastas de plataforma antes:

```bash
flutter create .
flutter run
```

## Demonstração

### Cadastro com sucesso
![Cadastro com sucesso](docs/sucesso.png)

### Validação de erros
![Validação de erros](docs/erro.png)
