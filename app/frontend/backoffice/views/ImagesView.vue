<template>
  <div>
    <div class="header view__header">
      <h3 class="header__title">Изображения</h3>
    </div>
    <vue-dropzone
        ref="myVueDropzone"
        id="dropzone"
        :options="dropzoneOptions"
        @vdropzone-success="fetchImages()"
    />
    <div class="images-list">
      <figure v-for="image in images" class="images-list__item">
        <img :src="image.fileUrl" @click="copyUrl">
        <input type="text" :value="image.fileUrl">
      </figure>
    </div>
    <paginate
        :page-count="totalPages"
        :click-handler="fetchImages"
        :prev-text="'<'"
        :next-text="'>'"
        v-model="currentPage"
        :container-class="'pagination card'">
    </paginate>
  </div>
</template>

<script>
import Paginate from 'vuejs-paginate'
import imagesService from "../services/imagesService";
import vue2Dropzone from 'vue2-dropzone';

export default {
  data: () => ({
    images: [],
    totalCount: 0,
    totalPages: 1,
    currentPage: 1,
    dropzoneOptions: {
      url: '/api/images.json',
      thumbnailWidth: 150,
    }
  }),
  components: { Paginate, vueDropzone: vue2Dropzone },
  mounted() {
    this.fetchImages();
  },
  methods: {
    copyUrl(event) {
      const input = event.target.parentNode.lastChild;
      input.select();
      document.execCommand("copy");
    },
    fetchImages() {
      imagesService.index(this.currentPage).then(({ data }) => {
        this.images = data.images;
        this.totalCount = data.total;
        this.totalPages = data.totalPages;
      })
    }
  }
}
</script>
