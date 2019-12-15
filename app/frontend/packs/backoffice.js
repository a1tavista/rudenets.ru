import Vue from 'vue';
import store from '../backoffice/store';
import router from '../backoffice/router';
import {sync} from 'vuex-router-sync';

import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/en';
import VueCodeMirror from 'vue-codemirror';

sync(store, router);

Vue.use(ElementUI, { locale });
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
