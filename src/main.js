var definition = {
  "software": "Software",
  "reference": "Referência",
  "group": "Grupo",
  "score": "Pontuação",
  "scoreN": "Pontuação Normalizada",
  "score1": "Pontuação Critério 1",
  "score1N": "Pontuação Critério 1 Normalizada",
  "score2": "Pontuação Critério 2",
  "score2N": "Pontuação Critério 2 Normalizada",
  "score3": "Pontuação Critério 3",
  "score3N": "Pontuação Critério 3 Normalizada",
  "score4": "Pontuação Critério 4",
  "score4N": "Pontuação Critério 4 Normalizada",
  "score5": "Pontuação Critério 5",
  "score5N": "Pontuação Critério 5 Normalizada",
  "1_2_3": "1.2.3 Frequência de Atualização",
  "1_3_1": "1.3.1 Plataforma de Desenvolvimento",
  "1_3": "1.3 Portabilidade da Aplicação",
  "1_5_1": "1.5.1 Licença de Uso, Distribuição e Modificação",
  "1_5_2": "1.5.2 Modelo de Desenvolvimento Colaborativo",
  "1_6_1": "1.6.1 Dispositivos Base (HID)",
  "1_6_2": "1.6.2 Dispositivos Avançados de Interação",
  "2_1": "2.1 Método de Síntese",
  "2_2": "2.2 Processo de Síntese Interativo",
  "2_3": "2.3 Restrição ou Limitação no Processo",
  "2_4": "2.4 Seleção e Edição De Átomos Interativas",
  "3_1_1": "3.1.1 Modelo de Representação Atômico Molecular",
  "3_1_2": "3.1.2 Modelo de Representação da Célula Unitária",
  "3_1_3": "3.1.3 Planos de Miller",
  "3_1_4": "3.1.4 Direções de Miller",
  "3_1_5_1": "3.1.5.1 Células Múltiplas",
  "3_1_5_2": "3.1.5.2 Cortes",
  "3_1_5_3": "3.1.5.3 Vetores de Eixos",
  "3_1_5_4": "3.1.5.4 Outros Recursos Auxiliares",
  "3_2_1": "3.2.1 Recursos de Percepção Visual",
  "3_2_2": "3.2.2 Tipo de Projeção",
  "3_2_3": "3.2.3 Suporte Estereográfico",
  "3_2_4": "3.2.4 Modos de Renderização",
  "4_1": "4.1 Interface",
  "4_2": "4.2 Interação Base",
  "4_3_1": "4.3.1 Rotações automáticas",
  "4_3_2": "4.3.2 Animações guiadas",
  "4_3_3": "4.3.3 Transição de Escala",
  "4_3_4": "4.3.4 Gerenciamento dinâmico de oclusões",
  "4_3_5": "4.3.5 Perspectiva / Pontos de Vista Pré-configurado",
  "5_1": "5.1 Conhecimentos Requeridos do Usuário",
  "5_2_1": "5.2.1 Suporte à visualização / Portabilidade externa",
  "5_2_2": "5.2.2 Suporte à impressão 2D",
  "5_2_3": "5.2.3 Suporte à impressão 3D",
  "5_2_4": "5.2.4 Plataforma de Publicação na Internet",
  "5_3_1": "5.3.1 Suporte à narrativa didática (Salvar preset didático integrado)",
  "5_3_2": "5.3.2 Biblioteca de estruturas cristalográficas",
  "5_3_3": "5.3.3 Construção e Visualização Incremental de Estruturas",
  "5_4_1": "5.4.1 Suporte",
  "5_4_2": "5.4.2 Documentação",
  "description": "Descrição",
  "link": "Link"
};

var $view = $('#view');
var viewWidth = $view.width();
var viewHeight = $(window).height() - $view.position().top;

var svg = d3.select('#view').append('svg');
svg.attr('width', viewWidth);
svg.attr('height', viewHeight);

var nodeScale = d3.scale.sqrt();
nodeScale.domain([0, 100]);
nodeScale.range([0, Math.sqrt(100 / Math.PI) * 10]);

var nodes = [];
var createNode = function(row) {
  var scoreN = parseInt(row.scoreN);
  var node = {
    radius: nodeScale(scoreN),
    value: scoreN,
    x: Math.random() * viewWidth,
    y: Math.random() * viewHeight
  };
  nodes.push(node);
}

d3.csv('data/research.csv', function(data) {

  var specification = data.shift();

  data.forEach(createNode);
  
  var circles = svg.selectAll('circle').data(nodes);
  circles.enter().append('circle')
    .attr('r', 10);
  
  circles
    .attr('cx', function(d) { return d.x; })
    .attr('cy', function(d) { return d.y; })
    .attr('r', function(d) { return d.radius; });
    
  circles.exit().remove();

});