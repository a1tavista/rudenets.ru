import debounce from 'lodash.debounce';
import postsService from '../../services/channelPostsService';
import ChannelPost from "../models/channelPost";

const state = {
  current: new ChannelPost(),
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getCurrentChannelPost: ({current}) => current,
  getChannelDrafts: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((post) => !post.published)
    };
  },
  getChannelPublished: ({items, isLoading}) => {
    return {
      isLoading: isLoading,
      items: items.filter((post) => post.published)
    };
  },
};

const actions = {
  fetchChannelPosts({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: postsService.index,
      collection: 'channelPosts'
    });
  },

  newChannelPost({commit}, payload) {
    commit('updateEntry', {
      collection: 'channelPosts',
      content: new ChannelPost()
    });
  },

  fetchChannelPost({commit}, {id}) {
    postsService.get(id).then((response) => {
      commit('updateEntry', {
        collection: 'channelPosts',
        content: response.data
      });
    });
  },

  updateChannelPostField({commit, dispatch}, {field, value}) {
    commit('updateEntry', {
      collection: 'channelPosts',
      content: {[field]: value}
    });
    dispatch('saveChannelPost');
  },

  publishChannelPost({dispatch, commit}, payload) {
    postsService.publish(state.current.id).then(response => {
      commit('updateEntry', {
        collection: 'channelPosts',
        content: response.data
      });
      dispatch('fetchChannelPosts');
    });
  },

  saveChannelPost: debounce(function ({commit, dispatch}) {
    commit('updateSavingStatus', {collection: 'channelPosts', saving: true});

    const postState = Object.assign({}, state.current);

    if (state.current.id === null) {
      postsService.create(postState).then(response => {
        commit('updateEntry', {
          collection: 'channelPosts',
          content: {
            id: response.data.id
          }
        });
        commit('updateSavingStatus', {collection: 'channelPosts', saving: false});
        dispatch('fetchChannelPosts');
      });
    } else {
      postsService
        .update(state.current.id, postState)
        .then(_ => {
          commit('updateSavingStatus', {collection: 'channelPosts', saving: false});
        });
    }
  }, 500)
};

export default {
  state,
  getters,
  actions
};
