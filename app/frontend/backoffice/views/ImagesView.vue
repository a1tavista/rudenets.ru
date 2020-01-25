<template>
  <div>
    <el-row>
      <el-page-header @back="$router.push({ path: '/' })" content="Галерея изображений" />
    </el-row>
    <el-card class='el-card_margin-bottom'>
      <images-list-view-uploader class="view__content" />
    </el-card>

    <el-row>
      <div class="images-list">
        <picture
          v-for="image in images"
          class="images-list__item"
          :style='`background-image: url(${image.optimizedUrl || image.originalUrl});`'
          @click="copyUrl(image.optimizedUrl || image.originalUrl)"
        >
          <div v-if="!image.optimizedUrl" class="images-list__alert">Необработанное</div>
        </picture>
      </div>
    </el-row>

    <el-row v-if="loadMoreAvailable">
      <el-button type="primary" @click="fetchNextPage">Загрузить ещё</el-button>
    </el-row>
  </div>
</template>

<script>
import Paginate from 'vuejs-paginate'
import imagesService from "../services/imagesService";
import ImagesListViewUploader from "./ImagesListView/ImagesListViewUploader";

export default {
  data() {
    return {
      images: [],
      totalCount: 0,
      totalPages: 1,
      currentPage: 0,
      per: 32
    }
  },
  components: { Paginate, ImagesListViewUploader },
  mounted() {
    this.fetchNextPage();
  },
  computed: {
    loadMoreAvailable() {
      return this.currentPage < this.totalPages;
    }
  },
  methods: {
    copyToClipboard(str) {
      const el = document.createElement('textarea');
      el.value = str;
      document.body.appendChild(el);
      el.select();
      document.execCommand('copy');
      document.body.removeChild(el);
    },
    copyUrl(url) {
      this.copyToClipboard(`
        <a href="${url}"
           data-description=""
           data-type="image"
           class="glightbox"
           style="background-image: url(${url});">
          <img src="${url}">
        </a>`)
    },
    fetchNextPage() {
      this.currentPage += 1;
      this.fetchImages(this.per);
    },
    fetchImages(per) {
      imagesService.index(this.currentPage, per).then(({ data }) => {
        this.images = this.images.concat(data.images);
        this.totalCount = data.total;
        this.totalPages = data.totalPages;
      })
    }
  }
}
</script>
