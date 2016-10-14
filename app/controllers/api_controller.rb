class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create_audios]
  layout "opl"
  def vista_para_respuesta
     @cuestionario = params[:id]
  end

  def vista_gracias_respuesta
     @cuestionario = Cuestionario.find(params[:id])
  end

  def create_audios
    puts "Creación de audio *******************************************"
    @create_audio = Audio.new
    @create_audio.audio_file = params[:file]
    @create_audio.cuestionario_id = params[:value1]
    @create_audio.idx = params[:value2]
    @create_audio.save

    if @create_audio.save
    render json: "#{@create_audio.audio_file}"
    else
    render json: "El audio no pudo ser creado"
    end
  end

  def spss_tables
    cuestionario = Cuestionario.find(params[:id])
    preguntas = cuestionario.preguntas
    
    ####### head de preguntas #########
    head = preguntas.map { |e| e.titulo.gsub(/^(.{12,}?).*$/m,'\1').remove('¿') }
     preguntas.map {|e| puts "#{e.tipo} #{e.id}" }
    array_order = []

    head_n = preguntas.map { |e|  e.respuestas.each_with_index do |r, index| 
       array_order.push(r.id)  
       array_order.push(index+1)
       end 
    } 

    array_order = Hash[*array_order]
    head = ["id"] + head
    ##### se genera la tabla de respuestas #####
    collection_of_parts = []
    collect_preguntas = preguntas.map { |e| e.id }
    cuestionario.indice_de_creacions.each do |respuetas|
      hash_value = []
      respuetas.todas_las_respuestas.each_with_index do |hash_respueta, index|
        case hash_respueta.contestacion_type
          when "Pregunta"
            id = hash_respueta.contestacion.id
            typeX = hash_respueta.contestacion.tipo
          when "Respuesta"
            id = hash_respueta.contestacion.pregunta.id
            typeX = hash_respueta.contestacion.pregunta.tipo
        end
        case 
        when typeX == 'sl' || typeX == 'mt'
          cxf = hash_respueta.valor.to_i
          finder = array_order[cxf]
          hash_value.push([id,finder])
        when typeX == 'ab' || typeX == 'es'
          if typeX == 'es'
            cxf = hash_respueta.valor.to_i
          else
            cxf = hash_respueta.valor
          end
          hash_value.push([id,cxf])
        when typeX == 'mtca' 
           if hash_respueta.valor.mb_chars.length > 1
           cxf = hash_respueta.valor
           else
           cxf = hash_respueta.valor.to_i
           end
           hash_value.push([id,cxf])
        when typeX == 'mtcaval'
           cxf = hash_respueta.valor.to_i
           hash_value.push([id,cxf])
        when typeX == 'mtcat'
           cxf = hash_respueta.valor.to_i
           finder = array_order[cxf]
           hash_value.push([id,finder])
        end
      end
      hashes = Hash.new{ |h,k| h[k]=[] }.tap{ |h| hash_value.each{ |k,v| h[k] << v } }
      collection_of_parts.push(hashes)
    end

    ###### comparando columnas ######
    puts "#{collect_preguntas}"
    csv_string = CSV.generate(:col_sep => ";") do |csv|

      csv << head
      collection_of_parts.each_with_index do |c, index|
        colection = []
        collect_preguntas.each do |ar|
          if c[ar].count == 1
            arx = c[ar][0]
          else
            arx = c[ar].to_a
          end
          colection.push(arx)
        end
        colection = [index+1] + colection
        csv << colection
      end
     end

     puts csv_string

    respond_to do |format|
      format.html
      format.csv {send_data csv_string, filename: "Base-del-cuestionario-#{cuestionario.titulo}-#{Time.now}.csv"}
    end
  end

  def advanced_json
    cuestionario = Cuestionario.find(params[:id])
    preguntas = cuestionario.preguntas
    
    ####### head de preguntas #########
    head = preguntas.map { |e| e.titulo.gsub(/^(.{12,}?).*$/m,'\1').remove('¿') }
     preguntas.map {|e| puts "#{e.tipo} #{e.id}" }
    array_order = []

    head_n = preguntas.map { |e|  e.respuestas.each_with_index do |r, index| 
       array_order.push(r.id)  
       array_order.push(index+1)
       end 
    } 

    array_order = Hash[*array_order]
    head = ["id"] + head
    ##### se genera la tabla de respuestas #####
    collection_of_parts = []
    collect_preguntas = preguntas.map { |e| e.id }

    cuestionario.indice_de_creacions.each do |respuetas|
      hash_value = []
      respuetas.todas_las_respuestas.each_with_index do |hash_respueta, index|
        case hash_respueta.contestacion_type
          when "Pregunta"
            id = hash_respueta.contestacion.id
            typeX = hash_respueta.contestacion.tipo
            pregunta = hash_respueta.contestacion.titulo
            respuesta = hash_respueta.valor
            idx = hash_respueta.indice_de_creacion
            puts idx
          when "Respuesta"
            id = hash_respueta.contestacion.pregunta.id
            typeX = hash_respueta.contestacion.pregunta.tipo
            pregunta = hash_respueta.contestacion.pregunta.titulo
            respuesta = hash_respueta.valor
            idx = hash_respueta.indice_de_creacion
            puts idx
        end

       case 
        when typeX == 'sl' || typeX == 'mt'
          cxf = hash_respueta.valor.to_i
          finder = array_order[cxf]
          hash_value.push([pregunta,{"#{hash_respueta.contestacion.titulo}": "#{finder}"}])
        when typeX == 'ab' || typeX == 'es'
          if typeX == 'es'
            cxf = hash_respueta.valor
             res = scala_interprete(cxf)
             hash_value.push([pregunta,{"#{res}": "#{cxf}" }])
          else
            cxf = hash_respueta.valor
             hash_value.push([pregunta,"#{cxf}"])
          end
         
        when typeX == 'mtca' || typeX == 'mtcaval'
           cxf = hash_respueta.valor
           hash_value.push([pregunta,{"#{hash_respueta.contestacion.titulo}": "#{cxf}" }])
        when typeX == 'mtcat'
           cxf = hash_respueta.valor.to_i
           finder = array_order[cxf]
           cat =  hash_respueta.categorias_en_preguntum_id
           ccc = CategoriasEnPreguntum.find_by_valor(cat.to_i)
           puts ccc
           puts "************ #{hash_respueta.contestacion.id} - #{hash_respueta.contestacion.titulo} "
           hash_value.push([pregunta,{"#{cat}": "#{finder}"}])
        end
      end
      hashes = Hash.new{ |h,k| h[k]=[] }.tap{ |h| hash_value.each{ |k,v| h[k] << v } }
      holala = {
        id: "#{respuetas.idx}",
        respuetas: hashes
      }
      collection_of_parts.push(holala)
    end

    render json: collection_of_parts
  end

  def scala_interprete(n)
    scale = {
      "1" => "Muy Malo",
      "2" => "Malo",
      "3" => "Medio Malo",
      "4" => "Regular",
      "5" => "Aceptable",
      "6" => "Bueno",
      "7" => "Muy bueno",
      "8" => "Mas que muy bueno",
      "9" => "Excelente",
      "10" => "Magnifico"
    }

    r =  scale["#{n}"]
    @r = r 
  end

  def json_view_cuestionario
    token = TokenDeDescarga.find_by_token(params[:tokenizer])


    if token
    cuestionario = token.cuestionario

    dispositivo = Dispositivo.new
    dispositivo.id_fabrica = params[:dispositivo]
    dispositivo.modelo = params[:model]
    dispositivo.plataforma = params[:plataforma]
    dispositivo.version = params[:version]
    dispositivo.manufacturado = params[:manufactura]
    dispositivo.serial = params[:serial]
    dispositivo.cuestionario_id = cuestionario.id
    dispositivo.token_de_descarga_id = token.id
    dispositivo.save


    preguntas = []
    cuestionario.preguntas.each do |pregunta|
      preguntas.push({
          id: pregunta.id,
          titulo: pregunta.titulo,
          tipo: pregunta.tipo,
          descripccion: pregunta.descripccion,
          cuestionario_id:  pregunta.cuestionario_id,
          created_at: pregunta.created_at,
          updated_at: pregunta.updated_at,
          imagen: oppen_images(pregunta.imagen),
          valor: pregunta.valor,
          de_a: pregunta.de_a,
          de_b: pregunta.de_b,
          emogi: pregunta.emogi,
          coleccion_emogi: pregunta.coleccion_emogi,
          respuestas: respuestas_accces_function(pregunta.id),
          categorias: pregunta.categorias_en_pregunta,
          pase_dinamicos: pase_dinamicos_function(pregunta.id)
      })
    end
    end
    if token
    render json: {cuestionario: cuestionario, preguntas: preguntas}
    else
    render json: {cuestionario: false}
    end
  end

  def respuestas_accces_function(id)
    @respuestas = Respuesta.where(pregunta_id: id);

    respuestas = []
    
    @respuestas.each do |r|
    respuestas.push({
      id: r.id,
      titulo: r.titulo,
      pregunta_id: r.pregunta_id,
      valor: r.valor,
      created_at: r.created_at,
      updated_at: r.updated_at,
      pase: r.pase,
      valores: r.volores_multiples_to_respuesta
     })
    end
    @r = respuestas
  end

  def pase_dinamicos_function(id)
    @pases = PaseDinamico.where(pregunta_id: id);
    pases_array = []
    if !@pases.nil?
      @pases.each do |pase|
        pases_array.push({
          de_a: pase.de_a,
          de_b: pase.de_b,
          pase: pase.pase
        })
      end
    end
    @p = pases_array
  end

  def oppen_images(imagenes)
    urlx = imagenes.full.url
    if urlx.nil?
      url = nil
      else
      if Rails.env == 'production'
      filename ||= "#{imagenes.full.url}"
      else
      filename ||= "#{Rails.root}/public#{imagenes.full.url}"
      end
      #url = File.binread(filename)
      #binary = url.unpack('B*')
      #binary = binary[0]
      #url = Base64.encode64(url)
      url = Base64.encode64(open(filename).to_a.join)
    end
    url
  end
end
