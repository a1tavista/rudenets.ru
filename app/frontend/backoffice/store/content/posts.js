import Post from "../models/post";
import debounce from 'lodash.debounce';
import postsService from '../../services/postsService';

const state = {
  current: new Post(),
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getCurrentPost: ({current}) => current,
  getDrafts: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((post) => !post.published)
    };
  },
  getPublished: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((post) => post.published)
    };
  },
};

const actions = {
  fetchPosts({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: postsService.index,
      collection: 'posts'
    });
  },

  newPost({commit}, payload) {
    commit('updateEntry', {
      collection: 'posts',
      content: new Post()
    });
  },

  fetchPost({commit}, {id}) {
    postsService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'posts',
        content: response.data
      });
    });
  },

  updatePostField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'posts',
      content: {[field]: value}
    });
    dispatch('savePost');
  },

  generatePostCover({commit, dispatch}, { shapesNumber, mode }) {
    return new Promise((resolve, reject) =>
      postsService.
        generateCoverImage(state.current.id, { shapesNumber, mode }).
        then(response => {
          resolve();
          dispatch('fetchPost', { id: state.current.id });
        }).catch((e) => reject(e))
    );
  },

  publishPost({dispatch, commit}, payload) {
    postsService.publish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'posts',
        content: response.data
      });
      dispatch('fetchPosts');
    });
  },

  unpublishPost({dispatch, commit}, payload) {
    postsService.unpublish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'posts',
        content: response.data
      });
      dispatch('fetchPosts');
    });
  },

  savePost: debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', {collection: 'posts', saving: true});

    const postState = Object.assign({}, state.current);
    delete postState.coverImageUrl;

    if (state.current.id === null) {
      postsService.create(postState).then(response => {
        commit('updateEntry', {
          collection: 'posts',
          content: {
            id: response.data.id
          }
        });
        commit('updateSavingStatus', {collection: 'posts', saving: false});
        dispatch('fetchPosts');
      });
    } else {
      postsService
        .update(state.current.id, postState)
        .then(_ => {
          commit('updateSavingStatus', {collection: 'posts', saving: false});
        });
    }
  }, 500),

  deletePost({dispatch}) {
    postsService.remove(state.current.id).then(_ => {
      dispatch('newPost');
      dispatch('fetchPosts');
    });
  },
};

export default {
  state,
  getters,
  actions
};
