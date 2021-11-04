<template>
    <div>
        <Button class="p-button-md" label="Menu"  icon="pi pi-arrow-right" @click="visibleLeft = true" /> 
        <Sidebar v-model:visible="visibleLeft" style="background-color:green: font-size: 24pt">
           
            <h2 class="p-text-center"><router-link to="/">{{msg}}</router-link></h2>

            <div class="containe"  style="font-size:18pt;">

                <div class="p-m-1 p-p-1 estriboMenu">
                    <router-link to="/Registros" >Registros</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                    <router-link to="/Sura">Sura</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Gestores">Gestores</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Formularios">Formularios</router-link>
                </div>
                <hr>
                <div class="p-m-1 p-p-1 estriboMenu">
                     <router-link to="/Sellados">Sellados</router-link>
                </div>
                <hr>
            </div>
           <!--  <a :to="/"></a>
            <a :to="/Registros">Registros</a> 

            <a :to="/Sura">Sura</router-link> 
    
            <a  :to="/Gestores">Gestores</a> 
    
            <a  :to="/Formularios">Formularios</a> 

            <a  :to="/Sellados" v-tooltip.left="Habilitaciones">Sellados</a>  -->


            <!-- <router-link tag="li" to="/">
                <a>Home</a>
            </router-link> 
            
            <router-link to="/about">About</router-link> -->
        </Sidebar>
        
        

    <!--     <Menubar :model="items">
            <template #start>
                <Avatar image="../assets/logo.gif" shape="circle" class="p-mr-4" size="xlarge"></Avatar>
              
            </template>
        </Menubar> -->
  
    </div>
</template>

<script>
export default {
    name: 'MenuPrincipal',
    props:{
        msg:String
    },
    data(){
        return {
            visibleLeft : false
        }
    }
}
</script>

<style>
    a {
        text-decoration:none;
    }

    .estriboMenu:hover {
        background-color: rgb(255, 222, 132);
        text-decoration-color: black;
    }

/*     .estriboMenu:hover {
        background-color: rgb(228, 228, 228);
        text-decoration-color: black;
    }
 */
</style>