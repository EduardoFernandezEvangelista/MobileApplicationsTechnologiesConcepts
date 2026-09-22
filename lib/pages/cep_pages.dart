import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {

  Map<String, dynamic>? dados;

  bool carregando = false;

  String? erro;

  Future<void> buscarCep() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final url = Uri.parse(
        'https://viacep.com.br/ws/18132350/json/',
      );

      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        setState(() {
          dados = jsonDecode(resposta.body);
          carregando = false;
        });
      } else {
        setState(() {
          erro = 'Erro ao consultar o CEP.';
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
    buscarCep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CEP - Sirius Corporation'),
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
                    child: Text(erro!),
                  )

                : dados == null
                    ? const Center(
                        child: Text(
                          'Nenhum endereço encontrado.',
                        ),
                      )

                    : ListView(
                        children: [

                          const Icon(
                            Icons.location_on,
                            size: 80,
                            color: Color(0xFF78281F),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            'Endereço da Sirius Corporation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          _informacao(
                            'CEP',
                            dados!['cep'],
                          ),

                          _informacao(
                            'Logradouro',
                            dados!['logradouro'],
                          ),

                          _informacao(
                            'Bairro',
                            dados!['bairro'],
                          ),

                          _informacao(
                            'Cidade',
                            dados!['localidade'],
                          ),

                          _informacao(
                            'Estado',
                            dados!['uf'],
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
        leading: const Icon(
          Icons.location_on,
        ),

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