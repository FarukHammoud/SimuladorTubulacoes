
void G_Fora() {

  fill(0, 0, 0);
  stroke(0, 0, 0);
  if (FRAME_simulador.project_mode) {
    fill(100, 100, 100);
    stroke(100, 100, 100);
  }
  rect(0+interfaceX.RetornaXrelativo(), 0+interfaceX.RetornaYrelativo(), 12000, 2000);
  rect(10000+interfaceX.RetornaXrelativo(), -12000+interfaceX.RetornaYrelativo(), 2000, 12000);
  rect(-2000+interfaceX.RetornaXrelativo(), -12000+interfaceX.RetornaYrelativo(), 12000, 2000);
  rect(-2000+interfaceX.RetornaXrelativo(), -10000+interfaceX.RetornaYrelativo(), 2000, 12000);
}
void G_Snap() {
  int menor_distancia=10000;
  float x_menor=0;
  float y_menor=0;
  int retornaX_modificado = 0 ;

  int indice_temporario=0;
  int nponto_temporario=0;

  int sinalX = 0;
  int sinalY = 0;
  float imageX = 0;
  float imageY = 0;

  boolean pontiado = false;


  for (int a =0; a<FRAME_simulador.project_mode_linhas; a++) {

    //calculo do snap

    if (calculo.DistanciaPP((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala, (mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala, FRAME_simulador.project_mode_linha_x1[a]+interfaceX.RetornaXrelativo(), FRAME_simulador.project_mode_linha_y1[a]+interfaceX.RetornaYrelativo())<menor_distancia) {
      menor_distancia = calculo.DistanciaPP((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala, (mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala, FRAME_simulador.project_mode_linha_x1[a]+interfaceX.RetornaXrelativo(), FRAME_simulador.project_mode_linha_y1[a]+interfaceX.RetornaYrelativo());
      x_menor = FRAME_simulador.project_mode_linha_x1[a];
      y_menor = FRAME_simulador.project_mode_linha_y1[a];
      indice_temporario = a;
      nponto_temporario=1;
    }
    if (calculo.DistanciaPP((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala, (mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala, FRAME_simulador.project_mode_linha_x2[a]+interfaceX.RetornaXrelativo(), FRAME_simulador.project_mode_linha_y2[a]+interfaceX.RetornaYrelativo())<menor_distancia) {
      menor_distancia = calculo.DistanciaPP((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala, (mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala, FRAME_simulador.project_mode_linha_x2[a]+interfaceX.RetornaXrelativo(), FRAME_simulador.project_mode_linha_y2[a]+interfaceX.RetornaYrelativo());
      x_menor = FRAME_simulador.project_mode_linha_x2[a];
      y_menor = FRAME_simulador.project_mode_linha_y2[a];
      indice_temporario = a;
      nponto_temporario=2;
    }
  }
  strokeWeight(5);
  if (menor_distancia>50) {

    if (interfaceX.RetornaXrelativo()<0) {

      retornaX_modificado = interfaceX.RetornaXrelativo() + 50*(1+floor(-interfaceX.RetornaXrelativo()/50));
    } else {

      retornaX_modificado = interfaceX.RetornaXrelativo()%50;
    }
    pontiado = calculo.DistanciaPP((int((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala))%50, (int((mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala))%50, 0+retornaX_modificado, 0+interfaceX.RetornaYrelativo()%50)<5;

    if (pontiado) {

      //Snap Cartesiano
      stroke(0, 0, 255);
      FRAME_simulador.snaped_point = true;

      sinalX = int(((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala)%50-interfaceX.RetornaXrelativo()%50);
      sinalY = int(((mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala)%50-interfaceX.RetornaYrelativo()%50);
      imageX = int((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala)-interfaceX.RetornaXrelativo();
      imageY = int((mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala)-interfaceX.RetornaYrelativo();

      if (sinalX>=0&&sinalY>=0) {
      }
      x_menor = round(imageX/50)*50;
      y_menor = round(-imageY/50)*50;

      point(x_menor+interfaceX.RetornaXrelativo(), -y_menor+interfaceX.RetornaYrelativo());
      //envio dos pontos para o simulador
      if (FRAME_simulador.projecao=="ZX") {
        FRAME_simulador.snap_x = x_menor;
        FRAME_simulador.snap_z = y_menor;
      }
      if (FRAME_simulador.projecao=="ZY") {
        FRAME_simulador.snap_y = x_menor;
        FRAME_simulador.snap_z = y_menor;
      }
      if (FRAME_simulador.projecao=="XY") {
        FRAME_simulador.snap_x = x_menor;
        FRAME_simulador.snap_y = y_menor;
      }
    } else {
      //Sem Snap
      stroke(255, 0, 0);
      FRAME_simulador.snaped = false;
      FRAME_simulador.snaped_point = false;
      point(int((mouseX-FRAME_simulador.x_ref)/FRAME_simulador.escala), int((mouseY-FRAME_simulador.y_ref)/FRAME_simulador.escala));
    }

    //envio
  } else {

    //Snap de objeto
    stroke(0, 255, 0);
    point(x_menor+interfaceX.RetornaXrelativo(), y_menor+interfaceX.RetornaYrelativo());

    FRAME_simulador.snaped = true;
    //envio dos pontos para o simulador
    if (FRAME_simulador.projecao=="ZX") {
      FRAME_simulador.snap_x = x_menor;
      FRAME_simulador.snap_z = -y_menor;
      if (nponto_temporario==1) {
        FRAME_simulador.snap_y = FRAME_simulador.project_mode_linha_z1[indice_temporario];
      } else {
        FRAME_simulador.snap_y = FRAME_simulador.project_mode_linha_z2[indice_temporario];
      }
    }
    if (FRAME_simulador.projecao=="ZY") {
      FRAME_simulador.snap_y = x_menor;
      FRAME_simulador.snap_z = -y_menor;
      if (nponto_temporario==1) {
        FRAME_simulador.snap_x = FRAME_simulador.project_mode_linha_z1[indice_temporario];
      } else {
        FRAME_simulador.snap_x = FRAME_simulador.project_mode_linha_z2[indice_temporario];
      }
    }
    if (FRAME_simulador.projecao=="XY") {
      FRAME_simulador.snap_x = x_menor;
      FRAME_simulador.snap_y = -y_menor;
      if (nponto_temporario==1) {
        FRAME_simulador.snap_z = FRAME_simulador.project_mode_linha_z1[indice_temporario];
      } else {
        FRAME_simulador.snap_z = FRAME_simulador.project_mode_linha_z2[indice_temporario];
      }
    }
  }

  strokeWeight(1);
}
class Template {

  String template;
  int estado = 0;

  void Setup(String n_template) {

    this.template = n_template;
    this.estado = 0;
  }
  void Show() {

    if (template == "Vazio") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Simulador Gráfico de Tubulações do LACIT");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Criado por Faruk Hammoud - 2015");
        FRAME_barra_inferior.linha_4.MudaTexto("UTFPR - Campus Curitiba");
      }
    } else if (template == "Editar Ambiente") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("TB");
        FRAME_barra_inferior.linha_2.MudaTexto(str(FRAME_simulador.temperatura));
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Insira a Temperatura do Ambiente:");
        FRAME_barra_inferior.linha_3.MudaTexto("Confirme os dados inseridos:");
        FRAME_barra_inferior.linha_4.MudaTexto("Confirmar");

        this.estado++;
      }
      if (estado == 1) {
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 2) {
        FRAME_simulador.temperatura = float(FRAME_barra_inferior.linha_2.RetornaTexto());
        this.Setup("Vazio");
        FRAME_menu_superior.editar_ambiente.clicado = false;
      }
    } else if (template == "Editar Fluido") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("LL");
        FRAME_barra_inferior.linha_2.CarregaLista("Fluidos");
        FRAME_barra_inferior.linha_2.MudaInicial(FRAME_simulador.fluido);
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Insira o nome do fluido:");
        FRAME_barra_inferior.linha_3.MudaTexto("Confirme os dados inseridos:");
        FRAME_barra_inferior.linha_4.MudaTexto("Confirmar");
        this.estado++;
      }
      if (estado == 1) {
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 2) {
        FRAME_simulador.fluido = FRAME_barra_inferior.linha_2.RetornaTexto();
        
        FRAME_simulador.viscosidade_dinamica = float(data.viscosidade[FRAME_barra_inferior.linha_2.IndiceN()][1]);
        FRAME_simulador.massa_especifica = float(data.massa_especifica[FRAME_barra_inferior.linha_2.IndiceN()][1]);
        this.Setup("Vazio");
        FRAME_menu_superior.editar_fluido.clicado = false;
      }
    } else if (template == "Editar Vazão") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("TB");
        FRAME_barra_inferior.linha_2.MudaTexto(str(FRAME_simulador.vazao_volumetrica));
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Insira a vazão:");
        FRAME_barra_inferior.linha_3.MudaTexto("Confirme os dados inseridos:");
        FRAME_barra_inferior.linha_4.MudaTexto("Confirmar");

        this.estado++;
      }
      if (estado == 1) {
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 2) {
        FRAME_simulador.vazao_volumetrica = float(FRAME_barra_inferior.linha_2.RetornaTexto());
        this.Setup("Vazio");
        FRAME_menu_superior.editar_fluxo.clicado = false;
      }
    } else if (template == "Editar Material") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("LL");
        FRAME_barra_inferior.linha_2.CarregaLista("Materiais");
        FRAME_barra_inferior.linha_2.MudaInicial(FRAME_simulador.material);
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Insira o nome do material dos tubos:");
        FRAME_barra_inferior.linha_3.MudaTexto("Confirme os dados inseridos:");
        FRAME_barra_inferior.linha_4.MudaTexto("Confirmar");

        this.estado++;
      }
      if (estado == 1) {

        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 2) {
        FRAME_simulador.material = FRAME_barra_inferior.linha_2.RetornaTexto();
        FRAME_simulador.rugosidade = float(data.rugosidade[FRAME_barra_inferior.linha_2.IndiceN()][1]);

        this.Setup("Vazio");
        FRAME_menu_superior.editar_material.clicado = false;
      }
    }
    if (template == "Selecionar") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("F");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Ferramenta: Selecionar");
        FRAME_barra_inferior.linha_2.MudaTexto("Primeiro");
        FRAME_barra_inferior.linha_3.MudaTexto("1. Selecione um dos reservatórios do projeto.");
        FRAME_barra_inferior.linha_4.MudaTexto("2. Com as setas do teclado selecione o objeto desejado.");
      }
    }
    if (template == "Calcular") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Ferramenta: Calcular");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("1. Selecione os 2 reservatórios.");
        FRAME_barra_inferior.linha_4.MudaTexto("2. O valor calculado será mostrado no Menu Superior.");
      }
    }
    if (template == "Simular") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Ferramenta: Simular");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("1. Aguarde o início da simulação");
        FRAME_barra_inferior.linha_4.MudaTexto("");
      }
    }
    if (template == "Anotar") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Ferramenta: Anotar");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("1. Clique na tela de visualização ou projeto e escreva uma anotação.");
        FRAME_barra_inferior.linha_4.MudaTexto("2. Com o botão direito do mouse é possivel criar uma linha.");
      }
    }
    if (template == "Editar Tubo Reto") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Reto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 1) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("TB");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Diâmetro do tubo:");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("");
        FRAME_barra_inferior.linha_4.MudaTexto("Proximo");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 2) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("TB");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto("Comprimento do tubo:");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("");
        FRAME_barra_inferior.linha_4.MudaTexto("Finalizar");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
    }
    if (template == "Editar Tubo Inclinado Horizontal") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Inclinado Horizontal");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 1) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Reto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
    }
    if (template == "Editar Tubo Inclinado Vertical") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Inclinado Vertical");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 1) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Reto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
    }
    if (template == "Editar Reservatorio Aberto") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Reservatorio Aberto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 1) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Reto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
    }
    if (template == "Editar Bomba Centrifuga") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Bomba Centrifuga");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
      if (estado == 1) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T+B");
        FRAME_barra_inferior.linha_1.MudaTexto(" : Tubo Reto");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("Para editar clique abaixo:");
        FRAME_barra_inferior.linha_4.MudaTexto("EDITAR");
        if (FRAME_barra_inferior.linha_4.RetornaValor() == true) {
          this.estado++;
        }
      }
    }
    if (template == "Erro: Reservatorios Não Selecionados") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Erro: Não foram selecionados 2 reservatórios!");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("");
        FRAME_barra_inferior.linha_4.MudaTexto("");
      }
    }
    if (template == "Erro: Reservatorios Não Fazem Parte Da Mesma Trilha") {
      if (estado == 0) {
        FRAME_barra_inferior.linha_1.MudaTipo("T");
        FRAME_barra_inferior.linha_2.MudaTipo("T");
        FRAME_barra_inferior.linha_3.MudaTipo("T");
        FRAME_barra_inferior.linha_4.MudaTipo("T");
        FRAME_barra_inferior.linha_1.MudaTexto("Erro: Os 2 reservatórios não estão interligados!");
        FRAME_barra_inferior.linha_2.MudaTexto("");
        FRAME_barra_inferior.linha_3.MudaTexto("");
        FRAME_barra_inferior.linha_4.MudaTexto("");
      }
    }
  }
}
class LinhaDinamica {

