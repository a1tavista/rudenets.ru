import api from '../api/request';

export default {
  index: (page, per) => api.get('/api/images.json', { params: { page, per } }),
  add: (file) => api.post('/api/images.json', { file }),
};
