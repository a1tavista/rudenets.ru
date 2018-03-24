import Page from '../models/page';
import debounce from 'lodash.debounce';
import pagesService from "../../services/pagesService";

const state = {
  current: new Page(),
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getCurrentPage: ({current}) => current,
  getPages: ({items}) => items,
};

const actions = {
  fetchPages({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: pagesService.index,
      collection: 'pages'
    });
  },

  fetchPage({commit}, {id}) {
    pagesService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'pages',
        content: response.data
      });
    });
  },

  updatePageField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'pages',
      content: {[field]: value}
    });
    dispatch('savePage');
  },

  savePage: debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', {collection: 'pages', saving: true});
    pagesService
      .update(state.current.id, state.current)
      .then(_ => {
        commit('updateSavingStatus', {collection: 'pages', saving: false});
        dispatch('fetchPages');
      });
  }, 500),
};

export default {
  state,
  getters,
  actions
};
