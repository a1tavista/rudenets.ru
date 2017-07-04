import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';
import store from '../backoffice/store';
import router from '../backoffice/router';
import {sync} from 'vuex-router-sync';

sync(store, router);

Vue.use(VueAxios, axios);

import App from '../backoffice/App.vue';

const app = new Vue({
  el: '#application',
  router,
  store,
  render: h => h(App)
});

export {app, router, store}
