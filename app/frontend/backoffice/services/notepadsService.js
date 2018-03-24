import api from '../api/request';

export default {
  index: () => api.get('/api/notepads.json'),
  create: (notepad) => api.post('/api/notepads.json', { notepad: notepad }),
  tree: () => api.get('/api/notepads/tree.json'),
  get: (id) => api.get(`/api/notepads/${id}.json`),
  getCurrent: () => api.get(`/api/notepads/current.json`),
  update: (id, notepad) => api.put(`/api/notepads/${id}.json`, { notepad: notepad }),
};