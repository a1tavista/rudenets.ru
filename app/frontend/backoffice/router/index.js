import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router);

import LinksListView from '../views/LinksListView.vue';
import NotesListView from '../views/NotesListView.vue';
import NoteFormView from '../views/NoteFormView.vue';

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
    { path: '/bo/notes/new', component: NoteFormView },
    { path: '/bo/media/new', component: NoteFormView },
    { path: '/bo/links/published', component: LinksListView },
    { path: '/bo/notes/published', component: NotesListView },
  ]
})
