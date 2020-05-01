<template>
  <div>
    <div class="weeks-grid">
      <div v-for="week in weeksPassed" class="weeks-grid__item weeks-grid__item_passed"></div>
      <div v-for="week in weeksComing" class="weeks-grid__item weeks-grid__item_upcoming"></div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      startDate: {
        required: false,
        type: Date
      },
      endDate: {
        required: false,
        type: Date
      }
    },
    data() {
      return {
        currentDate: new Date(),
        birthDate: this.startDate,
        targetDate: this.endDate
      };
    },
    computed: {
      weeksPassed() {
        let diff = (this.currentDate.getTime() - this.birthDate.getTime()) / 1000;
        diff /= (60 * 60 * 24 * 7);
        return Math.abs(Math.round(diff));
      },
      weeksComing() {
        let diff = (this.targetDate.getTime() - this.currentDate.getTime()) / 1000;
        diff /= (60 * 60 * 24 * 7);
        return Math.abs(Math.round(diff));
      }
    }
  }
</script>
