import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DolarPage extends StatefulWidget {
  const DolarPage({super.key});

  @override
  State<DolarPage> createState() => _DolarPageState();
}

class _DolarPageState extends State<DolarPage> {

  Map<String, dynamic>? dados;

  bool carregando = false;

  String? erro;

  Future<void> buscarDolar() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final url = Uri.parse(
        'https://economia.awesomeapi.com.br/last/USD-BRL',
      );

      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final json = jsonDecode(resposta.body);

        setState(() {
          dados = json['USDBRL'];
          carregando = false;
        });
      } else {
        setState(() {
          erro = 'Erro ao consultar a cotação.';
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
    buscarDolar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotação do Dólar',
        ),

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
                          'Cotação não encontrada.',
                        ),
                      )

                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            const Icon(
                              Icons.attach_money,
                              size: 100,
                              color: Colors.green,
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Dólar Americano',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 30),

                            Card(
                              elevation: 5,

                              child: Padding(
                                padding: const EdgeInsets.all(30),

                                child: Column(
                                  children: [

                                    const Text(
                                      'USD → BRL',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    Text(
                                      'R\$ ${dados!['bid']}',
                                      style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    Text(
                                      'Variação: ${dados!['pctChange']}%',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      'Máxima: R\$ ${dados!['high']}',
                                    ),

                                    Text(
                                      'Mínima: R\$ ${dados!['low']}',
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            ElevatedButton.icon(
                              onPressed: buscarDolar,

                              icon: const Icon(
                                Icons.refresh,
                              ),

                              label: const Text(
                                'Atualizar cotação',
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}