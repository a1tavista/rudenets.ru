import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';

Vue.use(VueAxios, axios);

import LinkForm from '../application/components/LinkForm.vue';
import PostForm from '../backoffice/components/PostForm.vue';

const app = new Vue({
  el: '#application',
  components: {LinkForm, PostForm}
});

export {app}
