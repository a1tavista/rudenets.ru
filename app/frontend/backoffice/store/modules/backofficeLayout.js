const state = {
  widget: null,
  isWidgetOpened: false
};

const getters = {
  currentWidget: ({widget}) => widget,
  isWidgetOpened: ({isWidgetOpened}) => isWidgetOpened
};

const actions = {
  openWidget({commit}, payload) {
    commit('openWidget', payload);
  },
  closeWidget({commit}) {
    commit('closeWidget');
  }
};

const mutations = {
  openWidget(state, widgetName) {
    state.widget = widgetName;
    state.isWidgetOpened = true;
  },

  closeWidget(state) {
    state.widget = null;
    state.isWidgetOpened = false;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
