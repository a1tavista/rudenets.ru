import api from '../api/request';

export default {
  index: () => api.get('/api/posts.json'),
  get: (id) => api.get(`/api/posts/${id}.json`),
  create: (post) =>  api.post('/api/posts.json', { post: post }),
  update: (id, post) => api.put(`/api/posts/${id}.json`, { post: post }),
  publish: (id) => api.post(`/api/posts/${id}/publication.json`),
  unpublish: (id) => api.delete(`/api/posts/${id}/publication.json`),
  remove: (id) => api.delete(`/api/posts/${id}.json`),
  generateCoverImage: (id, options) => api.post(`/api/posts/${id}/cover_image/shaped.json`, options)
};
