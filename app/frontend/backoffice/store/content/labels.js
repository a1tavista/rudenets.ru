import labelsService from '../../services/labelsService';

const state = {
  isSaving: false,
  isLoading: false,
  items: []
};

const getters = {
  getLabels: ({items}) => items,
};

const actions = {
  fetchLabels({dispatch}, payload) {
    dispatch('fetchCollection', {
      serviceMethod: labelsService.index,
      collection: 'labels'
    });
  },
};

export default {
  state,
  getters,
  actions
};
