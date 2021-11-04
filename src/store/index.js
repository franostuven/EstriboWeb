import { createStore } from 'vuex'

export default createStore({
  state: {
    logout:true
  },
  mutations: {
    setLogin(state, payload){
      state.logout = payload
    //  console.log('en la mutacion: ', state.logout)
    }
  },
  actions: {
     accionLogin({commit}, logout ){
       commit('setLogin', logout)
     }
  },
  modules: {
  }
})
