import Vue from 'vue';
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios);

import LinkForm from './components/LinkForm.vue';
import PostForm from './components/PostForm.vue';

const app = new Vue({
  el: '#application',
  components: {LinkForm, PostForm}
});

export {app}