  String tipo = "ND"; // T+TB (texto + textbox) ; T (texto) ; CB (checkbox); T+B (texto + botao); T+BB (texto+ 2 botoes); TB (textBox); LL (listagem lateral)
  int R=50;
  int G=50;
  int B=50;

  int y=0;

  String texto="No meio do caminho tinha uma pedra.";

  //objetos adicionaveis
  CheckBox check_box = new CheckBox(10, 10, "");
  TextBox text_box = new TextBox(10, 10); 
  Botao botao = new Botao("dinamico", 10, 10, "", "");
  Botao botao_2 = new Botao("dinamico", 10, 10, "", "");
  ListaLateral lista_lateral = new ListaLateral(10, 10);

  LinhaDinamica(int novo_y) {

    this.y = novo_y;
  }
  void MudaTipo(String novo_tipo) {

    this.tipo = novo_tipo;
  }
  void CarregaLista(String lista) {

    this.lista_lateral.CarregaLista(lista);
  }
  void MudaInicial(String novo_texto) {

    this.lista_lateral.MudaInicial(novo_texto);
  }
  void MudaTexto(String novo_texto) {

    this.texto = novo_texto;
    if (this.tipo == "TB") {

      this.text_box.texto = this.texto;
    }
  }
  void Apaga() {

    this.texto = "";
    this.check_box.valor = false;
    this.text_box.texto = "";
    this.botao.pressionado = false;
    this.botao_2.pressionado = false;
    this.lista_lateral.iniciado = false;
  }
  void MudaCor(int RED, int GREEN, int BLUE) {

    this.R = RED;
    this.G = GREEN;
    this.B = BLUE;
  }
  int IndiceN() {
    return this.lista_lateral.IndiceN();
  }
  boolean RetornaValor() {

    if (this.tipo == "CB") {
      return this.check_box.Valor();
    } else if (this.tipo == "T+B") {
      return this.botao.Valor();
    } else {
      return false;
    }
  }
  String RetornaTexto() {
    if (this.tipo == "TB") {
      return this.text_box.Texto();
    } else if (this.tipo == "LL") {

      return this.lista_lateral.Texto();
    } else {
      return "";
    }
  }
  void Show(int y_relativo) {

    textSize(12);
    if (this.tipo.equals("T")) {

      fill(this.R, this.G, this.B);
      text(this.texto, 320, y_relativo+this.y);
    } else if (this.tipo.equals("T+B")) {
      this.botao.MudaXY(340, y_relativo+this.y);
      this.botao.MudaTexto(this.texto);
      this.botao.Show();
    } else if (this.tipo.equals("T+2B")) {
      this.botao.MudaXY(340, y_relativo+this.y-10);
      this.botao.MudaTexto(this.texto);
      this.botao.Show();
      this.botao.MudaXY(540, y_relativo+this.y-10);
      this.botao.MudaTexto(this.texto);
      this.botao.Show();
    } else if (this.tipo.equals("CB")) {

      this.check_box.MudaXY(340, y_relativo+this.y-10);
      this.check_box.MudaTexto(this.texto);
      this.check_box.Show();
    } else if (this.tipo.equals("TB")) {
      this.text_box.MudaXY(340, y_relativo+this.y-15);
      this.text_box.Show();
    } else if (this.tipo.equals("LL")) {
      this.lista_lateral.MudaXY(340, y_relativo+this.y);
      this.lista_lateral.Show();
    }
  }
}
class ListaLateral {

