<template lang="">
    <div>
        <h1 class="p-mb-3 p-text-center">SURA</h1>

        <listar-pantallas :id="2"></listar-pantallas>
    </div>
</template>
<script>
import ListarPantallas from '@/components/ListarPantallas'

export default {
    components:{
        ListarPantallas
    }    
}
</script>
