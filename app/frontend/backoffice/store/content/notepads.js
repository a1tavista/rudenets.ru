import notepadsService from "../../services/notepadsService";
import Notepad from "../models/notepad";
import debounce from 'lodash.debounce';
import VuexPersistence from 'vuex-persist'

const state = {
  current: new Notepad(),
  isSaving: false,
  isLoading: false,
  items: [],
  tree: [],
  timestamp: 0
};

const getters = {
  getNotepads: ({items}) => items,
  getNotepadsTree: ({tree}) => tree,
  getNotepadsTimestamp: ({timestamp}) => timestamp,
  getCurrentNotepad: ({current}) => current
};

const actions = {
  fetchNotepads({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: notepadsService.index,
      collection: 'notepads'
    });
  },

  fetchNotepadsTree({commit}, payload) {
    commit('updateLoadingStatus', {collection: 'notepads', isLoading: true});
    notepadsService.tree().then(response => {
      commit('setTree', {tree: response.data.tree, timestamp: +(new Date())});
      commit('updateLoadingStatus', {collection: 'notepads', isLoading: false});
    });
  },

  createNotepad({dispatch, commit}, payload) {
    notepadsService
      .create(payload)
      .then(_ => {
        dispatch('fetchNotepads');
        dispatch('fetchNotepadsTree');
        dispatch('fetchCurrentNotepad');
        commit('updateSavingStatus', {collection: 'notepads', saving: false});
      });
  },

  fetchNotepad({commit}, {id}) {
    notepadsService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'notepads',
        content: response.data
      });
    });
  },

  fetchCurrentNotepad({commit}) {
    notepadsService.getCurrent().then((response) => {
      commit('updateEntry', {
        collection: 'notepads',
        content: response.data
      });
    });
  },

  updateNotepadField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'notepads',
      content: {[field]: value}
    });
    dispatch('saveNotepad', {newNotepad: false});
  },

  saveNotepad: debounce(function ({commit, dispatch}, {newNotepad}) {
    const notepad = Object.assign({}, state.current, { timestamp: undefined });
    commit('updateSavingStatus', { collection: 'notepads', saving: true });
    notepadsService
      .update(state.current.id, notepad)
      .then(_ => {
        dispatch('fetchNotepadsTree');
        commit('updateSavingStatus', { collection: 'notepads', saving: false });
      })
      .catch(_ => {
        dispatch('')
      });
  }, 500),
};

const mutations = {
  setTree(state, {tree, timestamp}) {
    state.tree = tree;
    state.timestamp = timestamp;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
