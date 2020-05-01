<template>
  <div class='markdown-block-editor'>
    <div
        :gutter="10"
        v-for='(block, idx) in blocks'
        :key="`editor-block-${idx}`"
        class='markdown-block-editor__row'
    >
      <v-block
        :value='block.value'
        :type='block.type'
        :lock-type="lockType"
        :idx="idx"
        @input='onBlockInput(idx, $event)'
        @change-type='changeBlockType(idx, $event)'
        class='markdown-block-editor__block'
      />

      <div>
        <el-dropdown
            size="small"
            split-button
            type="primary"
            @click="appendBlockOnIdx(idx)"
            @command="executeCommand"
        >
          <i class='el-icon-plus' />  Block
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item :command="{ type: 'prepend', idx: idx }">Prepend block</el-dropdown-item>
            <el-dropdown-item :command="{ type: 'remove', idx: idx }">Remove block</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
  </div>
</template>

<script>
import Block from "./Block";

const defaultBlock = {
  type: 'markdown',
  value: ''
};

export default {
  props: {
    value: {
      type: Array,
      required: false,
      default: () => ([
        {...defaultBlock}
      ])
    },
    lockType: {
      type: Boolean,
      required: false,
      default: false
    }
  },
  data() {
    return {
      blocks: []
    }
  },
  components: {
    VBlock: Block
  },
  mounted() {
    setTimeout(() => {
      if(this.value) {
        this.blocks = this.value.map(a => Object.assign({}, a));
        return;
      }

      this.blocks = [{...defaultBlock}];
    }, 1000);
  },
  methods: {
    removeBlockOnIdx(idx) {
      this.blocks.splice(idx, 1);
      this.pushChanges();
    },
    prependBlockOnIdx(idx) {
      if(idx === 0) {
        this.blocks = [{...defaultBlock}, ...this.blocks];
        return;
      }

      this.blocks.splice(idx - 1, 0, {...defaultBlock});
    },
    appendBlockOnIdx(idx) {
      if(idx === this.blocks.length - 1) {
        this.blocks.push({...defaultBlock});
        return;
      }

      this.blocks.splice(idx + 1, 0, {...defaultBlock});
    },
    onBlockInput(idx, value) {
      this.blocks[idx] = Object.assign(this.blocks[idx], { value });
      this.pushChanges();
    },
    changeBlockType(idx, type) {
      this.blocks[idx] = Object.assign(this.blocks[idx], { type });
      this.pushChanges();
    },
    executeCommand({ type, idx }) {
      switch(type) {
        case 'prepend':
          this.prependBlockOnIdx(idx);
        break;
        case 'remove':
          this.removeBlockOnIdx(idx);
        break;
      }
    },
    pushChanges() {
      this.$emit('input', [...this.blocks].map(a => Object.assign({}, a)));
    }
  }
};
</script>

<style lang="scss">
.markdown-block-editor {
  &__row {
    display: flex;
    flex-direction: row;
    width: 100%;
  }

  &__block {
    margin-bottom: 4px;
    flex: 1;
    margin-right: 8px;
  }
}
</style>
