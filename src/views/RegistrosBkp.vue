<template>

    <div class="container">
        <div class="p-grid">
            <h1>{{pantallas.descripcion_menu}}</h1>
            <Card style="width: 25rem;" class="p-m-3 p-pt-2 p-shadow-18"  v-for="(titulo, indice) in titulos" :key="indice">
                <template #title>
                    {{titulo.descripcion_titulo}}
                </template>

                <template #content >
                    <span  v-for="(myLink, orden) in links" :key="orden" >
                        <span v-if="myLink.id_titulo === titulo.id_titulo">
                            <h4>{{myLink.orden}} - Link: <a :href="myLink.path" target="_blank">{{myLink.descripcion_link}}</a>  </h4>
                        </span>
                    </span>
                    
                </template>
            </Card>
        </div>
      
    </div>
</template>




<script>
//let url = "src/libreries/crud2.php";
let url = "http://localhost:90/estribo/src/libreries/crud.php";

export default {
    
    data(){
      return {
          pantallas: [],
          titulos: [],
          links: []
      }
    },
    methods: {
 
        //PROCEDIMIENTOS para el CRUD     
            async listarLinks () {

                // Primer peticion Trae las cabeceras y pies de pantalla.                              
                await axios.post(url, {opcion:4, id_menu:1})
                .then(response =>{
                    this.pantallas = response.data;       
                console.log('Datos de pantalla: ',this.pantallas)
                })
                .catch(function (error) {
                    console.log(error);
                });

                // Segunda peticion traigo titulos de cada zona de pantalla
                await axios.post(url, {opcion:5, id_menu:1})
                .then(response =>{
                    this.titulos = response.data;       
                console.log('Datos de titulos: ',this.titulos)
                })
                .catch(function (error) {
                    console.log(error);
                });

                // Tercer peticion traigo items de cada menu

                await axios.post(url, {opcion:6, id_menu:1})
                .then(response =>{
                    this.links = response.data;       
                 console.log('Datos de links: ',this.links)
                })
                .catch(function (error) {
                    console.log(error);
                });
             
            }
    },
    created(){
        this.listarLinks()
    }
}

</script>
