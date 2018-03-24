import Link from '../models/link';
import debounce from 'lodash.debounce';
import linksService from "../../services/linksService";

const state = {
  current: new Link(),
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getCurrentLink: ({current}) => current,
  getLinks: ({items}) => items,
};

const actions = {
  fetchLinks({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: linksService.index,
      collection: 'links'
    });
  },

  fetchLink({commit}, {id}) {
    linksService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'links',
        content: response.data
      });
    });
  },

  updateLinkField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'links',
      content: {[field]: value}
    });
    dispatch('saveLink');
  },

  saveLink: debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', {collection: 'links', saving: true});
    linksService
      .update(state.current.id, state.current)
      .then(_ => {
        commit('updateSavingStatus', {collection: 'links', saving: false});
        dispatch('fetchLinks');
      });
  }, 500),

  publishLink({dispatch, commit}, payload) {
    linksService.publish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'links',
        content: response.data
      });
      dispatch('fetchLinks');
    });
  },

  unpublishLink({dispatch, commit}, payload) {
    linksService.unpublish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'links',
        content: response.data
      });
      dispatch('fetchLinks');
    });
  },

  deleteLink({dispatch}) {
    linksService.remove(state.current.id).then(_ => {
      dispatch('fetchLinks');
    });
  }
};

const mutations = {

};

export default {
  state,
  getters,
  actions
};
