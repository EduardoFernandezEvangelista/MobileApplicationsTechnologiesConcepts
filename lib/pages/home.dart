import 'package:flutter/material.dart';
import 'package:mobile_applications_technologies_concepts/pages/gps_pages.dart';

import 'cnpj_pages.dart';
import 'cep_pages.dart';
import 'dolar_pages.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void abrirPagina(BuildContext context, Widget pagina) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pagina,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sirius Corporation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color(0xFF78281F),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            color: const Color(0xFF5E1F18),

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [

                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Início',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      abrirPagina(
                        context,
                        const CnpjPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.business,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'CNPJ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      abrirPagina(
                        context,
                        const CepPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'CEP',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      abrirPagina(
                        context,
                        const DolarPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Dólar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      abrirPagina(
                        context,
                        const Localizacao(),
                      );
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Localização',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/img/logo.png',
                width: 180,
                height: 180,
              ),

              const SizedBox(height: 25),

              const Text(
                'Sirius Corporation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Bem-vindo à Sirius Corporation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'A Sirius Corporation é uma empresa fictícia '
                'criada para demonstrar o consumo de APIs '
                'em aplicações Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Explore nossas informações:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [

                  _botaoMenu(
                    context,
                    'CNPJ',
                    Icons.business,
                    const CnpjPage(),
                  ),

                  _botaoMenu(
                    context,
                    'CEP',
                    Icons.location_on,
                    const CepPage(),
                  ),

                  _botaoMenu(
                    context,
                    'Dólar',
                    Icons.attach_money,
                    const DolarPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoMenu(
    BuildContext context,
    String texto,
    IconData icone,
    Widget pagina,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        abrirPagina(context, pagina);
      },

      icon: Icon(icone),

      label: Text(texto),

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    );
  }
}