import api from '../api/request';

export default {
  index: () => api.get('/api/labels.json')
};
