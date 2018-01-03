import api from '../api/request';

export default {
  index: () => api.get('/api/pages.json'),
  get: (id) => api.get(`/api/pages/${id}.json`),
  update: (id, page) => api.put(`/api/pages/${id}.json`, { page: page }),
};
