import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CnpjPage extends StatefulWidget {
  const CnpjPage({super.key});

  @override
  State<CnpjPage> createState() => _CnpjPageState();
}

class _CnpjPageState extends State<CnpjPage> {

  Map<String, dynamic>? dados;

  bool carregando = false;

  String? erro;

  Future<void> buscarCnpj() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final url = Uri.parse(
        'https://api.opencnpj.org/03779133005670',
      );

      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        setState(() {
          dados = jsonDecode(resposta.body);
          carregando = false;
        });
      } else {
        setState(() {
          erro = 'Erro ao consultar o CNPJ.';
          carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        erro = 'Não foi possível conectar à API.';
        carregando = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buscarCnpj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CNPJ - Sirius Corporation'),
        backgroundColor: const Color(0xFF78281F),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: carregando
            ? const Center(
                child: CircularProgressIndicator(),
              )

            : erro != null
                ? Center(
                    child: Text(
                      erro!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )

                : dados == null
                    ? const Center(
                        child: Text(
                          'Nenhum dado encontrado.',
                        ),
                      )

                    : ListView(
                        children: [

                          const Icon(
                            Icons.business,
                            size: 80,
                            color: Color(0xFF78281F),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Informações da empresa',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          _informacao(
                            'CNPJ',
                            dados!['cnpj'],
                          ),

                          _informacao(
                            'Razão Social',
                            dados!['razao_social'],
                          ),

                          _informacao(
                            'Nome Fantasia',
                            dados!['nome_fantasia'],
                          ),

                          _informacao(
                            'Situação',
                            dados!['situacao'],
                          ),

                          _informacao(
                            'Data de Abertura',
                            dados!['data_abertura'],
                          ),
                        ],
                      ),
      ),
    );
  }

  Widget _informacao(
    String titulo,
    dynamic valor,
  ) {
    return Card(
      child: ListTile(
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          valor?.toString() ?? 'Não informado',
        ),
      ),
    );
  }
}