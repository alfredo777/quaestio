class ManagerController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:view, :responder]
  before_filter :current_filted_token, :only => [:all, :new, :code_create, :asign_code ]
  before_action :authenticate_user!, :only => [:all, :view, :audios, :new, :create, :edit, :update, :todas_las_respuestas_del_form, :delete, :xml_view_cuestionario, :estadisticas, :pregunta_view, :todas_las_respuestas_n]

  def all
    @cuestionarios = current_user.cuestionarios.paginate(:page => params[:page], :per_page => 5).order('id DESC')
  end

  def view
    @cuestionario = params[:id]
  end
  
  def audios
    audios = Cuestionario.find(params[:id]).audios
    @audios = audios.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def audios_filter_by_fid
    @device = Dispositivo.find(params[:device])
    audios = Audio.where(idx: params[:id_fabrica])
    @audios = audios.paginate(:page => params[:page], :per_page => 10).order('id DESC')

  end
  def new
    @cuestionario = Cuestionario.new
  end
  def update_p_user
    date = DateTime.now
    date = date.strftime("%Y%m%d")
    @code = "VAJOI#{date}"
  end
  def update_token
    date = DateTime.now
    date = date.strftime("%Y%m%d")
    @code = "VAJOI#{date}"
    if params[:validete_token] == @code
    current_user.validation_by_token = params[:validete_token]
    current_user.save(:validate => false)
    redirect_to cuestionarios_path
    end
  end

  def create
    @cuestionario = Cuestionario.create(cuestionario_params)
    puts current_user
    @cuestionario.user_id = current_user.id
    @cuestionario.save
    redirect_to cuestionarios_path
  end

  def todas_las_respuestas_del_form
    cuestionario = Cuestionario.find(params[:id])
    respuestas = []
    respuestas_por_reguntas = []


    cuestionario.indice_de_creacions.each do |ic|
      ic.todas_las_respuestas.each do |tr|
       case tr.contestacion_type
       when "Pregunta"
          respuestas.push(
              id: tr.contestacion.id,
              pregunta: tr.contestacion.titulo,
              tipo: tr.contestacion.tipo,
              respuesta: 'no',
              respondido: tr.valor
          )
        when "Respuesta"
          respuestas.push(
              id: tr.contestacion.pregunta.id,
              pregunta: tr.contestacion.pregunta.titulo,
              tipo: tr.contestacion.pregunta.tipo,
              respuesta: tr.contestacion.titulo,
              respondido: tr.valor
          )
       end
      end
    end

    cuestionario.preguntas.each do |pregunta|
      if pregunta.tipo == "mt"

        resobase = []
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
             end
           end
          end
        end
        respuestas_por_reguntas.push(
          id: pregunta.id,
          tipo: pregunta.tipo,
          titulo: pregunta.titulo,
          respuestas: resobase
        )

      else
        resobase = []
        pregunta.base_de_respuestas.each do |r|
          resobase.push(r.valor)
        end
        respuestas_por_reguntas.push(
          id: pregunta.id,
          tipo: pregunta.tipo,
          titulo: pregunta.titulo,
          respuestas: resobase
        )
      end
    end

   # @json = {cuestionario: cuestionario, respondido_desglozado: respuestas, respondido_por_preguntas: respuestas_por_reguntas}
   @json = respuestas
   #@json = respuestas_por_reguntas
  end

  def edit
    @cuestionario = Cuestionario.find(params[:id])
  end

  def update
  end

  def asign_code
    @cuestionario = Cuestionario.find(params[:id])
  end

  def code_create
    number = params[:numbertokens].to_i
    number.times do 
    @code = TokenDeDescarga.create(cuestionario_id: params[:cuestionario_id], token: "#{SecureRandom.hex(2)}#{current_user.id}")
    end
    redirect_to :back
  end

  def delete
    @cuestionario =  Cuestionario.find(params[:id])
    @cuestionario.destroy
    
    flash[:notice] = "Se ha elminado el cuestionario"
    redirect_to :back
  end

  def json_view_cuestionario
    cuestionario = Cuestionario.find(params[:id])
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
          imagen: pregunta.imagen,
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
    
    render json: {cuestionario: cuestionario, preguntas: preguntas}    
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

  def xml_view_cuestionario
    cuestionario = Cuestionario.find(params[:id])
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
          imagen: pregunta.imagen,
          valor: pregunta.valor,
          de_a: pregunta.de_a,
          de_b: pregunta.de_b,
          respuestas:pregunta.respuestas
      })
    end
    
    render xml: {cuestionario: cuestionario, preguntas: preguntas}
  end

  def responder
    @random = SecureRandom.hex(11)
    cuestionario = params[:cuestionario][:id]
    @indice_de_creacion = IndiceDeCreacion.find_by_idx(@random)
    if @indice_de_creacion.nil?
       @nuevo_indice = IndiceDeCreacion.create(idx: @random, cuestionario_id: cuestionario)
    else
       @random2 = @random + SecureRandom.hex(3)
       @nuevo_indice = IndiceDeCreacion.create(idx: @random2, cuestionario_id: cuestionario)
    end
    puts "Indice #{@nuevo_indice.idx}"
    puts "Id #{@nuevo_indice.id}"
    @inx = @nuevo_indice.idx

    puts params
    px = params[:tipo][:pregunta]
    rx = params[:tipo][:respuesta]
    cx = params[:tipo][:respuesta_catgorica]

    ####### tipo pregunta ########
    if !px.nil?
      px.each do |pa|
        @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Pregunta", contestacion_id: pa[0], valor: pa[1][:valor], indice_de_creacion: @inx)
      end
    end
    ###### tipo respuesta ########

    if !rx.nil?
      rx.each do |ra|
        valorx = ra[1][:valor]
         if valorx.kind_of?(Array)
          valorx.each do |vx|
            arr = eval(vx)
            valor = arr[0]
            categoria = arr[1]
            puts valor
            puts categoria
            puts ra[0]
            @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Respuesta", contestacion_id: ra[0], valor: valor, categorias_en_preguntum_id: categoria, indice_de_creacion: @inx)
          end
         else
          @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Respuesta", contestacion_id: ra[0], valor: ra[1][:valor], indice_de_creacion: @inx)
         end
      end
    end
    ####### respuesta categorica #######
    if !cx.nil?
      cx.each do |rc|
        valorx = rc[1][:valor]
        identificador = rc[0] ######### pregunta
        if valorx.kind_of?(Array)
          valorx.each do |vx|
          arr = eval(vx)
          valor = arr[0] ###### respuesta  
          categoria = arr[1] ###### categoria 
          @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Pregunta", contestacion_id: rc[0], valor: valor, categorias_en_preguntum_id: categoria, indice_de_creacion: @inx)
        end
       else
        @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Pregunta", contestacion_id: rc[0], valor: rc[1][:valor], indice_de_creacion: @inx)
       end
      end
    end

    respond_to do |format|
      format.html {redirect_to gracias_path(id: cuestionario)}
      format.json  { render json: "Cuestionario Sincronizado" }
    end
  end

  def estadisticas
    @cuestionario = Cuestionario.find(params[:id])
    @preguntas = @cuestionario.preguntas
    grafica_de_estado = []
    

    @cuestionario.indice_de_creacions.each do |x|
       puts x.created_at
       xv = x.created_at.to_date
       xvdt= xv.to_datetime
       xvg = xvdt.to_f * 1000
       grafica_de_estado.push(xvg)
    end

    puts grafica_de_estado

    stata = Hash.new(0)
    grafica_de_estado.map { |x| stata[x] += 1 }
    puts stata

    stata_glose = []

    stata.each do |c|
      stata_glose.push([c[0],c[1]])
    end

    puts "#{stata_glose}"

    @grafica_de_estado = stata_glose

  end

  def pregunta_view
    pregunta = Pregunta.find(params[:id])
    respuestas_por_reguntas =[]
    resobase = []

     case pregunta.tipo
      when "mt"
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
             end
           end
          end
        end

        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }

        stata.each do |c|
         rsp = Respuesta.find(c[0])
         stata_glose.push({
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)

          })
        end
      when "mtcaval"
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
             end
           end
          end
        end
        
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }

        stata.each do |s|
          pregunta.respuestas.each do |r2|
            r2.volores_multiples_to_respuesta.each do |vmr|
              if s[0].to_i == vmr.cuantificador_del_valor
              stata_glose.push({
                id: r2.id,
                respuesta: "#{vmr.nombre_del_valor} | #{vmr.cuantificador_del_valor}",
                veces_seleccionada: s[1],
                porciento: ((s[1].to_f/resobase.size)*100).round(2)
              })
              end
            end
          end
        end
      when "mtcat"
        
        if !pregunta.nil?
          if pregunta.base_de_respuestas.count != 0
              pregunta.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
              end
           end
        end

        
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }


        stata.each_with_index do |s, index|
          puts s
          rsp = Respuesta.find(s[0])
          if !rsp.nil?
          stata_glose.push({
              id: rsp.id,
              respuesta: "#{rsp.titulo}",
              veces_seleccionada: s[1],
              porciento: ((s[1].to_f/resobase.size)*100).round(2)
          })
          end
        end
      when "mtca"
        valores_internos = []
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push([ers.contestacion_id, ers.valor])
             end
           end
          end
        end

        stata = Hash.new(0)
        stata_glose = []

        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         rsp = Respuesta.find(c[0][0])
         stata_glose.push({
          id: rsp.id,
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: (c[0][1].to_f).round(2)

          })
        end
      when "ab"
       pregunta.base_de_respuestas.each_with_index  do |r, index|
        resobase.push(
          respuesta: r.valor
          )
        end
        stata_glose = resobase

      when "es"

        pregunta.base_de_respuestas.each_with_index  do |r, index|
        resobase.push(
           r.valor
          )
        end
        stata_glose = []
        stata = Hash.new(0)
        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         stata_glose.push({
          respuesta: c[0],
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)
          })
        end

      when "sl"
       pregunta.base_de_respuestas.each do |r|
        resobase.push(r.valor)
        end
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         rsp = Respuesta.find(c[0])
         stata_glose.push({
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)
          })
        end
      end

        respuestas_por_reguntas.push(
          id: pregunta.id,
          tipo: pregunta.tipo,
          titulo: pregunta.titulo,
          estadisticas_de_respuesta: stata_glose
        )



    render json: {pregunta: respuestas_por_reguntas}
  end
  

  def todas_las_respuestas_n
    cuestionario = Cuestionario.find(params[:id])
    preguntas = cuestionario.preguntas
    respuestas_por_reguntas =[]
    preguntas.each do |pregunta|
      resobase = []

     case pregunta.tipo
      when "mt"
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
             end
           end
          end
        end

        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         rsp = Respuesta.find(c[0])
         stata_glose.push({
          id: rsp.id,
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)

          })
        end
      when "mtcat"
        
        if !pregunta.nil?
          if pregunta.base_de_respuestas.count != 0
              pregunta.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
              end
           end
        end

        
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }


        stata.each_with_index do |s, index|
          puts s
          rsp = Respuesta.find(s[0])
          if !rsp.nil?
          puts rsp.id
          stata_glose.push({
              id: rsp.id,
              respuesta: "#{rsp.titulo}",
              veces_seleccionada: s[1],
              porciento: ((s[1].to_f/resobase.size)*100).round(2)
          })
          end
        end
       when "mtcaval"
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push(ers.valor)
             end
           end
          end
        end
        
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }

        stata.each_with_index do |s, index|
          rsp = Respuesta.find(s[index])
          pregunta.respuestas.each do |r2|
            r2.volores_multiples_to_respuesta.each do |vmr|
              if s[0].to_i == vmr.cuantificador_del_valor
              stata_glose.push({
                id: r2.id,
                respuesta: "#{vmr.nombre_del_valor} | #{vmr.cuantificador_del_valor}",
                veces_seleccionada: s[1],
                porciento: ((s[1].to_f/resobase.size)*100).round(2)
              })
              end
            end
          end
        end
      when "mtca"
        valores_internos = []
        pregunta.respuestas.each do |r|
          if !r.nil?
           if r.base_de_respuestas.count != 0
             r.base_de_respuestas.each do |ers|
               resobase.push([ers.contestacion_id, ers.valor])
             end
           end
          end
        end

        stata = Hash.new(0)
        stata_glose = []

        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         rsp = Respuesta.find(c[0][0])

         stata_glose.push({
          id: rsp.id,
          respuesta: rsp.titulo,
          veces_seleccionada: c[0][1],
          porciento: ""

          })
        end
      when "ab"
       pregunta.base_de_respuestas.each_with_index  do |r, index|
        resobase.push(
          respuesta: r.valor
          )
        end
        stata_glose = resobase

      when "es"

        pregunta.base_de_respuestas.each_with_index  do |r, index|
        resobase.push(
           r.valor
          )
        end
        stata_glose = []
        stata = Hash.new(0)
        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         stata_glose.push({
          id: "",
          respuesta: c[0],
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)

          })
        end

      when "sl"
       pregunta.base_de_respuestas.each do |r|
        resobase.push(r.valor)
        end
        stata = Hash.new(0)
        stata_glose = []
        resobase.map { |x| stata[x] += 1 }
        stata.each do |c|
         rsp = Respuesta.find(c[0])
         stata_glose.push({
          id: rsp.id,
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)

          })
        end
      end

      respuestas_por_reguntas.push(
        id: pregunta.id,
        tipo: pregunta.tipo,
        titulo: pregunta.titulo,
        descripccion: pregunta.descripccion,
        imagen: pregunta.imagen,
        estadisticas_de_respuesta: stata_glose
      )
    end


    render json: {pregunta: respuestas_por_reguntas}
  end
  
  def current_filted_token
    if current_user
      if current_user.validation_by_token.nil?
        redirect_to update_code_for_user_path
      end
    end
  end

  def cuestionario_params
    params.require(:cuestionario).permit(:titulo, :instrucciones, :paginar, :compartir, preguntas_attributes: [:titulo, :tipo, :descripccion, :imagen, :valor, :de_a, :de_b, :emogi, :coleccion_emogi, respuestas_attributes: [:titulo, :valor, :checkflag, :pase, volores_multiples_to_respuesta_attributes:[:nombre_del_valor, :cuantificador_del_valor]], pase_dinamicos_attributes: [:de_a, :de_b, :pase], categorias_en_pregunta_attributes: [:titulo, :valor]])
  end
end
