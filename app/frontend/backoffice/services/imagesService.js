import api from '../api/request';

export default {
  index: (page) => api.get('/api/images.json', { params: { page } }),
};
