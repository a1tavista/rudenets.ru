<template>
  <div>
    <div class="weeks-grid">
      <div v-for="week in weeksPassed" class="week week-passed"></div>
      <div v-for="week in weeksComing" class="week week-upcoming"></div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentDate: new Date(),
      birthDate: new Date(1994,12,27),
      targetDate: new Date(2094,12,27),
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

<style>
.weeks-grid {
  counter-reset: year;

  max-width: 600px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(52, 1fr);
  grid-auto-rows: 1fr;
  grid-column-gap: 1px;
  grid-row-gap: 1px;
  position: relative;
}

.week {
  position: relative;
}

.week::after {
  position: absolute;
  left: calc(100% + 4px);
  top: 50%;
  transform: translateY(-50%);
  font-size: 12px;
  line-height: 1;
}

.week:nth-child(52)::after {
  content: 'Год';
}

.week:nth-child(520n)::after {
  content: counter(year);
}

.weeks-grid::before {
  content: '';
  width: 0;
  padding-bottom: 100%;
  grid-row: 1 / 1;
  grid-column: 1 / 1;
}

.weeks-grid::after {
  content: '';
  position: absolute;
  background: linear-gradient(0deg, rgba(255,255,255,0.9) 0%, rgba(255,255,255,0.0) 100%);
  bottom: 0;
  left: 0;
  right: 0;
  height: 200px;
}

.week:first-child {
  grid-row: 1 / 1;
  grid-column: 1 / 1;
}

.week:nth-child(52n) {
  counter-increment: year;
}

.week-passed {
  background: red;
}

.week-upcoming {
  background: darkgrey;
}
</style>
