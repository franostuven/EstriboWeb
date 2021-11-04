<template>
    <div>
       <h1 class="p-mb-3 p-text-center">GESTORES</h1>
       <listar-pantallas :id="3" ></listar-pantallas>
    </div>
</template>

<script>

import ListarPantallas from '../components/ListarPantallas.vue'

export default {
    components:{
        ListarPantallas
    }
}
</script>