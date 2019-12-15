import api from '../api/request';

export default {
  index: () => api.get('/api/links.json'),
  get: (id) => api.get(`/api/links/${id}.json`),
  update: (id, link) => api.put(`/api/links/${id}.json`, { link: link }),
  publish: (id) => api.post(`/api/links/${id}/publication.json`),
  unpublish: (id) => api.delete(`/api/links/${id}/publication.json`),
  remove: (id) => api.delete(`/api/links/${id}.json`),
};