  int x;
  int y;

  String inicial;
  String atual;
  String[] lista = new String[100];
  int nOf_itens=0;
  int n=0;

  boolean mouse_em_cima_1 = false;
  boolean mouse_em_cima_2 = false;
  boolean pressionado_1 = false;
  boolean pressionado_2 = false;

  boolean iniciado = false;

  ListaLateral(int new_x, int new_y) {

    this.x = new_x;
    this.y = new_y;
  }
  void MudaXY(int novo_X, int novo_Y) {

    this.x = novo_X;
    this.y = novo_Y;
  }
  void MudaInicial(String novo_texto) {

    if (iniciado == false) {
      this.inicial = novo_texto;
      for (int a =0; a<this.nOf_itens; a++) {
        if (this.inicial.equals(this.lista[a])) {

          this.n = a;
      }
      }
      iniciado = true;
      
    }
  }
  void CarregaLista(String listagem) {

    if (listagem == "Materiais") {
      this.nOf_itens = data.material.length;
      for (int a=0; a<data.material.length; a++) {
        this.lista[a] = data.material[a][1];
      }
    } else if (listagem == "Fluidos") {
      this.nOf_itens = data.fluido.length;
      for (int a=0; a<data.fluido.length; a++) {
        this.lista[a] = data.fluido[a][1];
      }
    }
  }
  int IndiceN() {

    return this.n;
  }
  String Texto() {

    return this.lista[n];
  }
  void Show() {
    stroke(150, 150, 150);
    if (calculo.MouseIn(this.x-10, this.y-18, this.x+10, this.y+2)) {
      this.mouse_em_cima_1 = true;
      fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
    } else {
      this.mouse_em_cima_1 = false;

      fill(255, 255, 255);
    }
    if (mouse_em_cima_1 && mousePressed ) {
      this.pressionado_1 = true;
    } else if (this.pressionado_1) {
      this.n--;
      if (this.n<0) {

        this.n = 0;
      }
      this.pressionado_1 = false;
    }
    ellipse(this.x, this.y-8, 20, 20);
    triangle(this.x-5, this.y-8, this.x+5, this.y-5, this.x+5, this.y-11);
    if (calculo.MouseIn(this.x+220, this.y-18, this.x+240, this.y+2)) {
      this.mouse_em_cima_2 = true;
      fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
    } else {
      this.mouse_em_cima_2 = false;

      fill(255, 255, 255);
    }
    if (mouse_em_cima_2 && mousePressed ) {
      this.pressionado_2 = true;
    } else if (this.pressionado_2) {
      this.n++;
      if (this.n>this.nOf_itens-1) {

        this.n = this.nOf_itens-1;
      }
      this.pressionado_2 = false;
    }
    ellipse(this.x+230, this.y-8, 20, 20);
    triangle(this.x+235, this.y-8, this.x+225, this.y-5, this.x+225, this.y-11);
    fill(255, 255, 255);
    rect(this.x+15, this.y-18, 200, 20, 10);
    fill(150, 150, 150);
    textSize(16);
    text(this.lista[this.n], this.x+20, this.y-1);
  }
}
class Botao {

