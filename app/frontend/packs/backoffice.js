import Vue from 'vue';
import store from '../backoffice/store';
import router from '../backoffice/router';
import {sync} from 'vuex-router-sync';

sync(store, router);

import VueCodeMirror from 'vue-codemirror'

Vue.use(VueCodeMirror, {
  options: {
    tabSize: 2,
    lineNumbers: true,
    line: true,
  }
});

import App from '../backoffice/App.vue';

const app = new Vue({
  el: '#application',
  router,
  store,
  render: h => h(App)
});

export {app, router, store}
