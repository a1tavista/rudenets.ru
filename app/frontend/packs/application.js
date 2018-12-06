import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';

import highlight from 'highlight.js';

highlight.initHighlightingOnLoad();

Vue.use(VueAxios, axios);

import LinkForm from '../application/components/LinkForm.vue';

const app = new Vue({
  el: '#application',
  components: {LinkForm}
});

export {app}