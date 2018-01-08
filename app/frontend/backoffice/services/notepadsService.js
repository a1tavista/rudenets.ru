import api from '../api/request';

export default {
  index: () => api.get('/api/notepads.json'),
  get: (id) => api.get(`/api/notepads/${id}.json`),
  getCurrent: () => api.get(`/api/notepads/current.json`),
  update: (id, notepad) => api.put(`/api/notepads/${id}.json`, { notepad: notepad }),
};
