// carga el tpl
function loadDBTPL(data, tpln, divloadtpl){
    getTemplate(tpln, data, function(output, err) {
      $("#"+divloadtpl).html(output);
    });  
}

function loadTPL(jsonn, tpln, divloadtpl, lang){
   getasJSON(jsonn, lang,function(data, err) {
      getTemplate(tpln, data, function(output, err) {
        $("#"+divloadtpl).html(output);
      });    
   });
}

// cargar tpl api
function loadTPLAPI(jsonn, datax,tpln, divloadtpl){
   getasJSONAPI(jsonn, datax,function(data, err) {
      getTemplate(tpln, data, function(output, err) {
        $("#"+divloadtpl).html(output);
      });    
   });
}

// cargar tpl add
function loadTPLAPIADD(jsonn, tpln, divloadtpl){
   getasJSONAPI(jsonn,function(data, err) {
      getTemplate(tpln, data, function(output, err) {
        $("#"+divloadtpl).after(output);
      });    
   });
}

// cargar paginando

function loadTPLpaginate(data, tpln, divloadtpl){
  getTemplate(tpln, data, function(output, err) {
    $("#"+divloadtpl).append(output);
  });
}

// se dirige al tpl
function getTemplate(name, context, callback) {
  $.ajax({
    url: '/templates/' + name + '.html',
    cache: true,
    success: function (data) {
      var tpl = Handlebars.compile(data),
      output = tpl(context);
      callback(output, null);
    },
    error: function(err) {
      callback(null, err);
    }
  });
}

// se conecta al json interno
function getasJSON(json_file, lang ,callback){
  $.ajax({
    dataType: "json",
    url: '/json/'+lang+"/"+ json_file + '.json',
    cache: true,
    success: function (data) {
      callback(data, null);
    },
    error: function(err) {
      callback(null, err);
    }
  });
}
// se conecta al json  API
function getasJSONAPI(json_file, datax ,callback){
  $.ajax({
    dataType: "json",
    url: '/manager/'+ json_file + '.json',
    data: datax,
    cache: true,
    success: function (data) {
      callback(data, null);
    },
    error: function(err) {
      callback(null, err);
    }
  });
}


Handlebars.registerHelper('list', function(items, options) {
  var out = "<ul>";

  for(var i=0, l=items.length; i<l; i++) {
    out = out + "<li>" + options.fn(items[i]) + "</li>";
  }

  return out + "</ul>";
});

Handlebars.registerHelper('trimString', function(passedString) {
    var theString = passedString.substring(0,420);
    return new Handlebars.SafeString(theString)
});

Handlebars.registerHelper("prettifyDate", function(date) {
    var parse = new Date(date);
    var weekday = parse.getDay();
    var year = parse.getFullYear();
    var month = parse.getMonth();
    var parsedDate = weekday +"-"+ month +"-"+ year;
    return new Handlebars.SafeString(parsedDate)
});

Handlebars.registerHelper ('truncate', function (str, len) {
        if (str.length > len) {
            var new_str = str.substr (0, len+1);

            while (new_str.length) {
                var ch = new_str.substr ( -1 );
                new_str = new_str.substr ( 0, -1 );

                if (ch == ' ') {
                    break;
                }
            }

            if ( new_str == '' ) {
                new_str = str.substr ( 0, len );
            }

            return new Handlebars.SafeString ( new_str +'...' ); 
        }
        return str;
    });

Handlebars.registerHelper('equal', function(lvalue, rvalue, options) {
    if (arguments.length < 3)
        throw new Error("Handlebars Helper equal needs 2 parameters");
    if( lvalue!=rvalue ) {
        return options.inverse(this);
    } else {
        return options.fn(this);
    }
});


Handlebars.registerHelper('scala', function(avalue, bvalue, idx, pase_dinamicos,options) {
  var out;
  var init = avalue;
  var finish = bvalue;
  var firstn = init;
  var pase_dinamicos = pase_dinamicos;
  out = "<table class='table table-striped table-bordered'><tr>";
  for(var i=init, l=finish+1; i<l; i++) {
    out = out + "<td><center>"+i+'</center></td>';
  }
  out = out + "</tr><tr class='trx'>";

  for(var i=init, l=finish+1; i<l; i++) {
    var pase_array = [];
    if(pase_dinamicos != null){
    $.each(pase_dinamicos, function(index,item){
      if( i >= item.de_a  && i <= item.de_b){
         pase_array.push(item.pase); 
      }
    });
    }else{
      pase_array = [0]; 
    }
    var PaseTo = pase_array[0];
    if (i == init) {
    out = out + '<td style="text-align: center; vertical-align: middle;"><input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+i+'" data-page="'+PaseTo+'"  class="pase"  checked></input></td>';
    }else{
    out = out + '<td style="text-align: center; vertical-align: middle;"><input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+i+'" data-page="'+PaseTo+'"  class="pase"  ></input></td>';
    }
  }

  return out+ "</tr></table>";

});