  String tipo;
  int x;
  int y;
  String texto=" ";

  String link_tarefa_a;
  String link_tarefa_b;

  int numero_de_letras;
  boolean mouse_em_cima = false;
  boolean clicado = false;
  boolean pressionado = false;

  Botao(String novo_tipo, int new_x, int new_y, String novo_link_tarefa_a, String novo_link_tarefa_b) {
    this.tipo = novo_tipo;
    this.x = new_x;
    this.y = new_y;
    this.link_tarefa_a = novo_link_tarefa_a;
    this.link_tarefa_b = novo_link_tarefa_b;
  }
  void MudaXY(int novo_X, int novo_Y) {

    this.x = novo_X;
    this.y = novo_Y;
  }
  void MudaTexto(String novo_texto) {

    this.texto = novo_texto;
  }
  boolean Valor() {

    if (this.pressionado) {

      return true;
    } else {

      return false;
    }
  }
  void Show() {


    if (this.tipo == "dinamico") {
      stroke(150, 150, 150);
      if (calculo.MouseIn(this.x, this.y-18, this.x+100, this.y+20)) {
        this.mouse_em_cima = true;
        fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
      } else {
        this.mouse_em_cima = false;
        fill(255, 255, 255);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } 
      rect(this.x, this.y-18, 100, 20, 10);
      fill(150, 150, 150);
      textSize(16);
      text(texto, this.x+5, this.y-1);
    }
    if (this.tipo == "inicial") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+400 && mouseY < this.y+200) {
        this.mouse_em_cima = true;
      } else {
        this.mouse_em_cima = false;
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } else {
        this.pressionado = false;
      }
      if (this.mouse_em_cima) {
        fill(25, 125, 255);
      } else {
        fill(0, 75, 225);
      }
      stroke(255, 255, 255);
      rect(this.x, this.y, 400, 200, 10); 

