import api from '../api/request';

export default {
  index: () => api.get('/api/links.json'),
  get: (id) => api.get(`/api/links/${id}.json`),
  update: (id, link) => api.put(`/api/links/${id}.json`, { link: link }),
  publish: (id) => api.put(`/api/links/${id}/publish.json`),
  unpublish: (id) => api.put(`/api/links/${id}/unpublish.json`),
  remove: (id) => api.delete(`/api/links/${id}.json`),
};
