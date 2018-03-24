import Vue from 'vue';
import Vuex from 'vuex';

const debug = process.env.NODE_ENV !== 'production';

const vuexLocal = new VuexPersistence({
  strictMode: debug,
  storage: window.localStorage
});

// -----------------------------------------
// Utility modules
// -----------------------------------------
import layout from './modules/layout';

// -----------------------------------------
// Content modules
// -----------------------------------------
import notepads from './content/notepads';
import links from './content/links';
import notes from './content/notes';
import pages from './content/pages';
import labels from './content/labels';
import VuexPersistence from "vuex-persist/dist/index";

Vue.use(Vuex);

const actions = {
  initializeApplicationData({dispatch}) {
    dispatch('fetchLabels');
    dispatch('fetchNotes');
    dispatch('fetchPages');
    dispatch('fetchLinks');
    dispatch('fetchNotepads');
    dispatch('fetchNotepadsTree');
  },

  fetchCollection({commit}, {serviceMethod, collection}) {
    commit('updateLoadingStatus', {collection: collection, isLoading: true});
    serviceMethod().then(response => {
      commit('setItems', {collection: collection, items: response.data});
      commit('updateLoadingStatus', {collection: collection, isLoading: false});
    });
  },
};

const mutations = {
  setItems(state, {collection, items}) {
    state[collection].items = items;
  },

  updateLoadingStatus(state, {collection, isLoading}) {
    state[collection].isLoading = isLoading;
  },

  updateEntry(state, payload) {
    state[payload.collection].current = Object.assign(state[payload.collection].current, payload.content);
    const idx = state[payload.collection].items.findIndex((entry) => +entry.id === +state[payload.collection].current.id);
    if (idx === -1) return;
    Object.assign(state[payload.collection].items[idx], payload.content);
  },

  updateSavingStatus(state, payload) {
    state[payload.collection].isSaving = payload.saving;
  },
};

const store = new Vuex.Store({
  modules: {
    layout,
    notepads,
    links,
    notes,
    pages,
    labels,
  },
  actions,
  mutations,
  strict: debug,
  // plugins: [vuexLocal.plugin]
});

export default store;
