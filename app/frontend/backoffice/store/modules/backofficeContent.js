// Utils
import * as _ from "lodash";

// Services
import labelsService from '../../services/labelsService';
import notesService from '../../services/notesService';
import notepadsService from '../../services/notepadsService';
import linksService from "../../services/linksService";
import pagesService from "../../services/pagesService";

// Models
import Note from '../../models/note';
import Link from '../../models/link';
import Page from '../../models/page';
import Notepad from "../../models/notepad";

const state = {
  current: {
    note: new Note(),
    link: new Link(),
    page: new Page(),
    notepad: new Notepad()
  },
  saving: {
    note: false,
    notepad: false,
    link: false,
    page: false
  },
  notepads: {
    isLoading: false,
    items: [],
  },
  notes: {
    isLoading: false,
    items: [],
  },
  labels: {
    isLoading: false,
    items: []
  },
  links: {
    isLoading: false,
    items: []
  },
  pages: {
    isLoading: false,
    items: []
  }
};

const getters = {
  getLabels: ({labels}) => labels,
  getNotepads: ({notepads}) => notepads.items,
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
  getLinks: ({links}) => links,
  getPages: ({pages}) => pages,
  getCurrentNotepad: ({current}) => {
    return current.notepad;
  },
  getCurrentNote: ({current}) => {
    return current.note;
  },
  getCurrentLink: ({current}) => {
    return current.link;
  },
  getCurrentPage: ({current}) => {
    return current.page;
  }
};

const actions = {
  // ------------------------------- [Fetch collections] -------------------------------
  initializeApplicationData({dispatch}) {
    dispatch('fetchLabels');
    dispatch('fetchNotes');
    dispatch('fetchPages');
    dispatch('fetchLinks');
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

  fetchNotepads({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: notepadsService.index,
      collection: 'notepads'
    });
  },

  fetchLinks({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: linksService.index,
      collection: 'links'
    });
  },

  fetchPages({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: pagesService.index,
      collection: 'pages'
    });
  },

  fetchCollection({commit}, {serviceMethod, collection}) {
    commit('updateLoadingStatus', {collection: collection, isLoading: true});
    serviceMethod().then(response => {
      commit('setItems', {collection: collection, items: response.data});
      commit('updateLoadingStatus', {collection: collection, isLoading: false});
    });
  },

  // ------------------------------- [Notes] -------------------------------
  newNote({commit}, payload) {
    commit('updateEntry', {
      entry: 'note',
      collection: 'notes',
      content: new Note()
    });
  },

  fetchNote({commit}, {id}) {
    notesService.get(id).then((response) => {
      commit('updateEntry', {
        entry: 'note',
        collection: 'notes',
        content: response.data
      });
    });
  },

  updateNoteField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      entry: 'note',
      collection: 'notes',
      content: {[field]: value}
    });
    dispatch('saveNote');
  },

  saveNote: _.debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', { entry: 'note', saving: true });
    if (state.current.note.id === null) {
      notesService.create(state.current.note).then(response => {
        commit('updateEntry', {
          entry: 'note',
          collection: 'notes',
          content: {
            id: response.data.id
          }
        });
        commit('updateSavingStatus', { entry: 'note', saving: false });
        dispatch('fetchNotes');
        dispatch('fetchLabels');
      });
    } else {
      notesService
        .update(state.current.note.id, state.current.note)
        .then(_ => {
          commit('updateSavingStatus', { entry: 'note', saving: false });
          dispatch('fetchLabels');
        });
    }
  }, 500),

  publishNote({dispatch, commit}, payload) {
    notesService.publish(state.current.note.id).then(response => {
      commit('updateEntry', {
        entry: 'note',
        collection: 'notes',
        content: response.data
      });
      dispatch('fetchNotes');
    });
  },

  unpublishNote({dispatch, commit}, payload) {
    notesService.unpublish(state.current.note.id).then(response => {
      commit('updateEntry', {
        entry: 'note',
        collection: 'notes',
        content: response.data
      });
      dispatch('fetchNotes');
    });
  },

  deleteNote({dispatch}) {
    notesService.remove(state.current.note.id).then(_ => {
      dispatch('newNote');
      dispatch('fetchNotes');
    });
  },

  // ------------------------------- [Pages] -------------------------------
  fetchPage({commit}, {id}) {
    pagesService.get(id).then((response) => {
      commit('updateEntry', {
        entry: 'page',
        collection: 'pages',
        content: response.data
      });
    });
  },

  updatePageField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      entry: 'page',
      collection: 'pages',
      content: {[field]: value}
    });
    dispatch('savePage');
  },

  savePage: _.debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', { entry: 'page', saving: true });
    pagesService
      .update(state.current.page.id, state.current.page)
      .then(_ => {
        commit('updateSavingStatus', { entry: 'page', saving: false });
        dispatch('fetchPages');
      });
  }, 500),
  // ------------------------------- [Notepads] -------------------------------
  fetchNotepad({commit}, {id}) {
    notepadsService.get(id).then((response) => {
      commit('updateEntry', {
        entry: 'notepad',
        collection: 'notepads',
        content: response.data
      });
    });
  },

  fetchCurrentNotepad({commit}) {
    notepadsService.getCurrent().then((response) => {
      commit('updateEntry', {
        entry: 'notepad',
        collection: 'notepads',
        content: response.data
      });
    });
  },

  updateNotepadField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      entry: 'notepad',
      collection: 'notepads',
      content: {[field]: value}
    });
    dispatch('saveNotepad');
  },

  saveNotepad: _.debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', { entry: 'notepad', saving: true });
    notepadsService
      .update(state.current.notepad.id, state.current.notepad)
      .then(_ => {
        commit('updateSavingStatus', { entry: 'notepad', saving: false });
      });
  }, 500),
  // ------------------------------- [Links] -------------------------------
  fetchLink({commit}, {id}) {
    linksService.get(id).then((response) => {
      commit('updateEntry', {
        entry: 'link',
        collection: 'links',
        content: response.data
      });
    });
  },

  updateLinkField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      entry: 'link',
      collection: 'links',
      content: {[field]: value}
    });
    dispatch('saveLink');
  },

  saveLink: _.debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', { entry: 'link', saving: true });
    linksService
      .update(state.current.link.id, state.current.link)
      .then(_ => {
        commit('updateSavingStatus', { entry: 'link', saving: false });
        dispatch('fetchLinks');
      });
  }, 500),

  publishLink({dispatch, commit}, payload) {
    linksService.publish(state.current.link.id).then(response => {
      commit('updateEntry', {
        entry: 'link',
        collection: 'links',
        content: response.data
      });
      dispatch('fetchLinks');
    });
  },

  unpublishLink({dispatch, commit}, payload) {
    linksService.unpublish(state.current.link.id).then(response => {
      commit('updateEntry', {
        entry: 'link',
        collection: 'links',
        content: response.data
      });
      dispatch('fetchLinks');
    });
  },

  deleteLink({dispatch}) {
    linksService.remove(state.current.link.id).then(_ => {
      dispatch('fetchLinks');
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

  updateEntry(state, payload) {
    state.current[payload.entry] = Object.assign(state.current[payload.entry], payload.content);
    const idx = state[payload.collection].items.findIndex((entry) => +entry.id === +state.current[payload.entry].id);
    if (idx === -1) return;
    Object.assign(state[payload.collection].items[idx], payload.content);
  },

  updateSavingStatus(state, payload) {
    state.saving[payload.entry] = payload.saving;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
