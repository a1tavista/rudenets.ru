<script>
  import _ from 'lodash';

  export default {
    data() {
      return {
        textInput: "",
        answer: "",
        isURL: false,
        opengraph: {
          url: "",
          title: "",
          description: "",
          image: "",
          summary: ""
        }
      }
    },
    watch: {
      textInput: function (newInput) {
        this.isURL = false;
        if (this.isUrl(newInput)) {
          this.answer = "Это ссылка.";
          this.tryParseURL();
        } else {
          this.answer = "Это не ссылка.";
        }
      }
    },
    methods: {
      isUrl: function (text) {
        const regexp = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
        return regexp.test(text);
      },
      tryParseURL: _.debounce(
        function () {
          this.answer = "Обрабатываем информацию...";
          var vm = this;
          this.axios.get('/api/links/parse.json', {
              params: {
                url: vm.textInput
              }
            })
            .then(function (response) {
              if (response.data.success) {
                vm.answer = "";
                vm.isURL = true;
                vm.opengraph = Object.assign(vm.opengraph, response.data.opengraph);
              }
            })
            .catch(function (error) {
              vm.answer = 'Ошибка! ' + error
            })
        },
        3000
      ),
      saveLink: function () {
        this.answer = "Saving...";
        var vm = this;
        this.axios.post('/api/links', {
            link: vm.opengraph
          })
          .then(function (response) {
            vm.answer = "Ссылка успешно опубликована!"
          })
          .catch(function (error) {
            vm.answer = 'Ошибка! ' + error
          })
      }
    }
  }
</script>

<template>
  <div>
    <div class="entries-new">
      <input type="text" placeholder="Вставь URL или впиши название нового поста..." v-model="textInput">
      <pre class="entries-new__status">{{ answer }}</pre>
      <div class="entries-new__form" v-if="isURL">
        <div class="link">
          <div class="link__image">
            <img :src="opengraph.image">
          </div>
          <div class="link__content">
            <h4 class="link__title">
              <div class="link__icon"></div>
              <span>{{ opengraph.title }}</span>
            </h4>
            <p>{{ opengraph.description }}</p>
            <textarea placeholder="Комментарий" v-model="opengraph.summary"></textarea>
          </div>
        </div>
        <div class="entries-new__actions">
          <button @click="saveLink">Сохранить и опубликовать</button>
        </div>
      </div>
    </div>
  </div>
</template>
