import request from '../../api/request';
import labelsService from '../../services/labelsService';
import notesService from '../../services/notesService';
import * as _ from "lodash";

const state = {
  currentNote: {
    id: null,
    title: null,
    text: null,
    summary: null,
    tagList: [],
    entry: {}
  },
  currentNoteSaving: false,
  notes: {
    isLoading: false,
    items: [],
  },
  labels: {
    isLoading: false,
    items: []
  }
};

const getters = {
  getLabels: ({labels}) => labels,
  getDrafts: ({notes}) => {
    return {
      isLoading: notes.isLoading,
      items: notes.items.filter((note) => !note.entry.published)
    };
  },
  getPublished: ({notes}) => {
    return {
      isLoading: notes.isLoading,
      items: notes.items.filter((note) => note.entry.published)
    };
  },
  getCurrentNote: ({currentNote}) => {
    return currentNote;
  }
};

const actions = {
  initializeApplicationData({dispatch}) {
    dispatch('fetchLabels');
    dispatch('fetchNotes');
  },

  fetchLabels({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: labelsService.index,
      collection: 'labels'
    });
  },

  fetchNotes({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: notesService.index,
      collection: 'notes'
    });
  },

  fetchCollection({commit}, {serviceMethod, collection}) {
    commit('updateLoadingStatus', {collection: collection, isLoading: true});
    serviceMethod().then(response => {
      commit('setItems', {collection: collection, items: response.data});
      commit('updateLoadingStatus', {collection: collection, isLoading: false});
    });
  },

  newNote({commit}, payload) {
    commit('updateNote', {
      id: null,
      title: null,
      text: null,
      summary: null,
      tagList: [],
      entry: {}
    });
  },

  fetchNote({commit}, {id}) {
    notesService.get(id).then((response) => {
      commit('updateNote', response.data);
    });
  },

  updateNoteField({commit, dispatch}, {field, value}) {
    commit('updateNote', {[field]: value});
    dispatch('saveNote');
  },

  saveNote: _.debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', true);
    if (state.currentNote.id === null) {
      notesService.create(state.currentNote).then(response => {
        commit('updateNote', {id: response.data.id});
        commit('updateSavingStatus', false);
        dispatch('fetchNotes');
      });
    } else {
      notesService
        .update(state.currentNote.id, state.currentNote)
        .then(response => {
          commit('updateSavingStatus', false);
        });
    }
  }, 500),

  publishNote({dispatch, commit}, payload) {
    notesService.publish(state.currentNote.id).then(response => {
      commit('updateNote', response.data);
      dispatch('fetchNotes');
    });
  },

  unpublishNote({dispatch, commit}, payload) {
    notesService.unpublish(state.currentNote.id).then(response => {
      commit('updateNote', response.data);
      dispatch('fetchNotes');
    });
  },

  deleteNote({dispatch}) {
    notesService.remove(state.currentNote.id).then(_ => {
      dispatch('newNote');
      dispatch('fetchNotes');
    });
  }
};

const mutations = {
  setItems(state, {collection, items}) {
    state[collection].items = items;
  },

  updateLoadingStatus(state, {collection, isLoading}) {
    state[collection].isLoading = isLoading;
  },

  updateNote(state, note) {
    state.currentNote = Object.assign(state.currentNote, note);
    const idx = state.notes.items.findIndex((note) => +note.id === +state.currentNote.id);
    if (idx === -1) return;
    Object.assign(state.notes.items[idx], note);
  },

  updateSavingStatus(state, isSaving) {
    state.currentNoteSaving = isSaving;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
