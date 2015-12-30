var columnDefinition = {
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

var groupDefinitions = {
  'CW': 'CrystalWalk',
  'T':  'T - Tested',
  'L':  'L - Licence not provided',
  'F2': 'F2 - Out of scope',
  'F1': 'F1 - Out of scope',
  'Z':  'Others',
  'C':  'C - Discontinued',
  'D':  'D - Duplicated'
};

var scoreDefinitions = {
  "scoreN": "TOTAL",
  "score1N": "Score 1",
  "score2N": "Score 2",
  "score3N": "Score 3",
  "score4N": "Score 4",
  "score5N": "Score 5"
};

var scoreReferenceDefinitions = {
  '0': '0',
  '1': '1',
  '2': '2',
  '3': '3',
  '4': '4',
  '5': '5',
  '6': '6',
  '7': '7',
  '8': '8',
  '9': '9',
  '10': '10',
  '11': '11',
  '12': '12',
  '13': '13',
  '14': '14',
  '15': '15',
  '16': '16',
  '17': '17',
  '18': '18',
  '19': '19',
  '20': '20',
  '21': '21',
  '22': '22',
  '23': '23',
  '24': '24',
  '25': '25',
  '26': '26'
};

var $view = $('#view');
var viewWidth = $(window).width();
var viewCenterH = viewWidth / 2.0;
var viewHeight = $(window).height();
var viewCenterV = viewHeight / 2.0;

// var tooltip = CustomTooltip("cwd3-tooltip", 240);

var svg = d3.select('#view').append('svg')
  .attr('width', viewWidth)
  .attr('height', viewHeight);

var nodeScale = d3.scale.sqrt()
  .domain([0, 100])
  .range([5, 5 + (Math.sqrt(100 / Math.PI) * 10)]);

var fillColor = d3.scale.ordinal()
  .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
  .range(['#d3372c', '#2767b3', '#85898f', '#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a']);

var sliceH = viewWidth / 15;
var groupAlignH = d3.scale.ordinal()
  .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
  .rangePoints([sliceH * 5, sliceH * 12]);
var groupAlignHFix = d3.scale.ordinal()
  .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
  .range([0.83, 0.95, 1.005, 0.99, 1.013, 1.05, 1.07, 1.06]);

var nodes = [];
var force;
var groups;
var specGroup;
var dataGroupSpecLabel;
var dataGroupLabels;

var fillScoreColumn = d3.scale.ordinal()
  .domain([1, 2, 3, 4, 5])
  .range(['#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a']);

var scoreNodes = [];
var scoreGroups = [];
var scoreGroupLabels;
var scoreReferenceLabels;

var criteriaKeys = ['1_2_3','1_3_1','1_3','1_5_1','1_5_2','1_6_1','1_6_2','2_1','2_2','2_3','2_4','3_1_1','3_1_2','3_1_3','3_1_4','3_1_5_1','3_1_5_2','3_1_5_3','3_1_5_4','3_2_1','3_2_2','3_2_3','3_2_4','4_1','4_2','4_3_1','4_3_2','4_3_3','4_3_4','4_3_5','5_1','5_2_1','5_2_2','5_2_3','5_2_4','5_3_1','5_3_2','5_3_3','5_4_1','5_4_2'];
var criteriaKeysLength = criteriaKeys.length;

fillReference = d3.scale.ordinal()
  .domain(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26'])
  .range(['#d3372c', '#3b675f', '#518534', '#3cc242', '#8faa52', '#897797', '#8e3846', '#64a9b2', '#a6bd78', '#7a865c', '#547d69', '#517238', '#694087', '#7964b2', '#a08da7', '#387cbf', '#7ec780', '#c5644f', '#79b849', '#6d9e94', '#74694d', '#784e64', '#b39947', '#c2646b', '#506e68', '#798b54', '#3ba555']);

var criteriaNodes = [];
var criteriaForce;
var criteriaGroups = [];

/* ===== FUNCTIONS ===== */

// var showTooltip = function(d, i, element) {
//   d3.select(element).attr('stroke-before', d3.select(element).attr('stroke'));
//   var content = '<span class="name">Software:</span><span class="value"> #{d.name}</span><br/>';
//   tooltip.showTooltip(content, d3.event);
//   console.log('show');
// };
// 
// var hideTooltip = function(d, i, element) {
//   d3.select(element).attr("stroke", d3.select(element).attr('stroke-before'));
//   tooltip.hideTooltip();
//   console.log('hide');
// };

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
    var targetH = groupAlignH(d.group);
    d.x = d.x + (targetH - d.x) * (alpha / 0.5);
    d.y = d.y + (viewCenterV - d.y) * (alpha / 2);
  };
};

