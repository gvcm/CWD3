class Row
  constructor: (record) ->
    @scoreN = parseInt(record.scoreN, 10)
    @value = (Row.weightScale(@scoreN) + 1) # pack layout
    @score = []
    for num in [1..5]
      str = record['score' + num]
      if str.length == 0
        score = 0
      else
        score = parseInt(str, 10)
      @score[num - 1] = score
    @total = parseInt(record.score, 10)
    @title = record.software
    @group = record.group
    @description = record.description
    @link = record.link
    @criteriaKeys = []
    for k, _ of Row.criteriaMap
      @criteriaKeys.push(k) if record[k] == '1'
    @x = 0
    @y = 0

  @weightScale = d3.scale.pow().exponent(0.8)

  @criteriaMap =
    '1_2_3':   '1.2.3 Frequência de Atualização'
    '1_3_1':   '1.3.1 Plataforma de Desenvolvimento'
    '1_3':     '1.3 Portabilidade da Aplicação'
    '1_5_1':   '1.5.1 Licença de Uso, Distribuição e Modificação'
    '1_5_2':   '1.5.2 Modelo de Desenvolvimento Colaborativo'
    '1_6_1':   '1.6.1 Dispositivos Base (HID)'
    '1_6_2':   '1.6.2 Dispositivos Avançados de Interação'
    '2_1':     '2.1 Método de Síntese'
    '2_2':     '2.2 Processo de Síntese Interativo'
    '2_3':     '2.3 Restrição ou Limitação no Processo'
    '2_4':     '2.4 Seleção e Edição De Átomos Interativas'
    '3_1_1':   '3.1.1 Modelo de Representação Atômico Molecular'
    '3_1_2':   '3.1.2 Modelo de Representação da Célula Unitária'
    '3_1_3':   '3.1.3 Planos de Miller'
    '3_1_4':   '3.1.4 Direções de Miller'
    '3_1_5_1': '3.1.5.1 Células Múltiplas'
    '3_1_5_2': '3.1.5.2 Cortes'
    '3_1_5_3': '3.1.5.3 Vetores de Eixos'
    '3_1_5_4': '3.1.5.4 Outros Recursos Auxiliares'
    '3_2_1':   '3.2.1 Recursos de Percepção Visual'
    '3_2_2':   '3.2.2 Tipo de Projeção'
    '3_2_3':   '3.2.3 Suporte Estereográfico'
    '3_2_4':   '3.2.4 Modos de Renderização'
    '4_1':     '4.1 Interface'
    '4_2':     '4.2 Interação Base'
    '4_3_1':   '4.3.1 Rotações automáticas'
    '4_3_2':   '4.3.2 Animações guiadas'
    '4_3_3':   '4.3.3 Transição de Escala'
    '4_3_4':   '4.3.4 Gerenciamento dinâmico de oclusões'
    '4_3_5':   '4.3.5 Perspectiva / Pontos de Vista Pré-configurado'
    '5_1':     '5.1 Conhecimentos Requeridos do Usuário'
    '5_2_1':   '5.2.1 Suporte à visualização / Portabilidade externa'
    '5_2_2':   '5.2.2 Suporte à impressão 2D'
    '5_2_3':   '5.2.3 Suporte à impressão 3D'
    '5_2_4':   '5.2.4 Plataforma de Publicação na Internet'
    '5_3_1':   '5.3.1 Suporte à narrativa didática (Salvar preset didático integrado)'
    '5_3_2':   '5.3.2 Biblioteca de estruturas cristalográficas'
    '5_3_3':   '5.3.3 Construção e Visualização Incremental de Estruturas'
    '5_4_1':   '5.4.1 Suporte'
    '5_4_2':   '5.4.2 Documentação'