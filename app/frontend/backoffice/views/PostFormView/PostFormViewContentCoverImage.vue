<template>
  <div>
    <el-upload
      class="upload-demo"
      :action="action"
      :on-preview="handlePreview"
      :on-remove="handleRemove"
      :before-remove="beforeRemove"
      :on-exceed="handleExceed"
      :file-list="fileList">
      <el-button size="small" type="primary">Загрузить изображение</el-button>
    </el-upload>
  </div>
</template>

<script>
import {mapGetters} from "vuex";

export default {
  props: {
    action: {
      required: true,
      type: String
    }
  },
  data() {
    return {
      fileList: []
    };
  },
  mounted() {
    setTimeout(() => {
      if(!!this.post.coverImageUrl.source)
        this.fileList.push({ name: 'Изображение для обложки поста', url: this.post.coverImageUrl.source });
      if(!!this.post.coverImageUrl.shaped)
        this.fileList.push({ name: 'Обложка поста', url: this.post.coverImageUrl.shaped });
    }, 1000)
  },
  computed: {
    ...mapGetters({
      post: 'getCurrentPost'
    }),
  },
  methods: {
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(`The limit is 3, you selected ${files.length} files this time, add up to ${files.length + fileList.length} totally`);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`Cancel the transfert of ${ file.name } ?`);
    }
  }
}
</script>