var explode = function(alpha) {
  return function(d) {
    if(d.x > viewWidth + 500)  { d.x = viewWidth + 500; }
    if(d.x < -500)             { d.x = -500; }
    if(d.y > viewHeight + 500) { d.y = viewHeight + 500; }
    if(d.y < -500)             { d.y = -500; }
  };
};

var createScoreRecord = function(row) {
  var scoreN = parseFloat(row.scoreN);
  var score1N = parseFloat(row.score1N);
  var score2N = parseFloat(row.score2N);
  var score3N = parseFloat(row.score3N);
  var score4N = parseFloat(row.score4N);
  var score5N = parseFloat(row.score5N);

  return {
    radius: scoreN > 0 ? nodeScale(scoreN) : 0, /* hide score zero */
    value: scoreN,
    breakdown: [
      { radius: (score1N > 0 ? nodeScale(score1N) : 0), value: score1N },
      { radius: (score2N > 0 ? nodeScale(score2N) : 0), value: score2N },
      { radius: (score3N > 0 ? nodeScale(score3N) : 0), value: score3N },
      { radius: (score4N > 0 ? nodeScale(score4N) : 0), value: score4N },
      { radius: (score5N > 0 ? nodeScale(score5N) : 0), value: score5N }
    ],
    reference: row.reference,
    x: Math.random() * viewWidth,
    y: Math.random() * viewHeight
  };
};

var createScoreNodes = function(row) {
  if(row.reference) {
    scoreNodes.push(createScoreRecord(row));
  }
};

var tableizeScoreGroups = function(d, i) {
  var refNum = parseInt(d.reference);
  var posH;
  var posV;

  posH = (viewWidth * 0.25);
  posV = 100 * (i+1) + 100;
  
  if(posV > viewHeight) {
    svg.attr('height', posV + (viewHeight / 3));
  }
  
  return "translate(" + posH + "," + posV + ")";
};

var createCriteriaRecord = function(scoreN, criteria, reference) {
  return {
    radius: nodeScale(scoreN),
    criteria: criteria,
    reference: reference,
    x: Math.random() * viewWidth,
    y: Math.random() * viewHeight
  }
};

var createCriteriaRecords = function(row) {
  var criteria;
  var scoreN;
  var records = [];

  if(!row.reference) {
    throw "error: row without reference!";
  }

  for(var j=0; j<=criteriaKeysLength; j++) {
    criteria = criteriaKeys[j];
    scoreN = parseInt(row['scoreN']);
    if (parseInt(row[criteria]) == 1) { /* match criteria */
      records.push(createCriteriaRecord(scoreN, criteria, row.reference));
    }
  }

  return records;
};

var createCriteriaNodes = function(row) {
  if(row.reference) {
    var criteriaRecords = createCriteriaRecords(row);
    var recordsLength = criteriaRecords.length;
    for(var j=0; j<recordsLength; j++) {
      criteriaNodes.push(criteriaRecords[j]);
    }    
  }
};

var criteriaRadius = function(d) {
  return d.radius;
};

var criteriaReferenceColor = function(d) {
  return fillReference(d.reference);
};

var criteriaStrokeColor = function(d) {
  return d3.rgb(criteriaReferenceColor(d)).darker();
};

var criteriaLabel = function(d) {
  return d.reference;
};

var criteriaGravity = function(alpha) {
  return function(d) {
    var criteriaIndex = criteriaKeys.indexOf(d.criteria);
    var numberOfColumns = 3;
    var spacingH = viewWidth / 2;
    var spacingV = (viewHeight / 6) * 5; 
    var groupSize = (viewWidth - spacingH) / numberOfColumns;
    var groupH = 0;
    var groupV = 0;
    var posH;
    var posV;

    if (criteriaIndex >= 0) {
      groupV = Math.floor(criteriaIndex / numberOfColumns);
      groupH = criteriaIndex % numberOfColumns;
    }
    
    posH = (spacingH / 1.5) + groupSize * groupH;
    posV = (spacingV / 2.0) + groupSize * groupV;
    
    if(posV > viewHeight) {
      svg.attr('height', posV + spacingV / 2.0);
    }

    d.x += (posH - d.x) * alpha;
    d.y += (posV - d.y) * alpha;    
  };
};

