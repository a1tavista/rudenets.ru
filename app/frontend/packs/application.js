import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';

Vue.use(VueAxios, axios);

import LinkForm from '../application/components/LinkForm.vue';

const app = new Vue({
  el: '#application',
  components: {LinkForm}
});

export {app}
