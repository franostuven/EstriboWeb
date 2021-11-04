<template>
    <div class="p-grid p-ai-stretch vertical-container">
        <div class="p-col-12 md-3">
            <div class="box box-stretched"></div>
        </div>
        <div class="p-col-12 md-6">
            <div class="box box-stretched"><h1>ADMINISTRADOR</h1></div>
        </div>
        <div class="p-col-12 md-3">
            <div class="box box-stretched"></div>
        </div>
    </div>
    <div class="p-grid p-p-2">
        <div class="p-col">
            <Card  class="p-shadow-18 p-mb-2" :style = "{width: myAncho, background: myFondo}">
                <template #title>
                    Administrar Tarjetas
                </template>

                <template #content>
                    <p>Este menu es para modificar los Titulos que hay en las Tarjetas y los Pie de Tarjeta.</p>
                </template>
                
                <template #footer>
                    <Button icon="pi pi-check" label="ingresar" @click="modificaTarjetas"/>
                </template>                
            </Card>            
        </div>
     
        <div class="p-col">
            <Card class="p-shadow-18 p-mb-2" :style = "{width: myAncho, background: myFondo}">
                <template #title>
                    Administrar Links
                </template>
                
                <template #content>
                    <p>Este Menu Modifica Los Links de Cada Tarjeta. Seleccione la Tarjeta que quiera modificar y cambie, elimen o de de alta nuevos Links.</p>
                </template>

                <template #footer>
                    <Button icon="pi pi-check" label="Ingresar" @click="modificaLinks" />
                </template>
            </Card>                        
        </div>
     
    </div>

</template>

<script>
import { inject } from '@vue/runtime-core'
import {useRouter} from 'vue-router'

export default {

    setup(){
        

        const logout = inject('logout')
        const router = useRouter()

        const myAncho = '25rem'
        const myFondo =  '#A9DFBF'

      //  console.log('usuario desde ADMIN', logout.value)
        if(logout.value){
            router.push('/')
        }

        const modificaTarjetas = () => {
            router.push('/Tarjetas')
        }

        const modificaLinks = () => {
            router.push('/Links')
        }

        return { myAncho, myFondo, modificaTarjetas, modificaLinks}
    }
}
</script>

