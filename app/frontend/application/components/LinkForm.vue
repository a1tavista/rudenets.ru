<template>
  <div>
    <div class="share-link-form">
      <input type="text" placeholder="Вставьте URL для быстрой публикации" v-model="url">
      <pre class="share-link-form__status" v-if="status">{{ status }}</pre>
      <div class="share-link-form__form" v-if="showForm">
        <div class="link">
          <div class="link__image">
            <div><img :src="opengraph.imageUrl"></div>
            <div class="link__image-picker">
              <i class="material-icons md-48" @click="imageSelected -= 1">keyboard_arrow_left</i>
              <i class="material-icons md-48" @click="imageSelected += 1">keyboard_arrow_right</i>
            </div>
          </div>
          <div class="link__content">
            <div class='link__title-row'>
              <input type="text" v-model="opengraph.siteName" class='link__site-name' placeholder='Название сайта'>
              <input type="text" class='link__site-title' v-model='opengraph.title' placeholder='Заголовок'>
            </div>
            <textarea placeholder="Краткое описание" class="link__description" v-model="opengraph.description"></textarea>
            <blockquote class="link__summary">
              <h6>Комментарий:</h6>
              <textarea placeholder="Комментарий" v-model="opengraph.summary"></textarea>
            </blockquote>
          </div>
        </div>
        <div class="share-link-form__actions">
          <button @click="saveLink">Сохранить и опубликовать</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    url: "",
    status: "",
    opengraph: {},
    showForm: false,
    images: [],
    imageSelected: 0
  }),
  watch: {
    url(newInput) {
      if (this.isUrl(newInput)) {
        this.status = "Обнаружена ссылка. Подготовка к получению содержимого...";
        this.showForm = false;
        this.parseURL();
      } else {
        this.status = "Пожалуйста, укажите ссылку на ресурс.";
        this.showForm = false;
      }
    },
    imageSelected(newValue) {
      if(this.images.length > newValue && newValue >= 0) {
        this.selectImage(newValue);
      }
    }
  },
  methods: {
    isUrl(text) {
      const regexp = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
      return regexp.test(text);
    },
    parseURL() {
      this.status = "Получение содержимого ссылки...";
      this.axios.get('/api/links/new.json', { params: { url: this.url } })
        .then((response) => {
          this.status = "";
          this.showForm = true;
          const { url, title, siteName, description } = response.data;
          this.opengraph = { url, title, siteName, description, summary: '', imageUrl: null };
          this.images = response.data.images.map((v) => v.table);
          this.selectImage(0);
        })
        .catch((error) => {
          this.status = 'Ошибка! ' + error;
          this.showForm = true;
          this.opengraph = {
            url: this.url,
            title: '',
            siteName: '',
            description: '',
            summary: '',
            imageUrl: null
          }
        });
    },
    selectImage(position) {
      this.imageSelected = position;
      this.opengraph.imageUrl = this.images[position];
    },
    saveLink() {
      this.status = "Сохранение...";
      this.axios.post('/api/links.json', { link: this.opengraph })
        .then((response) => { this.status = "Ссылка успешно опубликована!" })
        .catch((error) => { this.status = 'Ошибка! ' + error })
    }
  }
}
</script>
