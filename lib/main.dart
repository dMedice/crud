import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Aluno {
  String nome;
  String email;
  String senha;
  String repetirSenha;

  Aluno({
    required this.nome,
    required this.email,
    required this.senha,
    required this.repetirSenha,
  });
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Aluno',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRUD Aluno'),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/logo.jpg',
                  height: 275,
                  width: 275,
                ),
                Positioned(
                  top: 72,
                  child: Image.asset(
                    'images/logo.jpg',
                    height: 52.11,
                    width: 300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Lana Leme de Medice Lima',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text == 'Vedilson' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Acessar'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  // Lista de alunos (simulado um banco de dados)
  List<Aluno> students = [
    Aluno(
        nome: 'Aluno 1',
        email: 'aluno1@senai.br',
        senha: 'senha1',
        repetirSenha: 'senha1'),
    Aluno(
        nome: 'Aluno2',
        email: 'aluno2@senai.br',
        senha: 'senha2',
        repetirSenha: 'senha2'),
    Aluno(
        nome: 'Veredilson',
        email: 'veredilson@senai.br',
        senha: 'vegeta',
        repetirSenha: 'vegeta'),
  ];

  bool isValidEmail(String email) {
    // Validação do formato do e-mail
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].email),
            subtitle: Text(students[index].email),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir registro do aluno
                students.removeAt(index);
                // Atualizar a lista de alunos
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aluno removido.')),
                );
              },
            ),
            onTap: () async {
              // Editar o aluno
              Aluno updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _emailController =
                      TextEditingController(text: students[index].email);
                  TextEditingController _senhaController =
                      TextEditingController(text: students[index].senha);
                  TextEditingController _repetirSenhaController =
                      TextEditingController(text: students[index].repetirSenha);

                  return AlertDialog(
                    title: Text('Editar Aluno'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                            controller: _nomeController,
                            decoration: InputDecoration(labelText: 'Nome')),
                        TextField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email')),
                        TextField(
                            controller: _senhaController,
                            decoration: InputDecoration(labelText: 'Senha'),
                            obscureText: true),
                        TextField(
                            controller: _repetirSenhaController,
                            decoration:
                                InputDecoration(labelText: 'Repetir Senha'),
                            obscureText: true),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_nomeController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              isValidEmail(_emailController.text) &&
                              _senhaController.text.isNotEmpty &&
                              _repetirSenhaController.text.isNotEmpty &&
                              _senhaController.text ==
                                  _repetirSenhaController.text) {
                            Navigator.pop(
                              context,
                              Aluno(
                                nome: _nomeController.text.trim(),
                                email: _emailController.text.trim(),
                                senha: _senhaController.text.trim(),
                                repetirSenha:
                                    _repetirSenhaController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                setState(() {
                  students[index] = updatedStudent;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Aluno? newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _emailController = TextEditingController();
              TextEditingController _senhaController = TextEditingController();
              TextEditingController _repetirSenhaController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Novo Aluno'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(labelText: 'Nome')),
                    TextField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email')),
                    TextField(
                        controller: _senhaController,
                        decoration: InputDecoration(labelText: 'Senha'),
                        obscureText: true),
                    TextField(
                        controller: _repetirSenhaController,
                        decoration: InputDecoration(labelText: 'Repetir Senha'),
                        obscureText: true),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          isValidEmail(_emailController.text) &&
                          _senhaController.text.isNotEmpty &&
                          _repetirSenhaController.text.isNotEmpty &&
                          _senhaController.text ==
                              _repetirSenhaController.text) {
                        Navigator.pop(
                          context,
                          Aluno(
                            nome: _nomeController.text.trim(),
                            email: _emailController.text.trim(),
                            senha: _senhaController.text.trim(),
                            repetirSenha: _repetirSenhaController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
          // Verificar espaço a ser alocado para a adição do novo aluno
          if (newStudent != null) {
            // Adicionar o novo aluno à lista
            students.add(newStudent);
            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
