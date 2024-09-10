<style scoped>
.wheel-container {
  position: relative;
  width: 200px;
  height: 200px;
  margin: 0 auto;
}

.wheel {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  border: 5px solid #000;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  transition: transform 3s ease-out;
}

.wheel.spinning {
  transform: rotate(1080deg); /* 3 full rotations */
}

.wheel-segment {
  width: 50%;
  height: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  transform-origin: center;
}

.wheel-segment:nth-child(1) {
  transform: rotate(0deg) translate(100%);
}
.wheel-segment:nth-child(2) {
  transform: rotate(36deg) translate(100%);
}
.wheel-segment:nth-child(3) {
  transform: rotate(72deg) translate(100%);
}
.wheel-segment:nth-child(4) {
  transform: rotate(108deg) translate(100%);
}
.wheel-segment:nth-child(5) {
  transform: rotate(144deg) translate(100%);
}
.wheel-segment:nth-child(6) {
  transform: rotate(180deg) translate(100%);
}
.wheel-segment:nth-child(7) {
  transform: rotate(216deg) translate(100%);
}
.wheel-segment:nth-child(8) {
  transform: rotate(252deg) translate(100%);
}
.wheel-segment:nth-child(9) {
  transform: rotate(288deg) translate(100%);
}
.wheel-segment:nth-child(10) {
  transform: rotate(324deg) translate(100%);
}

.arrow {
  position: absolute;
  top: -20px;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 0;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 20px solid red;
}
</style>

<script setup lang="ts">
import { ref } from "vue";
const props = defineProps<{ count: number }>();
const emit = defineEmits<{ inc: [{ value: number }] }>();
const diff = ref<string>("1");
const spinResult = ref<string | null>(null);
const isSpinning = ref<boolean>(false);

function spinWheel() {
  if (isSpinning.value) return;

  isSpinning.value = true;
  const prizes = ["🎉", "🎊", "🎈", "🎁", "🎂", "🍰", "🍦", "🍭", "🍬", "🍫"];
  const randomIndex = Math.floor(Math.random() * prizes.length);
  const prize = prizes[randomIndex];

  setTimeout(() => {
    spinResult.value = prize;
    isSpinning.value = false;
  }, 3000);
}
</script>

<template>
  Current countghjkl
  <div class="text-2xl text-bold">{{ props.count }}</div>
  <label class="block mt-8">Diff: </label>
  <input v-model="diff" class="mt-4" type="range" min="1" max="10" />

  <button
    @click="emit('inc', { value: parseInt(diff) })"
    class="mt-4 bg-black text-white rounded p-2 block"
  >
    Increase counter by {{ diff }}
  </button>
  <div class="spin-to-win mt-8">
    <div class="wheel-container">
      <div class="wheel" :class="{ spinning: isSpinning }">
        <div v-for="(prize, index) in 10" :key="index" class="wheel-segment">
          {{ prize }}
        </div>
      </div>
      <div class="arrow"></div>
    </div>
    <button
      @click="spinWheel"
      class="bg-green-500 text-white rounded p-2 block mt-4"
      :disabled="isSpinning"
    >
      Spin to Win
    </button>
    <div v-if="spinResult !== null" class="mt-4">You won: {{ spinResult }}</div>
  </div>
</template>