      fill(255, 255, 255);

      this.numero_de_letras = this.texto.length();
      textSize(600/this.numero_de_letras);
      text(this.texto, this.x+50, this.y+(50/this.numero_de_letras)+120);
    }
    if (this.tipo == "normal_1") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+60 && mouseY < this.y+60) {
        this.mouse_em_cima = true;
      } else {
        this.mouse_em_cima = false;
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);
      fill(50, 50, 50);
      rect(this.x, this.y, 60, 60, 10);
    }
    if (this.tipo == "fechar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+30 && mouseY < this.y+20) {
        this.mouse_em_cima = true;
        fill(255, 0, 0);
      } else {
        this.mouse_em_cima = false;
        fill(100, 0, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 30, 20, 5);
      fill(255, 255, 255);
      textSize(15);
      text("X", this.x+10, this.y+15);
    }
    if (this.tipo == "confirmar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+120 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(0, 255, 0);
      } else {
        this.mouse_em_cima = false;
        fill(0, 100, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 120, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Confirmar", this.x+10, this.y+25);
    }
    if (this.tipo == "editar") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+80 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(0, 255, 0);
      } else {
        this.mouse_em_cima = false;
        fill(0, 100, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 80, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Editar", this.x+10, this.y+25);
    }
    if (this.tipo == "excluir") {
      if (mouseX > this.x && mouseY > this.y && mouseX < this.x+80 && mouseY < this.y+30) {
        this.mouse_em_cima = true;
        fill(255, 0, 0);
      } else {
        this.mouse_em_cima = false;
        fill(100, 0, 0);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }

      stroke(255, 255, 255);

      rect(this.x, this.y, 80, 30, 5);
      fill(255, 255, 255);
      textSize(20);
      text("Excluir", this.x+10, this.y+25);
    }
    if (this.tipo == "EditarMenuSuperior") {
      this.texto = this.link_tarefa_b;
      if (calculo.MouseIn(this.x, this.y, this.x+180, this.y+30)) {
        this.mouse_em_cima = true;
        fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
      } else {
        this.mouse_em_cima = false;
        fill(255, 255, 255);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
        if (this.clicado) {
          this.clicado = false;
          FRAME_barra_inferior.InstalaTemplate("Vazio");
        } else {
          FRAME_menu_superior.editar_ambiente.clicado = false;
          FRAME_menu_superior.editar_fluido.clicado = false;
          FRAME_menu_superior.editar_fluxo.clicado = false;
          FRAME_menu_superior.editar_material.clicado = false;
          this.clicado = true;
        }
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }
      stroke(150, 150, 150);
      if (this.clicado) {
        stroke(0, 0, 0);
        fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
      }

      rect(this.x, this.y, 180, 30, 10);
      fill(150, 150, 150);
      if (this.clicado) {
        fill(0, 0, 0);
      }
      textSize(20);
      text(texto, this.x+10, this.y+23);
    }
    if (this.tipo == "FerramentasMenuSuperior") {
      this.texto = this.link_tarefa_b;
      stroke(150, 150, 150);
      if (calculo.MouseIn(this.x, this.y, this.x+100, this.y+100)) {
        this.mouse_em_cima = true;
        fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
      } else {
        this.mouse_em_cima = false;
        fill(255, 255, 255);
      }
      if (mouse_em_cima && mousePressed ) {
        this.pressionado = true;
      } else if (this.pressionado) {
        gerenciador.Tarefa(this.link_tarefa_b);
        this.pressionado = false;
        if (this.clicado) {
          this.clicado = false;
          FRAME_barra_inferior.InstalaTemplate("Vazio");
          FRAME_simulador.selecionando = false;
          FRAME_simulador.selecionando_2 = false;
          FRAME_simulador.anotando = false;
          controladora.Selecionar(-1);
        } else {
          FRAME_menu_superior.ferramenta_selecionar.clicado = false;
          FRAME_menu_superior.ferramenta_calcular.clicado = false;
          FRAME_menu_superior.ferramenta_simular.clicado = false;
          FRAME_menu_superior.ferramenta_anotar.clicado = false;
          this.clicado = true;
        }
      } 
      if (this.mouse_em_cima) {
        gerenciador.Tarefa(this.link_tarefa_a);
      }
      if (this.clicado) {
        fill(200+(mouseX%20), 200+(mouseY%20), 200+((mouseX+mouseY)%20));
        stroke(0, 0, 0);
      }
      rect(this.x, this.y, 100, 100, 10);
      fill(150, 150, 150);
      if (this.clicado) {
        fill(0, 0, 0);
      }  
      textSize(16);
      text(texto, this.x+10, this.y+95);

      //imagens
      if (this.link_tarefa_b=="  Simular") {
        fill(150, 150, 150);
        if (this.clicado) {
          fill(0, 0, 0);
        }
        triangle(1075, 35, 1075, 85, 1125, 60);
      }
      if (this.link_tarefa_b=="  Calcular") {
        textSize(40);
        fill(150, 150, 150);
        if (this.clicado) {
          fill(0, 0, 0);
        }
        text("+ x", 955, 50);
        text("% -", 960, 90);
      }
      if (this.link_tarefa_b=="   Anotar") {
        fill(150, 150, 150);
        if (this.clicado) {
          fill(0, 0, 0);
          stroke(0, 0, 0);
        }

        rect(1185, 40, 40, 50);
        fill(255, 255, 255);
        rect(1195, 30, 40, 50);
        for (int a=0; a<7; a++) {
          line(1200, 35+a*5, 1230, 35+a*5);
        }
      }
      if (this.link_tarefa_b=="Selecionar") {
        fill(150, 150, 150);
        if (this.clicado) {
          fill(0, 0, 0);
          stroke(0, 0, 0);
        }

        beginShape();
        vertex(910, 30);
        vertex(910, 60);
        vertex(885, 55);
        vertex(870, 70);
        vertex(855, 55);
        vertex(875, 45);
        vertex(855, 30);

        endShape();
      }
    }
  }
}
class CheckBox {

