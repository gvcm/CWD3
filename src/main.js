var definition = {
  "software":    "Software",
  "reference":   "Referência",
  "group":       "Grupo",
  "score":       "Pontuação",
  "scoreN":      "Pontuação Normalizada",
  "score1":      "Pontuação Critério 1",
  "score1N":     "Pontuação Critério 1 Normalizada",
  "score2":      "Pontuação Critério 2",
  "score2N":     "Pontuação Critério 2 Normalizada",
  "score3":      "Pontuação Critério 3",
  "score3N":     "Pontuação Critério 3 Normalizada",
  "score4":      "Pontuação Critério 4",
  "score4N":     "Pontuação Critério 4 Normalizada",
  "score5":      "Pontuação Critério 5",
  "score5N":     "Pontuação Critério 5 Normalizada",
  "1_2_3":       "1.2.3 Frequência de Atualização",
  "1_3_1":       "1.3.1 Plataforma de Desenvolvimento",
  "1_3":         "1.3 Portabilidade da Aplicação",
  "1_5_1":       "1.5.1 Licença de Uso, Distribuição e Modificação",
  "1_5_2":       "1.5.2 Modelo de Desenvolvimento Colaborativo",
  "1_6_1":       "1.6.1 Dispositivos Base (HID)",
  "1_6_2":       "1.6.2 Dispositivos Avançados de Interação",
  "2_1":         "2.1 Método de Síntese",
  "2_2":         "2.2 Processo de Síntese Interativo",
  "2_3":         "2.3 Restrição ou Limitação no Processo",
  "2_4":         "2.4 Seleção e Edição De Átomos Interativas",
  "3_1_1":       "3.1.1 Modelo de Representação Atômico Molecular",
  "3_1_2":       "3.1.2 Modelo de Representação da Célula Unitária",
  "3_1_3":       "3.1.3 Planos de Miller",
  "3_1_4":       "3.1.4 Direções de Miller",
  "3_1_5_1":     "3.1.5.1 Células Múltiplas",
  "3_1_5_2":     "3.1.5.2 Cortes",
  "3_1_5_3":     "3.1.5.3 Vetores de Eixos",
  "3_1_5_4":     "3.1.5.4 Outros Recursos Auxiliares",
  "3_2_1":       "3.2.1 Recursos de Percepção Visual",
  "3_2_2":       "3.2.2 Tipo de Projeção",
  "3_2_3":       "3.2.3 Suporte Estereográfico",
  "3_2_4":       "3.2.4 Modos de Renderização",
  "4_1":         "4.1 Interface",
  "4_2":         "4.2 Interação Base",
  "4_3_1":       "4.3.1 Rotações automáticas",
  "4_3_2":       "4.3.2 Animações guiadas",
  "4_3_3":       "4.3.3 Transição de Escala",
  "4_3_4":       "4.3.4 Gerenciamento dinâmico de oclusões",
  "4_3_5":       "4.3.5 Perspectiva / Pontos de Vista Pré-configurado",
  "5_1":         "5.1 Conhecimentos Requeridos do Usuário",
  "5_2_1":       "5.2.1 Suporte à visualização / Portabilidade externa",
  "5_2_2":       "5.2.2 Suporte à impressão 2D",
  "5_2_3":       "5.2.3 Suporte à impressão 3D",
  "5_2_4":       "5.2.4 Plataforma de Publicação na Internet",
  "5_3_1":       "5.3.1 Suporte à narrativa didática (Salvar preset didático integrado)",
  "5_3_2":       "5.3.2 Biblioteca de estruturas cristalográficas",
  "5_3_3":       "5.3.3 Construção e Visualização Incremental de Estruturas",
  "5_4_1":       "5.4.1 Suporte",
  "5_4_2":       "5.4.2 Documentação",
  "description": "Descrição",
  "link":        "Link"
};


var $view = $('#view');
var viewWidth = $view.width();
var viewCenterH = viewWidth / 2.0;
var viewHeight = $(window).height() - $view.position().top;
var viewCenterV = viewHeight / 2.0;

var svg = d3.select('#view').append('svg');
svg.attr('width', viewWidth);
svg.attr('height', viewHeight);

var nodeScale = d3.scale.sqrt();
nodeScale.domain([0, 100]);
nodeScale.range([5, 5 + (Math.sqrt(100 / Math.PI) * 10)]);

var nodes = [];

