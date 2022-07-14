import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false

// vue-cookie
import VueCookie from 'vue-cookie';
Vue.use(VueCookie);

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')