  int x;
  int y;
  boolean valor=false;
  String texto = "Null";

  boolean mouse_em_cima=false;
  boolean pressionado=false;


  CheckBox(int novo_x, int novo_y, String novo_texto) {
    this.x = novo_x;
    this.y = novo_y;
    this.texto = novo_texto;
  }
  CheckBox(int novo_x, int novo_y, String novo_texto, boolean novo_valor) {
    this.x = novo_x;
    this.y = novo_y;
    this.texto = novo_texto;
    this.valor = novo_valor;
  }
  boolean Valor() {

    return this.valor;
  }
  void MudaTexto(String novo_texto) {
    this.texto = novo_texto;
  }
  void MudaXY(int novo_x, int novo_y) {
    this.x = novo_x;
    this.y = novo_y;
  }
  void Show() {
    fill(255, 255, 255);
    stroke(200, 200, 200);
    rect(this.x, this.y, 10, 10);
    textSize(10);
    fill(0, 0, 0);
    text(this.texto, this.x+20, this.y+10);
    if (this.valor==true) {
      fill(0, 255, 0); 
      ellipse(this.x+5, this.y+5, 4, 4);
    }
    if (mouseX > this.x && mouseY > this.y && mouseX < this.x+10 && mouseY < this.y+10) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
    }
    if (mouse_em_cima && mousePressed ) {
      this.pressionado = true;
    } else if (this.pressionado) {
      if (this.valor==true) {
        this.valor = false;
      } else {
        this.valor = true;
      }
      this.pressionado = false;
    } 
    if (this.mouse_em_cima) {
      fill(0, 100, 0); 
      ellipse(this.x+5, this.y+5, 4, 4);
    }
  }
}
class TextBox {

