    ############# preparando variables ##########
    variables_de_cabezal = []
    variables = cuestionario.preguntas
    variables.each do |variables|
      variables_de_cabezal.push({
          id: variables.id,
          titulo: variables.titulo,
          tipo_var: 'pregunta',
          categoria_de_tipo: variables.tipo,
          nominal: "#{variables.titulo[0..2]}" +"_"+ "#{variables.id}" +"_"+ "pregunta"
        })
      if variables.respuestas.count != 0
        variables.respuestas.each do |variableavanzada|
          variables_de_cabezal.push({
          id: variableavanzada.id,
          titulo: variableavanzada.titulo,
          tipo_var: 'respuesta',
          categoria_de_tipo: variables.tipo,
          nominal: "#{variableavanzada.titulo[0..2]}" +"_"+ "#{variableavanzada.id}" +"_"+ "respuesta"
          })
        end
      end
    end  
  
    puts variables_de_cabezal
    ######## se genera un nuevo order para la exportación y se agrega un factor multiplicador para los ordenes ####
    array_order = []
    factorR = 1
    factorP = 1

    variables_de_cabezal.each_with_index do |r, index| 

       if r[:tipo_var] == 'pregunta'
         rx = r[:id] * factorP
        else
         rx = r[:id] * factorR
       end

       array_order.push(rx)  
       array_order.push(index+1)
    end 
    
    array_order = Hash[*array_order]
    puts array_order


    ######### ingresando a la generalidad de los datos ########
    array = []
    array_minimal_procces = []

    cuestionario.indice_de_creacions.each do |indice|
      indice.todas_las_respuestas.each_with_index do |respuesta, index|
        if respuesta.contestacion_type == "Respuesta"
         cuestionario_respondido_token = indice.idx
         pregunta = respuesta.contestacion.pregunta
         nomenclat = "#{respuesta.contestacion.titulo[0..2]}_#{respuesta.contestacion.id}_respuesta"
         to_intt = "#{respuesta.valor}".to_i
         puts "********** #{to_intt}"
         if to_intt == 0
         valor = "#{respuesta.valor}"
         valor_de_orden = array_order[respuesta.contestacion.id]
         else
         valor = to_intt
         valor_de_orden = array_order[valor]
         end
         tipo = "#{respuesta.contestacion.pregunta.tipo}"
         el_valor_ponderado = "#{respuesta.contestacion.titulo}"
         puts "*****#{respuesta.contestacion.titulo}"
         
         else
         cuestionario_respondido_token = indice.idx
         pregunta = respuesta.contestacion
         nomenclat = "#{respuesta.contestacion.titulo[0..2]}_#{respuesta.contestacion.id}_pregunta"
         valor = respuesta.valor
         tipo = "#{respuesta.contestacion.tipo}"
         if tipo == "ab"
         el_valor_ponderado = respuesta.valor
         valor_de_orden = array_order[respuesta.contestacion.id]
         else
         if tipo != "es"
         el_valor_ponderado = Respuesta.find(respuesta.valor.to_i).titulo
         puts el_valor_ponderado
         valor_de_orden = array_order[valor.to_i]
         else
         el_valor_ponderado = respuesta.valor
         valor_de_orden = array_order[respuesta.contestacion.id]
         end
         end
        end
        array.push({id: cuestionario_respondido_token,nomenclat: nomenclat, :pregunta => pregunta.titulo,  valor: valor, valor_ponderado: el_valor_ponderado, valor_de_orden: valor_de_orden ,tipo: tipo})
        array_minimal_procces.push("#{nomenclat}": valor_de_orden)  
      end
    end

    puts array

    array.each do |artx|
      puts artx[:id]
    end

    respond_to do |format|
      format.js
    end

  end

