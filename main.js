import Vue from 'vue'
import App from '@/app.vue'
import Input from '@/components/input.vue'

Vue.config.productionTip = false

Vue.component('x-input', Input)

new Vue({
  render: h => h(App),
}).$mount('#app')
