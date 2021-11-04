<template>
    
    <div class="container p-d-flex p-flex-wrap" >
        <div class="p-grid p-p-3">
           <div class="p-col-12 p-m-3 p-text-center"><h3>Listado de Registros</h3></div>
           <div class="p-col-1 p-m-1 p-text-center" style="background: #ABEBC6" v-for="(myLink, orden) in links" :key="orden">
               <a :href="myLink.path1" target="_blank">{{myLink.descripcion_link}}</a>
           </div>
        </div> 
    </div>
</template>




<script>
//let url = "src/libreries/crud.php";
//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO
let url = "crud.php";     //PRODUCCION

export default {
    props:{
        id: Number
    },
    data(){
      return {
          pantallas: [],
          titulos: [],
          links: []
      }
    },
    methods: {
        getImgUrl(imagen){
            return require('../assets/'+imagen)
        },
        //PROCEDIMIENTOS para el CRUD     
            async listarLinks () {

              //  console.log('ENTRE AL LISTARLINKS',this.id);
                // Primer peticion Trae las cabeceras y pies de pantalla.                              
                await axios.post(url, {opcion:4, id_menu:this.id})
                .then(response =>{
                    this.pantallas = response.data;       
                //console.log('Datos de pantalla: ',this.pantallas)
                })
                .catch(function (error) {
                    console.log(error);
                });

                // Segunda peticion traigo titulos de cada zona de pantalla
                await axios.post(url, {opcion:5, id_menu:this.id})
                .then(response =>{
                    this.titulos = response.data;       
               // console.log('Datos de titulos: ',this.titulos)
                })
                .catch(function (error) {
                    console.log(error);
                });

                // Tercer peticion traigo items de cada menu

                await axios.post(url, {opcion:6, id_menu:this.id})
                .then(response =>{
                    this.links = response.data;       
                 //console.log('Datos de links: ',this.links)
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

<style>
    table{
        width:10%;
    }
    td{
        border:2px solid black;
    }
</style>