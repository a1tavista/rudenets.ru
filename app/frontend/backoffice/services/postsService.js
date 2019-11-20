import api from '../api/request';

export default {
  index: () => api.get('/api/posts.json'),
  get: (id) => api.get(`/api/posts/${id}.json`),
  create: (post) =>  api.post('/api/posts.json', { post: post }),
  update: (id, post) => api.put(`/api/posts/${id}.json`, { post: post }),
  publish: (id) => api.put(`/api/posts/${id}/publish.json`),
  unpublish: (id) => api.put(`/api/posts/${id}/unpublish.json`),
  remove: (id) => api.delete(`/api/posts/${id}.json`),
};
