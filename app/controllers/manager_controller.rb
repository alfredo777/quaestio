class ManagerController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:view, :responder]
  before_action :authenticate_user!

  def all
    @cuestionarios = current_user.cuestionarios.paginate(:page => params[:page], :per_page => 5).order('id DESC')
  end

  def view
    @cuestionario = params[:id]
  end

  def new
    @cuestionario = Cuestionario.new
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
          respuestas: pregunta.respuestas
      })
    end
    
    render json: {cuestionario: cuestionario, preguntas: preguntas}

    
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
    if !px.nil?
    px.each do |pa|
      @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Pregunta", contestacion_id: pa[0], valor: pa[1][:valor], indice_de_creacion: @inx)
    end
    end
    if !rx.nil?
    rx.each do |ra|
      @base_typo_preguntas = BaseDeRespuesta.create(contestacion_type: "Respuesta", contestacion_id: ra[0], valor: ra[1][:valor], indice_de_creacion: @inx)
    end
    end
    redirect_to :back
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
          respuesta: rsp.titulo,
          veces_seleccionada: c[1],
          porciento: ((c[1].to_f/resobase.size)*100).round(2)

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
    end


    render json: {pregunta: respuestas_por_reguntas}
  end
  


  def cuestionario_params
    params.require(:cuestionario).permit(:titulo, :instrucciones, preguntas_attributes: [:titulo, :tipo, :descripccion, :imagen, :valor, :de_a, :de_b, :emogi, :coleccion_emogi, respuestas_attributes: [:titulo, :valor, :checkflag]])
  end
end
