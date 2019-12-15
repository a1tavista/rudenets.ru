import Vue from 'vue';
import Vuex from 'vuex';

const debug = process.env.NODE_ENV !== 'production';

// -----------------------------------------
// Content modules
// -----------------------------------------
import links from './content/links';
import posts from './content/posts';
import pages from './content/pages';

Vue.use(Vuex);

const actions = {
  initializeApplicationData({dispatch}) {
    dispatch('fetchPosts');
    dispatch('fetchPages');
    dispatch('fetchLinks');
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
    links,
    posts,
    pages,
  },
  actions,
  mutations,
  strict: debug
});

export default store;
