import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// ================= PALETA =================
const Color kPrimaria = Color(0xFF4F46E5); // índigo elegante
const Color kPrimariaEscura = Color(0xFF3730A3);
const Color kFundo = Color(0xFFF6F7FB);
const Color kCampo = Colors.white;
const Color kBorda = Color(0xFFE2E4EE);
const Color kTexto = Color(0xFF1E1B4B);
const Color kTextoSuave = Color(0xFF6B7280);
const Color kSucesso = Color(0xFF16A34A);
const Color kErro = Color(0xFFDC2626);

// ================= TEMA =================
ThemeData _criarTema() {
  OutlineInputBorder borda(Color cor, [double largura = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cor, width: largura),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaria,
      primary: kPrimaria,
      error: kErro,
    ),
    scaffoldBackgroundColor: kFundo,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kCampo,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      labelStyle: const TextStyle(color: kTextoSuave, fontSize: 15),
      floatingLabelStyle: const TextStyle(
        color: kPrimaria,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
      prefixIconColor: kPrimaria,
      suffixIconColor: kTextoSuave,
      errorStyle: const TextStyle(fontSize: 12.5),
      border: borda(kBorda),
      enabledBorder: borda(kBorda),
      focusedBorder: borda(kPrimaria, 2),
      errorBorder: borda(kErro),
      focusedErrorBorder: borda(kErro, 2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaria,
        foregroundColor: Colors.white,
        elevation: 3,
        shadowColor: const Color(0x664F46E5),
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: _criarTema(),
      home: const CadastroPage(),
    );
  }
}

// ================= TELA DE CADASTRO =================
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  // ---------- Validações ----------
  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o nome completo';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o e-mail';
    if (!value.contains('@')) return 'O e-mail deve conter @';
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Informe um e-mail válido';
    }
    return null;
  }

  String? _validarCpf(String? value) {
    if (value == null || value.isEmpty) return 'Informe o CPF';
    if (value.length != 11) return 'O CPF deve ter 11 números';
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) return 'Informe o telefone';
    if (value.length < 10 || value.length > 11) {
      return 'O telefone deve ter 10 ou 11 números (com DDD)';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
    return null;
  }

  String? _validarConfirmacao(String? value) {
    if (value == null || value.isEmpty) return 'Confirme a senha';
    if (value != _senhaController.text) return 'As senhas não coincidem';
    return null;
  }

  // ---------- Ação do botão ----------
  void _cadastrar() {
    FocusScope.of(context).unfocus();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      messenger.showSnackBar(
        _snackBar(
          'Cadastro realizado com sucesso!',
          kSucesso,
          Icons.check_circle_rounded,
        ),
      );
    } else {
      messenger.showSnackBar(
        _snackBar(
          'Corrija os campos destacados e tente novamente.',
          kErro,
          Icons.error_rounded,
        ),
      );
    }
  }

  SnackBar _snackBar(String texto, Color cor, IconData icone) {
    return SnackBar(
      backgroundColor: cor,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(icone, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }

  // ---------- Componentes visuais ----------
  Widget _cabecalho() {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [kPrimaria, kPrimariaEscura],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x554F46E5),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Crie sua conta',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: kTexto,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Preencha seus dados para começar a usar o aplicativo.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.5, color: kTextoSuave, height: 1.4),
        ),
      ],
    );
  }

  Widget _tituloSecao(String texto) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        texto.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: kTextoSuave,
        ),
      ),
    );
  }

  Widget _botaoOlho(bool oculto, VoidCallback aoClicar) {
    return IconButton(
      tooltip: oculto ? 'Mostrar senha' : 'Ocultar senha',
      icon: Icon(
        oculto ? Icons.visibility_rounded : Icons.visibility_off_rounded,
      ),
      onPressed: aoClicar,
    );
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final topo = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(24, topo + 32, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _cabecalho(),
              const SizedBox(height: 36),

              _tituloSecao('Dados pessoais'),

              // Nome completo
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Ex.: Maria da Silva',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: _validarNome,
              ),
              const SizedBox(height: 16),

              // E-mail
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'seuemail@exemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),

              // CPF
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Apenas números (11 dígitos)',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: _validarCpf,
              ),
              const SizedBox(height: 16),

              // Telefone
              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'DDD + número, apenas dígitos',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: _validarTelefone,
              ),
              const SizedBox(height: 28),

              _tituloSecao('Segurança'),

              // Senha
              TextFormField(
                controller: _senhaController,
                obscureText: _ocultarSenha,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: _botaoOlho(
                    _ocultarSenha,
                    () => setState(() => _ocultarSenha = !_ocultarSenha),
                  ),
                ),
                validator: _validarSenha,
              ),
              const SizedBox(height: 16),

              // Confirmação de senha
              TextFormField(
                controller: _confirmarSenhaController,
                obscureText: _ocultarConfirmacao,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _cadastrar(),
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  hintText: 'Repita a senha',
                  prefixIcon: const Icon(Icons.lock_reset_rounded),
                  suffixIcon: _botaoOlho(
                    _ocultarConfirmacao,
                    () => setState(
                      () => _ocultarConfirmacao = !_ocultarConfirmacao,
                    ),
                  ),
                ),
                validator: _validarConfirmacao,
              ),
              const SizedBox(height: 32),

              // Botão CADASTRAR
              ElevatedButton(
                onPressed: _cadastrar,
                child: const Text('CADASTRAR'),
              ),
              const SizedBox(height: 20),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, size: 16, color: kTextoSuave),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Seus dados estão protegidos.',
                      style: TextStyle(fontSize: 12.5, color: kTextoSuave),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