var criteriaNodeCharge = function(d) {
  return -Math.pow(d.radius, 2.0);
};

/* ===== DATA CALLBACK ===== */

d3.csv('data/research.csv', function(data) {

  /* ====== SPECIFICATION ====== */

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

  dataGroupSpecLabel = svg.append('text')
    .attr("x", 250)
    .attr("y", 100)
    .attr('text-anchor', 'middle')
    .attr('font-size', 30)
    .attr('fill', '#aaa')
    .attr('opacity', 0)
    .text('SPEC');

  /* ====== NODES ====== */

  data.forEach(createNode);

  var containers = svg.selectAll('.containers').data(nodes);
  groups = containers.enter().append('g')
    .attr('opacity', 0);
  
  var circles = groups.append('circle')
  // .attr('r', function(d) { return d.radius; })
    .attr('r', 0)
    .attr("fill", function(d) { return fillColor(d.group); })
    .attr("stroke-width", 2)
    // .style('pointer-events', 'none')
    // .attr('pointer-events', 'none')
    .attr("stroke", function(d) { return d3.rgb(fillColor(d.group)).darker() });

  // circles.on('mouseover', function(d){ d3.select(this).style("fill", "red"); });
  // circles.on('mouseenter', function(d){ d3.select(this).style("fill", "red"); });
  // circles.on('click', function(d){ d3.select(this).style("fill", "red"); });

  var labels = groups.append('text')
    .attr("dx", "0")
    .attr("dy", "5")
    .attr('text-anchor', 'middle')
    // .style('pointer-events', 'none')
    // .attr('pointer-events', 'none')
    .text(function(d) { return d.reference; });

  // groups.append('rect')
  //   .attr('width', function(d) { return d.radius * 2; })
  //   .attr('height', function(d) { return d.radius * 2; })
  //   .attr("x", function(d) { return -d.radius; })
  //   .attr("y", function(d) { return -d.radius; })
  //   .attr('fill', 'red')
  //   .attr('opacity', 0.75)
  //   .style('pointer-events', 'all')
  //   .attr('pointer-events', 'all')
  //   .on('mouseover', function(d){ d3.select(this).style("fill", "blue"); })
  //   .on('mouseenter', function(d){ d3.select(this).style("fill", "blue"); });

  // solution: maybe https://github.com/mbostock/d3/wiki/Selections#d3_mouse

  containers.exit().remove();

  circles.transition().duration(3000).attr('r', function(d) { return d.radius; });
  
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
  
  /* ====== GROUPS ====== */

  var dataGroupContainers = svg.selectAll('.data-groups').data(d3.entries(groupDefinitions));
  
  dataGroupLabels = dataGroupContainers.enter().append('text')
    .attr('x', function(d) { return groupAlignH(d.key) * groupAlignHFix(d.key); })
    .attr('y', 100)
    .attr('text-anchor', 'middle')
    .attr('font-size', '30')
    .attr('opacity', 0)
    .attr('fill', function(d) { return fillColor(d.key); })
    .text(function(d) { return d.key; });
    
  dataGroupContainers.exit().remove();
  
  // groups = containers.enter().append('g')
  //   .attr('opacity', 0);
  // 
  // var circles = groups.append('circle')
  // // .attr('r', function(d) { return d.radius; })
  //   .attr('r', 0)
  //   .attr("fill", function(d) { return fillColor(d.group); })
  //   .attr("stroke-width", 2)
  //   // .style('pointer-events', 'none')
  //   // .attr('pointer-events', 'none')
  //   .attr("stroke", function(d) { return d3.rgb(fillColor(d.group)).darker() });
  // 
  // 
  // specGroup.append('text')
  //   .attr("dx", "0")
  //   .attr("dy", "5")
  //   .attr('text-anchor', 'middle')
  //   .text('100');


  /* ====== SCORE NODES ====== */

  data.forEach(createScoreNodes);

  // console.log(scoreNodes[5]);
  // var xx = scoreNodes.order(function(a, b){ return d3.ascending(a.value, b.value); });
  // console.log(xx[5]);
  // debugger;
  
  // scoreNodes.sort(function(a, b) { return d3.ascending(a.value, b.value); })[100].value;
  
  scoreNodes.sort(function(a, b) { return d3.descending(a.value, b.value); });  
  var scoreContainers = svg.selectAll('.scores').data(scoreNodes);
  scoreGroups = scoreContainers.enter().append('g')
    .attr('opacity', 0);

  scoreGroups.append('circle')
    .attr('r', function(d) { return d.radius; })
    .attr('cx', 0)
    .attr('cy', 0)
    .attr("fill", function(d, i) { return (i==0?fillColor('CW'):fillColor('T')); })
    .attr("stroke-width", 2)
    .attr("stroke", function(d, i) { return d3.rgb((i==0?fillColor('CW'):fillColor('T'))).darker(); });

  for(j=0;j<5;j++) {
    scoreGroups.append('circle')
      .attr('r', function(d) { return d.breakdown[j].radius; })
      .attr('cx', ((j+1)*(viewWidth / 12)) + viewWidth/12)
      .attr('cy', 0)
      .attr("fill", function(d) { return fillScoreColumn(j+1); })
      .attr("stroke-width", 2)
      .attr("stroke", function(d) { return d3.rgb(fillScoreColumn(j+1)).darker(); });

    scoreGroups.append('text')
      .attr('dx', ((j+1)*(viewWidth / 12)) + viewWidth/12)
      .attr("dy", "5")
      .attr('text-anchor', 'middle')
      .text(function(d) { return d.breakdown[j].value > 0 ? d.breakdown[j].value : ''; });
  }

  scoreGroups.append('text')
    .attr("dx", "0")
    .attr("dy", "5")
    .attr('text-anchor', 'middle')
    .text(function(d) { return d.value > 0 ? d.value : ''; });

  scoreContainers.exit().remove();

  scoreGroups.attr('transform', function(d, i) {
    return "translate(" + d.x + "," + d.y + ")";
  });
  
  var scoreGroupLabelContainer = svg.selectAll('.score-group-labels').data(d3.entries(scoreDefinitions));
  
  scoreGroupLabels = scoreGroupLabelContainer.enter().append('text')
    .attr('x', function(d, i) { return (viewWidth * 0.25) + ((i)*(viewWidth / 12)) + (i>0 ? (viewWidth/12) : 0); })
    .attr('y', 100)
    .attr('text-anchor', 'middle')
    .attr('font-size', '30')
    .attr('opacity', 0)
    .attr('fill', function(d, i) { return i==0?'black':fillScoreColumn(i); })
    .text(function(d) { return d.value; });
    
  scoreGroupLabelContainer.exit().remove();

  var scoreReferenceLabelContainer = svg.selectAll('.score-reference-labels').data(d3.entries(scoreReferenceDefinitions));
  
  scoreReferenceLabels = scoreReferenceLabelContainer.enter().append('text')
    .attr('x', 200)
    .attr('y', function(d, i) { return 100 * (i+1) + 110; })
    .attr('text-anchor', 'middle')
    .attr('font-size', '20')
    .attr('opacity', 0)
    .text(function(d) { return "Referência " + d.value; });
    
  scoreReferenceLabelContainer.exit().remove();
  
  /* ====== CRITERIA NODES ====== */
  
  data.forEach(createCriteriaNodes);

  var criteriaContainers = svg.selectAll('.criterion').data(criteriaNodes);
  criteriaGroups = criteriaContainers.enter().append('g')
    .attr('opacity', 0);
  
  var criteriaCircles = criteriaGroups.append('circle')
    .attr('r', criteriaRadius)
    .attr("fill", criteriaReferenceColor)
    .attr("stroke-width", 2)
    .attr("stroke", criteriaStrokeColor);

  var criteriaLabels = criteriaGroups.append('text')
    .attr("dx", "0")
    .attr("dy", "5")
    .attr('text-anchor', 'middle')
    .text(criteriaLabel);

  criteriaContainers.exit().remove();  
  criteriaGroups.attr('transform', function(d, i) {
    return "translate(" + d.x + "," + d.y + ")";
  });

  criteriaForce = d3.layout.force()
    .nodes(criteriaNodes)
    .size([viewWidth, viewHeight])
    .gravity(0)
    .charge(criteriaNodeCharge);
});

