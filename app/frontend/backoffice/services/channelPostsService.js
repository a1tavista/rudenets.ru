import api from '../api/request';

export default {
  index: () => api.get('/api/channel_posts.json'),
  get: (id) => api.get(`/api/channel_posts/${id}.json`),
  create: (post) =>  api.post('/api/channel_posts.json', { channel_post: post }),
  update: (id, post) => api.put(`/api/channel_posts/${id}.json`, { channel_post: post }),
  publish: (id) => api.post(`/api/channel_posts/${id}/publication.json`)
};
