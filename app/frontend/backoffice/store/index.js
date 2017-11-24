import Vue from 'vue';
import Vuex from 'vuex';

import backofficeLayout from './modules/backofficeLayout';
import data from './modules/data';

const debug = process.env.NODE_ENV !== 'production';

Vue.use(Vuex);

const store = new Vuex.Store({
  // actions,
  modules: {
    data,
    backofficeLayout,
  //   currentNote
  },
  strict: debug
});

export default store;
