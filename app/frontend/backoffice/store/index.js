import Vue from 'vue';
import Vuex from 'vuex';

import backofficeLayout from './modules/backofficeLayout';
import posts from './modules/posts';

const debug = process.env.NODE_ENV !== 'production';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    posts,
    backofficeLayout,
  },
  strict: debug
});

export default store;