/* ====== ALL BUTTON ====== */

$('#all').click(function() {

  dataGroupSpecLabel.transition().duration(1000)
    .attr('opacity', 0);
  dataGroupLabels.transition().duration(1000)
    .attr('opacity', 0);

  scoreGroups.transition().duration(1000)
    .attr('transform', function(d, i) {
      d.x = Math.random() * viewWidth;
      d.y = Math.random() * viewHeight;
      return "translate(" + d.x + "," + d.y + ")";
    })
    .attr('opacity', 0);
  scoreGroupLabels.transition().duration(1000)
    .attr('opacity', 0);
  scoreReferenceLabels.transition().duration(1000)
    .attr('opacity', 0);

  criteriaGroups.transition().duration(1000)
    .attr('opacity', 0);

  force.charge(nodeCharge);
  force.gravity(0.2);

  force.on('tick', function(e) {
    groups.each(clusterAll(e.alpha));
    groups.attr('transform', function(d, i) {
      return "translate(" + d.x + "," + d.y + ")";
    });      
  });
  force.start();

  groups.transition().duration(1000)
    .attr('opacity', 0.9);

  specGroup.transition().duration(1000)
    .attr('opacity', 0.9)
    .attr('transform', "translate(" + (viewWidth / 3 * 2) + "," + (viewHeight / 2 + 5) + ")");

  svg.attr('height', viewHeight);

});

