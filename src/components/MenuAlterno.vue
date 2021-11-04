<template>
    <div>
        <Menubar :model="items">
            <template #start>
                 <a href="/" ><img src="../assets/logo.gif" width="80"  alt="Avatar"></a>
            </template>

            <template #end>
               
                    <Button label="Ingresar" icon="pi pi-user"  v-if="logout"
                        class="p-button-raised p-button-rounded" 
                        @click="loginUsuario"/>

                    <Button label="Cerrar Session" icon="pi pi-power-off" v-if="!logout" 
                        class="p-button-raised p-button-rounded p-button-warning" 
                        @click="cerrarSesion"/>
                
            </template>
        </Menubar>
    </div>

</template>

<script>
import { mapState } from 'vuex'
import { mapActions } from 'vuex'

//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO
//let url = "../libreries/crud.php";
let url = "crud.php";   //PRODUCCION


export default {
    name:'MenuAlterno',
   data(){
       return{ 
           menu:[],
           items:[],
              
       }
    }, 

    methods: {
        loginUsuario() {
             this.$router.push('Login')
           
           //  this.$router.push('Home:verDialogo')
        },
        cerrarSesion(){
            this.accionLogin(true)
            this.$router.push('/')
        },

        async cargarMenu() {
            await axios.post(url, {opcion:1})
                .then(response =>{
                    this.menu = response.data;       
                // console.log('Datos de MENU: ',this.menu)
                
                for (let i= 0; i<this.menu.length; i++){
                    const obj = {label: this.menu[i].label, icon: this.menu[i].icon, to: this.menu[i].url}
                    this.items.push(obj)
                   // console.log(obj)
                };
                
                //console.log('ITEMS: '+ this.items)

                
                })
                .catch(function (error) {
                    console.log(error);
                });

        },
        ...mapActions(['accionLogin'])
    },
    
    created(){
        this.cargarMenu()
    },
    computed:{
        ...mapState(['logout'])
    }
    
}

</script>

<style scoped>
    img {
        border-radius:30%;
    }
</style>