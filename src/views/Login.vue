<template>
    <Toast />
    <div class="p-d-flex p-jc-center">
        <div class="p-m-3">

        <Card style="width: 20rem" class="p-shadow-14" >
            <template #header>
                <div class="flex justify-content-between">
                    <div></div>
                    <div class="flex align-item-center justify-content-center">
                        <img src="../assets/estribo.jpg" alt="Image" height="50" width="25" class="mb-3">
                    </div>
                    <div></div>
                </div>
            </template>
            <template #title>
                Sistema Estribo
            </template>
            <template #subtitle>
                ingreso al Sistema Admin.
            </template>

            <template #content>
        
                <span class="p-float-label p-mb-4">
                    <InputText id="email1" type="text" class="w-full" v-model.trim="mail" />
                    <label for="email1" class="block text-900 font-medium ">Email</label>
                </span>

                <span class="p-float-label">
                    <InputText id="password1" type="password" class="w-full" v-model.trim="pass"/>
                    <label for="password1" class="block text-900 font-medium ">Clave</label>

                </span>

            </template>

            <template #footer>
                <div>
                    <Button label="Cancelar" icon="pi pi-ban"  class="w-full p-mr-2" @click="cancelaLogin"></Button>
                    <Button label="Ingresar" icon="pi pi-user" class="w-full" @click="ingresoAdmin"></Button>
                </div>

            </template>
        </Card>
        </div>        
    </div>
</template>


<script>

//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO
let url = "crud.php";  // produccion

import { ref } from '@vue/reactivity'
import { useToast } from "primevue/usetoast";
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { inject } from '@vue/runtime-core'

//import { useRoute } from 'vue-router'

//import { computed } from '@vue/runtime-core';



export default {
   setup(){
       const toast = useToast();
       const store = useStore()

       const mail = ref('')
       const pass = ref('')
       let  mailRecuperado = ref() 
      
       const logout = inject('logout')

       const router = useRouter()
 

       const cancelaLogin = () => {
           store.dispatch("accionLogin",true)
           logout.value= true
    
           router.push('/')
       }

       const ingresoAdmin = async () =>{
            await axios.post(url, {opcion:7, id_menu:mail.value})
            .then(response =>{
                mailRecuperado = response.data;       
              //S  console.log('usuario recup: ',mailRecuperado)
            })
            .catch(function (error) {
                console.log(error);
            });

            if(mailRecuperado.length>0){
                mailRecuperado.forEach(element => {
                    
                    if (element.clave === pass.value){
                        toast.add({severity:'success', summary: 'Acceso al Sistema', detail:'Autorizado a la Administración', life: 6000});
                       
                    }else {
                        toast.add({severity:'error', summary: 'Acceso NO Autorizado', detail:'La combinación de Usuario y Contraseña no es válida', life: 6000});
                        return
                    }

                });
            }else {
                toast.add({severity:'error', summary: 'Acceso NO Autorizado', detail:'La combinación de Usuario y Contraseña no es válida', life: 6000});
                return
            }

           
            pass.value = ''
            mail.value = ''
            store.dispatch("accionLogin",false)
            logout.value= false
            router.push('/')

            };

        return {mail, pass, ingresoAdmin, cancelaLogin}

   }
}
</script>

<style>

</style>