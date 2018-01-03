import Vue from 'vue';
import Vuex from 'vuex';

import backofficeLayout from './modules/backofficeLayout';
import backofficeContent from './modules/backofficeContent';

const debug = process.env.NODE_ENV !== 'production';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    backofficeContent,
    backofficeLayout,
  },
  strict: debug
});

export default store;
