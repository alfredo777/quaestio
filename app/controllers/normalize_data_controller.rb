class NormalizeDataController < ApplicationController

  def cuestionario_normalizado

    cuestionario = Cuestionario.find(params[:id])

    preguntas = cuestionario.preguntas

    head_hash = {}

    preguntas.each_with_index do |pregunta, index|

      head_hash["#{pregunta.id}"] = index + 1

      pregunta.respuestas.each_with_index do |respuesta, index|

         head_hash["#{respuesta.id}"] =  index + 1
      end
    end

    head_hash_p = {}

    preguntas.each_with_index do |pregunta, index|

      if pregunta.respuestas.count == 0
      head_hash_p["#{pregunta.id}"] = 0
      else
      head_hash_p["#{pregunta.id}"] = ""
      end

      pregunta.respuestas.each_with_index do |respuesta, index|
         head_hash_p["#{respuesta.id}"] =  ""
      end
    end

    secon_head_hash_p = {}

    preguntas.each_with_index do |pregunta, index|

      secon_head_hash_p["#{pregunta.titulo}"] = ""

      pregunta.respuestas.each_with_index do |respuesta, index|
         secon_head_hash_p["#{respuesta.titulo}"] = ""
      end
    end

    puts head_hash
    puts head_hash_p
    puts secon_head_hash_p



    body_array = []
    cuestionario.indice_de_creacions.each do |indice|

      indice.todas_las_respuestas.each_with_index do |objeto, index|
        access_hash = {}
        puts ">>>>>>>>>>>>>>> #{objeto.contestacion_type}"
        puts "!!!!! #{ objeto.contestacion }"
        if objeto.contestacion_type == "Respuesta"
          if objeto.contestacion.nil?
          puts "nulidad ***"
          tipo = "sin respuesta"
          else
          tipo = "#{objeto.contestacion.pregunta.tipo}"
          end
        else
        tipo = "#{objeto.contestacion.tipo}"
        end
        unless objeto.contestacion.nil?
        puts objeto.contestacion.id
        puts "#{objeto.valor} ---> #{objeto.contestacion.id} ----> #{tipo}"
        end

        valoremXc = "#{objeto.valor}"

        puts "#{valoremXc}"
        if head_hash["#{valoremXc}"] == nil
           puts "nulidad"
           valueXC = "#{objeto.valor}"
          else 
           puts "no nulidad ***********"
           valueXC = head_hash["#{valoremXc}"]
        end

        puts "#{valoremXc} -----> #{valueXC}"


        if tipo == "sl" || tipo == "mtcaval" || tipo == "es"
          valueXC = valueXC.to_i
        end


        if tipo == "mtcat"
        objetum = "#{objeto.valor.to_i}"
        access_hash["#{objetum}"] = valueXC
        else
        objetum = "#{objeto.contestacion.id}"
        access_hash[objetum] = valueXC
        end

        access_hash[:"value_added"] = objetum
        access_hash[:"rd_value"] = valueXC
        access_hash[:"secod_key"] = indice.idx
        body_array.push(access_hash)

      end



    end
    
    puts body_array
    arrow= []
    second = body_array.group_by{|h| h[:secod_key]}.each{|_, v| 
     hashed = {}

     v.map!{|h|  
      protos =  h[:value_added]
      campus = h[:rd_value]
      hashed["#{protos}"] = "#{campus}" 
     }
     arrow.push(hashed)
     }
    #second = body_array.group_by{|h| h.delete(:secod_key)}.map{|k, v| {value_added: k,  rd_value: v}}
    puts second
    puts arrow

    column_names = head_hash_p.keys

    remamed = secon_head_hash_p.keys
    puts "******EEEEEE #{head_hash_p.count }"
    csv_string = CSV.generate(:col_sep => ";",  headers: column_names) do |csv|
      csv << remamed
      csv << column_names
      arrow.each do |h|
      merged = head_hash_p.merge(h)
      puts "********>>>>>>>>>>> #{merged.count}"
      csv << merged.values
     end
    end

    puts csv_string

    respond_to do |format|
      format.js
      format.csv {send_data csv_string, filename: "Base-del-cuestionario-#{cuestionario.titulo}-#{Time.now}.csv"}

    end
   end
end

#{"125_scala"=>"8", "126_sexo"=>"1", "128_Pregunt abiarta"=>"lorem ipsum", "222_lorem "=>"1", "223_a1"=>"lol1", "224_ad2"=>"2lol", "225_afgr4"=>"3lol", "228_e1"=>"1", "229_e2"=>"2", "219_Prueba 1"=>"1", "221_Prueba 1"=>"3"}
#{"125_scala"=>"6", "126_sexo"=>"2", "128_Pregunt abiarta"=>"lol 2", "222_lorem "=>"2", "223_a1"=>"lorem", "224_ad2"=>"ipsum", "225_afgr4"=>"dolot", "228_e1"=>"1", "229_e2"=>"2", "230_e3"=>"3", "219_Prueba 1"=>"1", "220_Prueba 1"=>"2", "221_Prueba 1"=>"3"}
