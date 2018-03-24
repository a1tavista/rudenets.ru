import Note from "../models/note";
import debounce from 'lodash.debounce';
import notesService from '../../services/notesService';

const state = {
  current: new Note(),
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getCurrentNote: ({current}) => current,
  getDrafts: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((note) => !note.entry.published)
    };
  },
  getPublished: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((note) => note.entry.published)
    };
  },
};

const actions = {
  fetchNotes({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: notesService.index,
      collection: 'notes'
    });
  },

  newNote({commit}, payload) {
    commit('updateEntry', {
      collection: 'notes',
      content: new Note()
    });
  },

  fetchNote({commit}, {id}) {
    notesService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'notes',
        content: response.data
      });
    });
  },

  updateNoteField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'notes',
      content: {[field]: value}
    });
    dispatch('saveNote');
  },

  publishNote({dispatch, commit}, payload) {
    notesService.publish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'notes',
        content: response.data
      });
      dispatch('fetchNotes');
    });
  },

  unpublishNote({dispatch, commit}, payload) {
    notesService.unpublish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'notes',
        content: response.data
      });
      dispatch('fetchNotes');
    });
  },

  saveNote: debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', {collection: 'notes', saving: true});
    if (state.current.id === null) {
      notesService.create(state.current).then(response => {
        commit('updateEntry', {
          collection: 'notes',
          content: {
            id: response.data.id
          }
        });
        commit('updateSavingStatus', {collection: 'notes', saving: false});
        dispatch('fetchNotes');
        dispatch('fetchLabels');
      });
    } else {
      notesService
        .update(state.current.id, state.current)
        .then(_ => {
          commit('updateSavingStatus', {collection: 'notes', saving: false});
          dispatch('fetchLabels');
        });
    }
  }, 500),

  deleteNote({dispatch}) {
    notesService.remove(state.current.id).then(_ => {
      dispatch('newNote');
      dispatch('fetchNotes');
    });
  },
};

export default {
  state,
  getters,
  actions
};
