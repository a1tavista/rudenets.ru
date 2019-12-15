import axios from 'axios';

const request = axios.create();

request.interceptors.request.use(config => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  config.headers['X-CSRF-Token'] = csrfToken;

  return config;
});

export default request;
