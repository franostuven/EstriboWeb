<template>
    
    <div class="container" >
        <div class="p-grid p-mb-4">
           
            <Card :style = "{width: myAncho, background: myFondo}" class="p-m-3 p-pt-2 p-shadow-18"  
                v-for="(titulo, indice) in titulos" :key="indice">
                <template #header v-if="titulo.imagen_path.trim() !=''">
                    <!-- <img src="https://www.primefaces.org/wp-content/uploads/2020/02/primefacesorg-primevue-2020.png" style="height: 15rem" /> -->
                    <img :src= getImgUrl(titulo.imagen_path) style="height: 15rem"  :alt="titulo.imagen_path"/>
                </template> 
                <template #title class="p-text-center">
                    {{titulo.descripcion_titulo}}
                </template>

                <template #content >
                    <span  v-for="(myLink, orden) in links" :key="orden" >
                        <span v-if="myLink.id_titulo === titulo.id_titulo">
                            <h4>{{myLink.orden}} - <a :href="myLink.path1" target="_blank">{{myLink.descripcion_link}}</a>  </h4>
                        </span>
                    </span>
                    
                </template>

                <template #footer>
                    <strong>{{titulo.footer}}</strong>
                </template>
            </Card>
        </div>
      
    </div>
</template>




<script>
//let url = "../libreries/crud.php";
//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO

let url = "crud.php";   //produccion

export default {
    props:{
        id: Number
    },
    data(){
      return {
          pantallas: [],
          titulos: [],
          links: [],
          myAncho: '25rem',
          myFondo:  '#A9DFBF',
          laImagen: 'formularios.jpg'
        
      }
    },
    computed:{
        Imagen(laImagen){
            return  laImagen
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
