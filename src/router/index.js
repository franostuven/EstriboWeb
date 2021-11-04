import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'


const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/gestores',
    name: 'Gestores',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/Gestores.vue')
  },
  {
    path: '/registros',
    name: 'Registros',
    component: () => import(/* webpackChunkName: "about" */ '../views/Registros.vue')
  },
  {
    path: '/sura',
    name: 'Sura',
    component: () => import(/* webpackChunkName: "about" */ '../views/Sura.vue')
  },
  {
    path: '/formularios',
    name: 'Formularios',
    component: () => import(/* webpackChunkName: "about" */ '../views/Formularios.vue')
  },
  {
    path: '/sellados',
    name: 'Sellados',
    component: () => import(/* webpackChunkName: "about" */ '../views/Sellados.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "about" */ '../views/Login.vue')
  },
  {
    path: '/admin',
    name: 'Admin',
    component: () => import(/* webpackChunkName: "about" */ '../views/Admin.vue'),
    meta: { requiresAuth: true }  
  },
  {
    path: '/tarjetas',
    name: 'Tarjetas',
    component: () => import(/* webpackChunkName: "about" */ '../views/Tarjetas.vue'),
    meta: { requiresAuth: true }  
  },
  {
    path: '/links',
    name: 'Links',
    component: () => import(/* webpackChunkName: "about" */ '../views/Links.vue'),
    meta: { requiresAuth: true }  
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

/* router.beforeEach((to, from, next) => {
  if (!to.matched.length) {
    next('/notFound');
  } else {
    next();
  }
}); */

 /* 
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
   
    console.log('el usuario esta en : ',logout)

    if (logout) {
      next({
        path: '/Home'
      })
    } else {
      next()
    }

  } else {
    next()
  }
}) */


export default router