=begin
  def cuestionario_normalizado
    array = []
    array_minimal_procces = []
    ##### encuentra el cuestionario#########
    cuestionario = Cuestionario.find(params[:id])
    preguntas = cuestionario.preguntas
    array_order = []

    opt = []
    preguntas.each do  |e| 
      opt.push({"name": "pregunta_#{e.id}"})
      e.respuestas.each do |r|
        opt.push({"name": "respuesta_#{r.id}"})
      end
    end
    puts opt
    opcciones = opt


    head_n = preguntas.map { |e|  e.respuestas.each_with_index do |r, index| 
       array_order.push(r.id)  
       array_order.push(index+1)
       end 
    } 

    ###### genera el orden de las preguntas #####
    array_order = Hash[*array_order]
    puts array_order


    ####### damos un orden predefinido a las respuestas del cuestionario ########
    cuestionario.indice_de_creacions.each do |indice|
      indice.todas_las_respuestas.each_with_index do |respuesta, index|
        if respuesta.contestacion_type == "Respuesta"
         cuestionario_respondido_token = indice.idx
         pregunta = respuesta.contestacion.pregunta
         nomenclat = "respuesta_#{respuesta.contestacion.id}"
         to_intt = "#{respuesta.valor}".to_i
         if to_intt == 0
         valor = "#{respuesta.valor}"
         valor_de_orden = valor
         else
         valor = to_intt
         valor_de_orden = array_order[valor]
         end
         tipo = "#{respuesta.contestacion.pregunta.tipo}"
         el_valor_ponderado = "#{respuesta.contestacion.titulo}"
         puts "*****#{respuesta.contestacion.titulo}"
         
         else
         cuestionario_respondido_token = indice.idx
         pregunta = respuesta.contestacion
         nomenclat = "pregunta_#{respuesta.contestacion.id}"
         valor = respuesta.valor.to_i
         tipo = "#{respuesta.contestacion.tipo}"
         if tipo == "ab"
         el_valor_ponderado = respuesta.valor
         valor_de_orden = array_order[respuesta.contestacion.id]
         else
         if tipo != "es"
         el_valor_ponderado = Respuesta.find(respuesta.valor.to_i).titulo
         puts el_valor_ponderado
         valor_de_orden = array_order[valor]
         else
         el_valor_ponderado = respuesta.valor
         valor_de_orden = valor
         end
         end
        end
        array.push({id: cuestionario_respondido_token,nomenclat: nomenclat, :pregunta => pregunta.titulo,  valor: valor, valor_ponderado: el_valor_ponderado, valor_de_orden: valor_de_orden ,tipo: tipo})
        array_minimal_procces.push("#{nomenclat}": valor_de_orden)  
      end
    end

    puts array

    puts opcciones

   advanced_order = []
   opcciones.each do |t|
    resultados = []
    array.each do |arx|
      if t[:name] == arx[:nomenclat]
        resultados.push(arx[:valor_de_orden])
      end
    end
    colum_resultados = ["#{t[:name]}"] + resultados 

    advanced_order.push(colum_resultados)
   end
   eval_t = []

   len = []

   advanced_order.map { |e| len.push(e.length)  }

   max = len.max

   advanced_order.each_with_index do |avo, index|
    dif = max - avo.length
     if dif == 0
     eval_t.push(avo)
     else
        putspush = []

        dif.times do
          putspush.push(nil)
        end

        avo = avo + putspush
      eval_t.push(avo)
     end
   end

   puts eval_t

   array_order_by_row = []


    max.times do |i| 
      inx = 0
      array_order_by_row_init = []
      while inx < opcciones.length  do
        array_order_by_row_init.push(eval_t[inx][i])
        inx +=1
      end
      array_order_by_row.push(array_order_by_row_init) 
    end



   csv_string = CSV.generate(:col_sep => ";") do |csv|
     array_order_by_row.each_with_index do |a, index|
       if index == 0
       csv <<  ["id"] + a
       else
       csv <<  [index] + a
       end
     end
   end

   puts csv_string



    respond_to do |format|
        format.js
        format.csv {send_data csv_string, filename: "Base-del-cuestionario-#{cuestionario.titulo}-#{Time.now}.csv"}
    end
  
  end
=end