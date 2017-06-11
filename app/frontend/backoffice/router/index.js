import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router);

import LinksListView from '../views/LinksListView.vue';
import NotesListView from '../views/NotesListView.vue';

export default new Router({
  mode: 'history',
  scrollBehavior: () => ({y: 0}),
  routes: [
    // { path: '/top/:page(\\d+)?', component: createListView('top') },
    // { path: '/new/:page(\\d+)?', component: createListView('new') },
    // { path: '/show/:page(\\d+)?', component: createListView('show') },
    // { path: '/ask/:page(\\d+)?', component: createListView('ask') },
    // { path: '/job/:page(\\d+)?', component: createListView('job') },
    // { path: '/item/:id(\\d+)', component: ItemView },
    { path: '/bo/published-links', component: LinksListView },
    { path: '/bo/published-notes', component: NotesListView },
  ]
})
