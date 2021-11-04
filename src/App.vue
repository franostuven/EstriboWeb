<template>
  <div id="nav">
   
    <menu-alterno></menu-alterno>
    <!-- <menu-principal msg="Menu Estribo"></menu-principal>  -->
  </div>
  <router-view/>

  <footer >
      <div class="p-text-center p-p-3" style="background: #A9DFBF">

        <strong >
          Santa Fe 1890 (2600)  - Venado Tuerto	- Santa Fe  - Argentina
        </strong>
        <hr>
        <strong>
			    Teléfono Fijo: 03462 434809  -   Celular 03462 15419789	
          <a href="mailto:SistemasEstribo@gmail.com">SistemasEstribo@gmail.com</a>
        </strong>
      </div>
			
			
  </footer>
</template>

<script>
import MenuPrincipal from '@/components/MenuPrincipal'
import MenuAlterno from '@/components/MenuAlterno'
import { provide } from '@vue/runtime-core'
import { useStore } from 'vuex'
import { ref } from 'vue'


export default {
  components: {
    MenuPrincipal,
    MenuAlterno
    
  },
  setup(){


    const store = useStore()
    
    const logout = ref(store.state.logout)


   // console.log("logout en App del store: ",logout.value)
    provide("logout", logout)
  }
}
</script>

<style scoped>

 footer {
   bottom: auto;
   width:100%;
    
 }
/* 
#app { 
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
 */</style>
