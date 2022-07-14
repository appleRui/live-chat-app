import Vue from 'vue'
import VueRouter from 'vue-router'
import useValidate from '../auth/validate'
import { getUid, getAccessToken, getClient} from '@/services/localStorage'

const {
  validate
} = useValidate()

const requireAuth = async (to, from, next) => {
  const uid = getUid()
  const client = getAccessToken()
  const accessToken = getClient()

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