Handlebars.registerHelper('scalaemogi', function(avalue, bvalue, idx, coleccion, pase_dinamicos,options) {
  var out;
  var init = avalue;
  var finish = bvalue;
  var firstn = init;
  var coleccionn = [ coleccion+"greeding.png", coleccion+"big_smile.png", coleccion+"smile.png", coleccion+"bad_smile.png", coleccion+"what.png", coleccion+"misdoubt.png", coleccion+"sigh.png", coleccion+"wicked.png",coleccion+"unhappy.png", coleccion+"surprise.png" ];
  out = "<table class='table table-striped table-bordered'><tr>";
  for(var i=init, l=finish+1; i<l; i++) {
    out = out + "<td><center>"+i+'</center></td>';
  }
  out = out + "</tr><tr class='trx'>";


  for(var i=init, l=finish+1; i<l; i++) {
    var pase_array = [];
    if(pase_dinamicos != null){
    $.each(pase_dinamicos, function(index,item){
      if( i >= item.de_a  && i <= item.de_b){
         pase_array.push(item.pase); 
      }
    });
    }else{
      pase_array = [0]; 
    }
    var PaseTo = pase_array[0];
    if (i == init) {
    out = out + '<td style="text-align: center; vertical-align: middle;"><label for="id_'+idx+'_'+i+'" style="cursor:pointer;" class="to-emogi emogi"><img src="'+coleccionn[10-i]+'" width="90px"/></label> <input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+i+'" id="id_'+idx+'_'+i+'" data-page="'+PaseTo+'"  class="pase" style="display:none;" checked></input></td>';
    }else{
    out = out + '<td style="text-align: center; vertical-align: middle;"><label for="id_'+idx+'_'+i+'" style="cursor:pointer;" class="to-emogi"><img src="'+coleccionn[10-i]+'" width="90px"/> </label><input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+i+'" id="id_'+idx+'_'+i+'" data-page="'+PaseTo+'"  class="pase"  style="display:none;" ></input></td>';
    }

  }
  return out+ "</tr></table>";

});

Handlebars.registerHelper('scalasuper', function(items, idx,options, page) {
 var out = "<table class='table table-striped'>";
  for(var i=0, l=items.length; i<l; i++) {
    if (i == 0) {
      out = out + "<tr class='trx'><td>"+ items[i].titulo+'</td><td><input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+items[i].id+'"  data-page="'+items[i].pase+'"  class="pull-right pase" checked></input></td></tr>';
    }else{
      out = out + "<tr class='trx'><td>"+ items[i].titulo+'</td><td><input name="tipo[pregunta]['+idx+'][valor]" type="radio" value="'+items[i].id+'"  data-page="'+items[i].pase+'" class="pull-right pase"></input></td></tr>';
    }
  }

  return out + "</table>";
});


Handlebars.registerHelper('multiplesuper', function(items,options) {
  var out = "<table class='table table-striped'>";
  for(var i=0, l=items.length; i<l; i++) {
    if (i == 0) {
      out = out + "<tr><td>"+ items[i].titulo+'</td><td><input name="tipo[respuesta]['+items[i].id+'][valor]" value="'+items[i].id+'" type="checkbox" class="pull-right" checked></input></td></tr>';
    }else{
      out = out + "<tr><td>"+ items[i].titulo+'</td><td><input name="tipo[respuesta]['+items[i].id+'][valor]" value='+items[i].id+' type="checkbox" class="pull-right" ></input></td></tr>';
    }
  }

  return out + "</table>";
});

Handlebars.registerHelper('multiplesupermtca', function(items,options) {
  var out = "<table class='table table-striped'>";
  for(var i=0, l=items.length; i<l; i++) {
    
      out = out + "<tr><td>"+ items[i].titulo+'</td><td><input name="tipo[respuesta]['+items[i].id+'][valor]"  type="text" class="pull-right form-control" ></input></td></tr>';
    
  }

  return out + "</table>";
});


Handlebars.registerHelper('valuescontrapose', function(items, id,options) {
  var out = "<table class='table table-striped'>";
   console.log(items);
    
  for(var i=0, l=items.length; i<l; i++) {
    if (i == 0) {
      out = out + "<tr><td>"+ items[i].nombre_del_valor+'</td><td><input name="tipo[respuesta]['+id+'][valor]"  value="'+items[i].cuantificador_del_valor+'"  type="radio" class="pull-right" checked></input></td></tr>';
    }else{
      out = out + "<tr><td>"+ items[i].nombre_del_valor+'</td><td><input name="tipo[respuesta]['+id+'][valor]"  value="'+items[i].cuantificador_del_valor+'"  type="radio" class="pull-right" ></input></td></tr>';

    }
  }

  return out + "</table>";
});

Handlebars.registerHelper('advancedcategory', function(items, id, categorias, options){
  var out = "<table class='table table-striped '>";
  out = out + "<thead><tr class='active'>";
  out = out + '<th> Opcciones </th>'
  $.each(categorias, function(index, item){
    out = out + '<th>'+ item.titulo + '</th>';
  });
  out = out + "</tr><thead>";
  out = out + "<tbody>";
  $.each(items, function(index, item){
    out = out + '<tr>';
    out = out + '<td class="active">'+item.titulo+'</td>';
    var superItem = item;
    $.each(categorias, function(index, itemcat){
      out = out + '<td><input name="tipo[respuesta]['+id+'][valor][]"  value="['+superItem.id+','+itemcat.id+']"  type="checkbox" class="pull-right" ></input></td>';
    });
    out = out + '</tr>';
  });
  out = out + "</tbody>";
  return  out + "</table>";
});

Handlebars.registerHelper('typ', function(tipo, options) {
  var out;
  if (tipo == "sl"){
    out = "Selección";
  }
  if (tipo == "es"){
    out = "Escala Numérica";
  }
  if (tipo == "ab"){
    out = "Abierta";
  }
  if (tipo == "mt"){
    out = "Selección Multiple";
  }
  if (tipo == "mtca"){
    out = "Selección Multiple campo Abierto";
  }
  return out;
});
Handlebars.registerHelper("host", function(options){
  var out;

  out = window.location.protocol + '//'+ window.location.host;

  return out;


});

Handlebars.registerHelper("diferent", function(valA,valB,options){
  var out;
  if(valA != valB){
    out = options.fn(this);
  }else{
    out = options.inverse(this);
  }
  return out;
});