var fillColor = d3.scale.ordinal()
  .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
  .range(['#d3372c', '#2767b3', '#85898f', '#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a']);

var force;
var groups;
var specGroup;

var slice = viewWidth / 15;
var groupAlignH = {
  'CW': slice * 5,
  'T':  slice * 6,
  'L':  slice * 7,
  'F2': slice * 8,
  'F1': slice * 9,
  'Z':  slice * 10,
  'C':  slice * 11,
  'D':  slice * 12
};

var createRecord = function(row) {
  var scoreN = parseInt(row.scoreN);
  return {
    radius: nodeScale(scoreN),
    value: scoreN,
    reference: row.reference,
    group: row.group ? row.group : 'default',
    x: Math.random() * viewWidth,
    y: Math.random() * viewHeight
  };
};

var createNode = function(row) {
  nodes.push(createRecord(row));
};

var nodeCharge = function(d) {
  return -Math.pow(d.radius, 2.0) / 3;
};

var nodeChargeGroup = function(d) {
  return -Math.pow(d.radius, 2.0);
};

var clusterAll = function(alpha) {
  return function(d) {
    d.x = d.x + (viewCenterH - d.x) * (alpha / 70);
    d.y = d.y + (viewCenterV - d.y) * (alpha / 70);
  };
};

var clusterGroup = function(alpha) {
  return function(d) {
    var targetH = groupAlignH[d.group];
    d.x = d.x + (targetH - d.x) * alpha;
    d.y = d.y + (viewCenterV - d.y) * (alpha / 2);
  };
};

d3.csv('data/research.csv', function(data) {

  var specRecord = createRecord(data.shift());
  var spec = svg.selectAll('.spec').data([specRecord]);
  specGroup = spec.enter().append('g')
    .attr('opacity', 0)
    .attr('transform', "translate(" + (viewWidth / 2.0) + "," + (viewHeight / 2.0) + ")");

  var specCircle = specGroup.append('circle')
    .attr('r', 0)
    .attr("fill", '#ccc')
    .attr("stroke-width", 2)
    .attr("stroke", '#aaa');
  specCircle.transition().duration(3000).attr('r', function(d) { return d.radius; });      
  
  specGroup.append('text')
    .attr("dx", "0")
    .attr("dy", "5")
    .attr('text-anchor', 'middle')
    .text('100');

  specGroup.transition().duration(3000)
    .attr('opacity', 0.9)
    .attr('transform', "translate(" + (viewWidth / 3 * 2) + "," + (viewHeight / 2 + 5) + ")");

  data.forEach(createNode);

  var containers = svg.selectAll('.containers').data(nodes);
  groups = containers.enter().append('g')
    .attr('opacity', 0);
  
  var circles = groups.append('circle')
    .attr('r', 0)
    .attr("fill", function(d) { return fillColor(d.group); })
    .attr("stroke-width", 2)
    .attr("stroke", function(d) { return d3.rgb(fillColor(d.group)).darker() });

  var labels = groups.append('text')
    .attr("dx", "0")
    .attr("dy", "5")
    .attr('text-anchor', 'middle')
    .text(function(d) { return d.reference; });

  circles.transition().duration(3000).attr('r', function(d) { return d.radius; });    
  containers.exit().remove();
  
  force = d3.layout.force();
  force.nodes(nodes);
  force.size([viewWidth / 4.0 * 3.0, viewHeight]);
  force.charge(nodeCharge);
  force.gravity(0.2);

  var show = false;
  force.on('tick', function(e) {
    if(e.alpha < 0.09 && e.alpha > 0.04) {
      if(show==false) {
        groups.transition().duration(2000).attr('opacity', 0.9);
        show = true;
      }
      groups.each(clusterAll(e.alpha));
      groups.attr('transform', function(d, i) {
        return "translate(" + d.x + "," + d.y + ")";
      });      
    }
  });
  force.start();

});

$('#all').click(function() {
  
});

$('#group').click(function() {

  force.charge(nodeChargeGroup);
  force.gravity(0);

  force.on('tick', function(e) {
    groups.each(clusterGroup(e.alpha));
    groups.attr('transform', function(d, i) {
      return "translate(" + d.x + "," + d.y + ")";
    });      
  });
  force.start();

  specGroup.transition().duration(1000)
    .attr('transform', "translate(" + (viewWidth / 6) + "," + viewCenterV + ")");

});

$('#criteria').click(function() {
  
});