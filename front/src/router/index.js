import Vue from 'vue'
import VueRouter from 'vue-router'
import useValidate from '../auth/validate'

const {
  validate
} = useValidate()

const requireAuth = async (to, from, next) => {
  const uid = window.localStorage.getItem('uid')
  const client = window.localStorage.getItem('client')
  const accessToken = window.localStorage.getItem('access-token')

  if (!uid || !client || !accessToken) {
    alert('ログインしていません')
    next({
      name: 'login'
    })
    return
  }

  await validate()

  next()
}

Vue.use(VueRouter)

const routes = [{
    path: '/login',
    name: 'login',
    component: () => import( /* webpackChunkName: "about" */ '@/views/auth/TheLogin.vue')
  },
  {
    path: '/',
    name: 'root',
    redirect: {
      name: 'chatroom'
    }
  },
  {
    path: '/chatroom',
    name: 'chatroom',
    component: () => import( /* webpackChunkName: "about" */ '@/views/ChatRoom.vue'),
    beforeEnter: requireAuth
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router