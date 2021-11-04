<template>
    <div >
       <h1 class="p-mb-3 p-text-center">SELLADOS</h1>

       <listar-tabla :id="5" ></listar-tabla>
    </div>
</template>

<script>


import ListarTabla from '../components/ListarTabla.vue'

export default {
    components:{
        ListarTabla
    }
}
</script>