/* ====== GROUP BUTTON ====== */

$('#group').click(function() {

  dataGroupSpecLabel.transition().duration(1000)
    .attr('opacity', 1);
  dataGroupLabels.transition().duration(1000)
    .attr('opacity', 1);

  scoreGroups.transition().duration(1000)
    .attr('transform', function(d, i) {
      d.x = Math.random() * viewWidth;
      d.y = Math.random() * viewHeight;
      return "translate(" + d.x + "," + d.y + ")";
    })
    .attr('opacity', 0);
  scoreGroupLabels.transition().duration(1000)
    .attr('opacity', 0);
  scoreReferenceLabels.transition().duration(1000)
    .attr('opacity', 0);

  criteriaGroups.transition().duration(1000)
    .attr('opacity', 0);
    
  force.charge(nodeChargeGroup);
  force.gravity(0);

  force.on('tick', function(e) {
    groups.each(clusterGroup(e.alpha));
    groups.attr('transform', function(d, i) {
      return "translate(" + d.x + "," + d.y + ")";
    });      
  });
  force.start();

  groups.transition().duration(1000)
    .attr('opacity', 0.9);    

  specGroup.transition().duration(1000)
    .attr('opacity', 0.9)
    .attr('transform', "translate(" + (viewWidth / 6) + "," + viewCenterV + ")");

});

/* ====== SCORE BUTTON ====== */

$('#score').click(function() {
  
  dataGroupSpecLabel.transition().duration(1000)
    .attr('opacity', 0);
  dataGroupLabels.transition().duration(1000)
    .attr('opacity', 0);
  
  groups.transition().duration(1000)
    .attr('opacity', 0);

  specGroup.transition().duration(1000)
    .attr('opacity', 0);

  criteriaGroups.transition().duration(1000)
    .attr('opacity', 0);
  
  force.gravity(-0.1);

  force.on('tick', function(e) {
    groups.each(explode(e.alpha));
    groups.attr('transform', function(d, i) {
      return "translate(" + d.x + "," + d.y + ")";
    });
  });
  force.start();
  
  scoreGroups.transition().duration(1000)
    .attr('opacity', 0.9)
    .attr('transform', tableizeScoreGroups);

  scoreGroupLabels.transition().duration(1000)
    .attr('opacity', 1);
  scoreReferenceLabels.transition().duration(1000)
    .attr('opacity', 1);

});

/* ====== SCORE BUTTON ====== */

$('#criteria').click(function() {
  
  dataGroupSpecLabel.transition().duration(1000)
    .attr('opacity', 0);
  dataGroupLabels.transition().duration(1000)
    .attr('opacity', 0);

  groups.transition().duration(1000)
    .attr('opacity', 0);

  specGroup.transition().duration(1000)
    .attr('opacity', 0);

  scoreGroups.transition().duration(1000)
    .attr('transform', function(d, i) {
      d.x = Math.random() * viewWidth;
      d.y = Math.random() * viewHeight;
      return "translate(" + d.x + "," + d.y + ")";
    })
    .attr('opacity', 0);
  scoreGroupLabels.transition().duration(1000)
    .attr('opacity', 0);
  scoreReferenceLabels.transition().duration(1000)
    .attr('opacity', 0);

  criteriaForce.on("tick", function(e) {
    criteriaGroups
      .each(criteriaGravity(e.alpha));
    criteriaGroups.attr('transform', function(d, i) {
      return "translate(" + d.x + "," + d.y + ")";
    });
  });
  criteriaForce.start();

  criteriaGroups.transition().duration(1000)
    .attr('opacity', 0.9);
});