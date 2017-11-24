import request from '../../api/request';

const state = {
  currentNoteId: null,
  published: {
    isLoading: false,
    items: [],
  },
  drafts: {
    isLoading: false,
    items: [],
  },
  labels: {
    isLoading: false,
    items: []
  }
};

const getters = {
  getLabels: (state) => state.labels,
  getDrafts: (state) => state.drafts,
  getPublished: (state) => state.published
};

const actions = {
  initializeApplicationData({dispatch}) {
    dispatch('fetchLabels');
    dispatch('fetchPublishedNotes');
    dispatch('fetchDraftsNotes');
  },
  fetchLabels({commit}, payload) {
    const kind = 'labels';
    commit('updateLoadingStatus', { kind: kind, status: true });
    request.get('/api/labels.json').then(response => {
      commit('setItems', { kind: kind, items: response.data });
      commit('updateLoadingStatus', { kind: kind, status: false });
    });
  },
  fetchPublishedNotes({commit}, payload) {
    const kind = 'published';
    commit('updateLoadingStatus', { kind: kind, status: true });
    request.get('/api/posts/published.json').then(response => {
      commit('setItems', { kind: kind, items: response.data });
      commit('updateLoadingStatus', { kind: kind, status: false });
    });
  },
  fetchDraftsNotes({commit}, payload) {
    const kind = 'drafts';
    commit('updateLoadingStatus', { kind: kind, status: true });
    request.get('/api/posts/private.json').then(response => {
      commit('setItems', { kind: kind, items: response.data });
      commit('updateLoadingStatus', { kind: kind, status: false });
    });
  }
};

const mutations = {

  setItems(state, {kind, items}) {
    state[kind].items = items;
  },

  updateLoadingStatus(state, {kind, status}) {
    state[kind].isLoading = status;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
