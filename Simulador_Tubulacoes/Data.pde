Data data = new Data();

class Data {

  String materiais_lines[];
  String materiais_string;
  String fluidos_lines[];
  String fluidos_string;
  //materiais : file
  String material[][];
  String rugosidade[][];

  //convecções :file
  String fluido[][];
  String viscosidade[][];
  String massa_especifica[][];

  //para tmp
  int cte=10;
  String[] dados = new String[this.cte];
  int pontos=0;
  
  void ImprimeMateriais() {

    for (int i = 0; i < this.materiais_lines.length; i++) {

      println(this.materiais_lines[i]);
    }
    for(int a =0;a<this.fluido.length;a++){
        println(this.fluido[a][1]);
        println(this.viscosidade[a][1]);
        println(this.massa_especifica[a][1]);
    }
  }

  void GetMateriais() {

    this.materiais_string = join(materiais_lines, " ");

    this.material = matchAll(this.materiais_string, "material = \"(.*?)\";");
    this.rugosidade = matchAll(this.materiais_string, "rugosidade = \"(.*?)\";");

  }
  void GetFluidos() {

    this.fluidos_string = join(fluidos_lines, " ");

    this.fluido = matchAll(this.fluidos_string, "fluido = \"(.*?)\";");
    this.viscosidade = matchAll(this.fluidos_string, "viscosidade = \"(.*?)\";");
    this.massa_especifica = matchAll(this.fluidos_string, "massa_especifica = \"(.*?)\";");
  }


  //saveStrings("data.txt",this.new_data_lines); se precisar um dia
}