  int x;
  int y;
  String texto = "...";

  boolean habilitado=false;
  boolean mouse_em_cima=false;
  boolean pressionado=false;

  void Limpar() {

    this.texto = "...";
  }
  TextBox(int novo_x, int novo_y) {
    this.x = novo_x;
    this.y = novo_y;
  }

  void MudaTexto(String novo_texto) {

    this.texto = novo_texto;
  }
  void MudaXY(int novo_X, int novo_Y) {

    this.x = novo_X;
    this.y = novo_Y;
  }
  String Texto() {

    return this.texto;
  }
  void Show() {
    fill(255, 255, 255);
    stroke(200, 200, 200);
    rect(this.x, this.y, 150, 20);
    textSize(14);
    fill(0, 0, 0);
    text(this.texto, this.x+10, this.y+17);
    if (mouseX > this.x && mouseY > this.y && mouseX < this.x+150 && mouseY < this.y+20) {
      this.mouse_em_cima = true;
    } else {
      this.mouse_em_cima = false;
      this.habilitado = false;
    }
    if (mouse_em_cima && mousePressed ) {
      this.pressionado = true;
    } else if (this.pressionado) {
      this.pressionado = false;

      this.habilitado = true;

      this.texto = "";
      interfaceX.DeletaString();
    } 
    if (this.mouse_em_cima) {
      fill(255, 255, 255);
      stroke(0, 200, 0);
      rect(this.x, this.y, 150, 20);
      textSize(14);
      fill(0, 0, 0);
      if (this.habilitado) {
        this.texto = interfaceX.RetornaString();
      }
      text(this.texto, this.x+10, this.y+17);
    }
  }
}