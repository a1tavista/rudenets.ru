import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router);

import NoteFormView from '../views/NoteFormView.vue';
import LinkFormView from '../views/LinkFormView.vue';
import PageFormView from '../views/PageFormView.vue';
import CommonNoteView from '../views/CommonNoteView.vue';
import createNoteFormView from "../views/createNoteFormView";

export default new Router({
  mode: 'history',
  base: '/bo',
  scrollBehavior: () => ({y: 0}),
  routes: [
    // { path: '/top/:page(\\d+)?', component: createListView('top') },
    // { path: '/new/:page(\\d+)?', component: createListView('new') },
    // { path: '/show/:page(\\d+)?', component: createListView('show') },
    // { path: '/ask/:page(\\d+)?', component: createListView('ask') },
    // { path: '/job/:page(\\d+)?', component: createListView('job') },
    // { path: '/item/:id(\\d+)', component: ItemView },
    { path: '/', component: CommonNoteView },
    { path: '/notes/:id(\\d+)', component: NoteFormView },
    { path: '/notes/new', component: createNoteFormView("new") },
    { path: '/media/new', component: NoteFormView },
    { path: '/links/:id(\\d+)', component: LinkFormView },
    { path: '/pages/:id(\\d+)', component: PageFormView }
  ]
})
