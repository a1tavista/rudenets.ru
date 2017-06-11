import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';

import App from '../backoffice/App.vue';

const app = new Vue({
  el: '#application',
  render: h => h(App)
});

export {app}
