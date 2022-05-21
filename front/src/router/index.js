import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [{
    path: '/login',
    name: 'login',
    component: () => import( /* webpackChunkName: "about" */ '@/views/auth/TheLogin.vue')
  },
  {
    path: '/chatroom',
    name: 'chatroom',
    component: () => import( /* webpackChunkName: "about" */ '@/views/ChatRoom.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router